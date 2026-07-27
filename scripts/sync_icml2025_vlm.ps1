<# Collect ICML 2025 VLM papers from the official PMLR proceedings volume. #>

$ErrorActionPreference = 'Stop'
$readmePath = Join-Path $PSScriptRoot '..\README.md'
$indexUrl = 'https://proceedings.mlr.press/v267/'
$paperPattern = '(?i)vision[- ]language[- ]models?|vision[- ]language[- ]foundation[- ]models?|large[- ]vision[- ]language|visual[- ]language[- ]models?|multimodal[- ]large[- ]language|multi-modal[- ]large[- ]language|multimodal[- ]llms?|multi-modal[- ]llms?|video[- ]llms?|video[- ]large[- ]language|\bVLMs?\b|\bMLLMs?\b'
$excludedPattern = '(?i)VLA|vision[- ]language[- ]action|vision[- ]language[- ]navigation|VLN'

function Get-NormalizedTitle { param([string]$Title) return ($Title -replace '[^a-zA-Z0-9]', '').ToLowerInvariant() }
function Get-SectionName {
    param([string]$Title)
    if ($Title -match '(?i)hallucin|semantic grounding errors') { return 'Hallucination Mitigation and Reliability' }
    if ($Title -match '(?i)benchmark|evaluat|safety|attack|jailbreak|adversarial|robust|bias|unlearn|privacy|security|backdoor|calibrat|diagnos|measure|judge') { return 'Evaluation and Reliability' }
    if ($Title -match '(?i)video|temporal|streaming|motion|spatio-temporal|4D|scene segmentation') { return 'Video-Language Models' }
    if ($Title -match '(?i)ground|segmentation|detection|locali[sz]|spatial|3D|point cloud|depth|pixel|region|referring|OCR') { return 'Grounding, Region, and Pixel Understanding' }
    if ($Title -match '(?i)pre-train|pretrain|prompt tuning|prompt learning|continual learning|domain adaptation|cross-modal alignment') { return 'Vision-Language Pre-training' }
    return 'Multimodal Large Language Models'
}

$content = Get-Content -Raw $readmePath
$existingTitles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
[regex]::Matches($content, '\*\*(?<title>[^*]+)\*\*') | ForEach-Object { [void]$existingTitles.Add((Get-NormalizedTitle $_.Groups['title'].Value)) }
$index = Invoke-WebRequest -Uri $indexUrl -UseBasicParsing -TimeoutSec 60
$papers = [regex]::Matches($index.Content, '(?is)<div class="paper">\s*<p class="title">(?<title>.*?)</p>.*?<a href="(?<href>https://proceedings\.mlr\.press/v267/[^"]+\.html)">abs</a>') |
    ForEach-Object { [pscustomobject]@{ Title = [System.Net.WebUtility]::HtmlDecode(($_.Groups['title'].Value -replace '<[^>]+>', '' -replace '\s+', ' ').Trim()); Href = $_.Groups['href'].Value } } |
    Where-Object { $_.Title -match $paperPattern -and $_.Title -notmatch $excludedPattern } |
    Sort-Object Title

$sections = @('Vision-Language Pre-training', 'Multimodal Large Language Models', 'Grounding, Region, and Pixel Understanding', 'Video-Language Models', 'Hallucination Mitigation and Reliability', 'Evaluation and Reliability')
$newRows = @{}
foreach ($section in $sections) { $newRows[$section] = [System.Collections.Generic.List[string]]::new() }
$added = 0
foreach ($paper in $papers) {
    $normalizedTitle = Get-NormalizedTitle $paper.Title
    if ($existingTitles.Contains($normalizedTitle)) { continue }
    $newRows[(Get-SectionName $paper.Title)].Add("| 2025 | ICML | **$($paper.Title)** | [[paper]($($paper.Href))] | See paper |")
    [void]$existingTitles.Add($normalizedTitle)
    $added++
}

$lines = [System.Collections.Generic.List[string]](Get-Content $readmePath)
foreach ($section in $sections) {
    if ($newRows[$section].Count -eq 0) { continue }
    $sectionIndex = $lines.IndexOf("### $section")
    if ($sectionIndex -lt 0) { throw "Missing section: $section" }
    $headerIndex = $sectionIndex + 1
    while ($lines[$headerIndex] -ne '| Year | Pub | Title | Links | Main Institution |') { $headerIndex++ }
    $lines.InsertRange($headerIndex + 2, [string[]]$newRows[$section])
}
for ($position = 0; $position -lt $lines.Count; $position++) {
    if ($lines[$position] -ne '| Year | Pub | Title | Links | Main Institution |') { continue }
    $rowStart = $position + 2; $rowEnd = $rowStart
    while ($rowEnd -lt $lines.Count -and $lines[$rowEnd] -match '^\|\s*\d{4}\s*\|') { $rowEnd++ }
    $rows = @($lines.GetRange($rowStart, $rowEnd - $rowStart) | Sort-Object { $parts = $_ -split '\|'; '{0:D4}|{1}' -f (9999 - [int]$parts[1].Trim()), $parts[3].ToLowerInvariant() })
    $lines.RemoveRange($rowStart, $rowEnd - $rowStart)
    $lines.InsertRange($rowStart, [string[]]$rows)
}
Set-Content -Path $readmePath -Value $lines -Encoding utf8
Write-Output "Candidates: $($papers.Count)"
Write-Output "Added: $added"
