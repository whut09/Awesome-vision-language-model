<#
Collect CVPR main-track VLM papers from the official CVF Open Access page.
The filter requires an explicit VLM/MLLM/Vision-Language Model term in the
paper title and intentionally excludes VLA and VLN papers.
#>

param(
    [ValidateSet(2025, 2026)]
    [int]$Year = 2026
)

$ErrorActionPreference = 'Stop'

$readmePath = Join-Path $PSScriptRoot '..\README.md'
$cvprIndexUrl = "https://openaccess.thecvf.com/CVPR${Year}?day=all"
$paperPattern = '(?i)vision[-_]language[-_]models?|vision[-_]language[-_]foundation[-_]models?|large[-_]vision[-_]language|visual[-_]language[-_]models?|multimodal[-_]large[-_]language|multi-modal[-_]large[-_]language|multimodal[-_]llms?|multi-modal[-_]llms?|video[-_]llms?|video[-_]large[-_]language|(?:^|[-_])VLMs?(?:[-_]|$)|(?:^|[-_])MLLMs?(?:[-_]|$)'
$excludedPattern = '(?i)vision[-_]language[-_]action|(?:^|[-_])VLA(?:s)?(?:[-_]|$)|vision[-_]language[-_]navigation|(?:^|[-_])VLN(?:s)?(?:[-_]|$)'

function Get-CitationTitle {
    param([string]$Url)

    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try {
            $page = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 30
            $title = ([regex]::Match($page.Content, '<meta name="citation_title" content="([^"]+)"')).Groups[1].Value
            if (-not [string]::IsNullOrWhiteSpace($title)) {
                return [System.Net.WebUtility]::HtmlDecode($title)
            }
        } catch {
            if ($attempt -eq 3) { throw }
        }
    }

    throw "No citation title found at $Url"
}

function Get-SectionName {
    param([string]$Title)

    if ($Title -match '(?i)hallucin|semantic grounding errors') {
        return 'Hallucination Mitigation and Reliability'
    }
    if ($Title -match '(?i)benchmark|evaluat|hallucinat|safety|attack|jailbreak|adversarial|robust|bias|unlearn|privacy|security|backdoor|calibrat|diagnos|measure|judge') {
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
$existingSlugs = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
[regex]::Matches($content, "CVPR$Year/(?:html|papers)/(?<slug>[^/]+?)_CVPR_${Year}_paper") | ForEach-Object {
    [void]$existingSlugs.Add($_.Groups['slug'].Value)
}

$index = Invoke-WebRequest -Uri $cvprIndexUrl -UseBasicParsing -TimeoutSec 45
$hrefs = $index.Links |
    Where-Object {
        $_.href -match "^/content/CVPR$Year/papers/.+_CVPR_${Year}_paper\.pdf$" -and
        $_.href -match $paperPattern -and
        $_.href -notmatch $excludedPattern
    } |
    Select-Object -ExpandProperty href -Unique |
    Sort-Object

$newRows = @{}
foreach ($section in @(
    'Vision-Language Pre-training',
    'Multimodal Large Language Models',
    'Grounding, Region, and Pixel Understanding',
    'Video-Language Models',
    'Hallucination Mitigation and Reliability',
    'Evaluation and Reliability'
)) {
    $newRows[$section] = [System.Collections.Generic.List[string]]::new()
}

$added = 0
foreach ($href in $hrefs) {
    $slug = ([regex]::Match($href, "/papers/(?<slug>.+)_CVPR_${Year}_paper\.pdf`$")).Groups['slug'].Value
    if ($existingSlugs.Contains($slug)) { continue }

    $paperUrl = "https://openaccess.thecvf.com$href" -replace '/papers/', '/html/' -replace '\.pdf$', '.html'
    $title = Get-CitationTitle $paperUrl
    $section = Get-SectionName $title
    $newRows[$section].Add("| $Year | CVPR | **$title** | [[paper]($paperUrl)] | See paper |")
    $added++
}

$lines = [System.Collections.Generic.List[string]](Get-Content $readmePath)
foreach ($section in $newRows.Keys) {
    if ($newRows[$section].Count -eq 0) { continue }

    $sectionIndex = $lines.IndexOf("### $section")
    if ($sectionIndex -lt 0) { throw "Missing section: $section" }
    $headerIndex = $sectionIndex + 1
    while ($lines[$headerIndex] -ne '| Year | Pub | Title | Links | Main Institution |') { $headerIndex++ }
    $insertIndex = $headerIndex + 2
    $lines.InsertRange($insertIndex, [string[]]$newRows[$section])
}

# Keep hallucination work discoverable even when older entries predate this section.
$hallucinationRows = [System.Collections.Generic.List[string]]::new()
for ($lineIndex = $lines.Count - 1; $lineIndex -ge 0; $lineIndex--) {
    if ($lines[$lineIndex] -match '^\|\s*\d{4}\s*\|' -and $lines[$lineIndex] -match '(?i)hallucin|semantic grounding errors') {
        $hallucinationRows.Add($lines[$lineIndex])
        $lines.RemoveAt($lineIndex)
    }
}
if ($hallucinationRows.Count -gt 0) {
    $sectionIndex = $lines.IndexOf('### Hallucination Mitigation and Reliability')
    if ($sectionIndex -lt 0) { throw 'Missing hallucination section' }
    $headerIndex = $sectionIndex + 1
    while ($lines[$headerIndex] -ne '| Year | Pub | Title | Links | Main Institution |') { $headerIndex++ }
    $lines.InsertRange($headerIndex + 2, [string[]]$hallucinationRows)
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

Set-Content -Path $readmePath -Value $lines -Encoding utf8
Write-Output "Candidates: $($hrefs.Count)"
Write-Output "Added: $added"
