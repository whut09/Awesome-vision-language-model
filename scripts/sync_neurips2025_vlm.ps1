<#
Collect NeurIPS 2025 VLM papers from the official proceedings index.
The filter requires explicit VLM/MLLM/Vision-Language Model terminology and
excludes vision-language-action and vision-language-navigation work.
#>

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paper_categories.ps1')

$readmePath = Join-Path $PSScriptRoot '..\README.md'
$indexUrl = 'https://proceedings.neurips.cc/paper_files/paper/2025'
$paperPattern = '(?i)vision[- ]language[- ]models?|vision[- ]language[- ]foundation[- ]models?|large[- ]vision[- ]language|visual[- ]language[- ]models?|multimodal[- ]large[- ]language|multi-modal[- ]large[- ]language|multimodal[- ]llms?|multi-modal[- ]llms?|video[- ]llms?|video[- ]large[- ]language|\bVLMs?\b|\bMLLMs?\b'
$excludedPattern = '(?i)VLA|vision[- ]language[- ]action|vision[- ]language[- ]navigation|VLN'
$hallucinationPattern = '(?i)hallucin|semantic grounding errors'

function Get-NormalizedTitle {
    param([string]$Title)
    return ($Title -replace '[^a-zA-Z0-9]', '').ToLowerInvariant()
}

function Get-SectionName {
    param([string]$Title)

    if ($Title -match $hallucinationPattern) {
        return 'Hallucination Mitigation and Reliability'
    }
    if ($Title -match '(?i)benchmark|evaluat|safety|attack|jailbreak|adversarial|robust|bias|unlearn|privacy|security|backdoor|calibrat|diagnos|measure|judge') {
        return 'Evaluation and Reliability'
    }
    if ($Title -match '(?i)video|temporal|streaming|motion|spatio-temporal|4D|scene segmentation') {
        return 'Video-Language Models'
    }
    if ($Title -match '(?i)ground|segmentation|detection|locali[sz]|spatial|3D|point cloud|depth|pixel|region|referring|OCR') {
        return 'Grounding, Region, and Pixel Understanding'
    }
    if ($Title -match '(?i)pre-train|pretrain|prompt tuning|prompt learning|continual learning|domain adaptation|cross-modal alignment') {
        return 'Vision-Language Pre-training'
    }
    return 'Multimodal Large Language Models'
}

$content = Get-Content -Raw $readmePath
$existingTitles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
[regex]::Matches($content, '\*\*(?<title>[^*]+)\*\*') | ForEach-Object {
    [void]$existingTitles.Add((Get-NormalizedTitle $_.Groups['title'].Value))
}

$index = Invoke-WebRequest -Uri $indexUrl -UseBasicParsing -TimeoutSec 60
$papers = [regex]::Matches($index.Content, '(?is)<a title="paper title" href="(?<href>[^"]+-Abstract-Conference\.html)">(?<title>.*?)</a>') |
    ForEach-Object {
        [pscustomobject]@{
            Title = [System.Net.WebUtility]::HtmlDecode(($_.Groups['title'].Value -replace '\s+', ' ').Trim())
            Href = $_.Groups['href'].Value
        }
    } |
    Where-Object { $_.Title -match $paperPattern -and $_.Title -notmatch $excludedPattern } |
    Sort-Object Title

$newRows = @{}
foreach ($section in $PaperSections) {
    $newRows[$section] = [System.Collections.Generic.List[string]]::new()
}

$added = 0
foreach ($paper in $papers) {
    $normalizedTitle = Get-NormalizedTitle $paper.Title
    if ($existingTitles.Contains($normalizedTitle)) { continue }

    $section = Get-PaperSection $paper.Title
    $paperUrl = "https://proceedings.neurips.cc$($paper.Href)"
    $newRows[$section].Add("| 2025 | NeurIPS | **$($paper.Title)** | [[paper]($paperUrl)] | See paper |")
    [void]$existingTitles.Add($normalizedTitle)
    $added++
}

$lines = [System.Collections.Generic.List[string]](Get-Content $readmePath)
foreach ($section in $newRows.Keys) {
    if ($newRows[$section].Count -eq 0) { continue }

    $sectionIndex = $lines.IndexOf("### $section")
    if ($sectionIndex -lt 0) { throw "Missing section: $section" }
    $headerIndex = $sectionIndex + 1
    while ($lines[$headerIndex] -ne '| Year | Pub | Title | Links | Main Institution |') { $headerIndex++ }
    $lines.InsertRange($headerIndex + 2, [string[]]$newRows[$section])
}

for ($indexPosition = 0; $indexPosition -lt $lines.Count; $indexPosition++) {
    if ($lines[$indexPosition] -ne '| Year | Pub | Title | Links | Main Institution |') { continue }

    $rowStart = $indexPosition + 2
    $rowEnd = $rowStart
    while ($rowEnd -lt $lines.Count -and $lines[$rowEnd] -match '^\|\s*\d{4}\s*\|') { $rowEnd++ }
    $rows = @($lines.GetRange($rowStart, $rowEnd - $rowStart) | Sort-Object {
        $parts = $_ -split '\|'
        '{0:D4}|{1}' -f (9999 - [int]$parts[1].Trim()), $parts[3].ToLowerInvariant()
    })
    $lines.RemoveRange($rowStart, $rowEnd - $rowStart)
    $lines.InsertRange($rowStart, [string[]]$rows)
}

Set-Content -Path $readmePath -Value (($lines -join "`n").TrimEnd("`r", "`n")) -Encoding utf8
Write-Output "Candidates: $($papers.Count)"
Write-Output "Added: $added"
