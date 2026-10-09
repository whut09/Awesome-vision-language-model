<# Collect ICML 2026 VLM papers from the official PMLR proceedings volume. #>

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paper_categories.ps1')
$readmePath = Join-Path $PSScriptRoot '..\README.md'
$indexUrl = 'https://proceedings.mlr.press/v306/'
$paperPattern = '(?i)vision[- ]language[- ]models?|vision[- ]language[- ]foundation[- ]models?|large[- ]vision[- ]language|visual[- ]language[- ]models?|multimodal[- ]large[- ]language|multi-modal[- ]large[- ]language|multimodal[- ]llms?|multi-modal[- ]llms?|video[- ]llms?|video[- ]large[- ]language|\bVLMs?\b|\bMLLMs?\b'
$excludedPattern = '(?i)VLA|vision[- ]language[- ]action|vision[- ]language[- ]navigation|VLN'

function Get-NormalizedTitle { param([string]$Title) return ($Title -replace '[^a-zA-Z0-9]', '').ToLowerInvariant() }

$content = Get-Content -Raw $readmePath
$existingTitles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
[regex]::Matches($content, '\*\*(?<title>[^*]+)\*\*') | ForEach-Object { [void]$existingTitles.Add((Get-NormalizedTitle $_.Groups['title'].Value)) }
$index = Invoke-WebRequest -Uri $indexUrl -UseBasicParsing -TimeoutSec 60
$papers = [regex]::Matches($index.Content, '(?is)<div class="paper">\s*<p class="title">(?<title>.*?)</p>.*?<a href="(?<href>https://proceedings\.mlr\.press/v306/[^"]+\.html)">abs</a>') |
    ForEach-Object { [pscustomobject]@{ Title = [System.Net.WebUtility]::HtmlDecode(($_.Groups['title'].Value -replace '<[^>]+>', '' -replace '\s+', ' ').Trim()); Href = $_.Groups['href'].Value } } |
    Where-Object { $_.Title -match $paperPattern -and $_.Title -notmatch $excludedPattern } |
    Sort-Object Title

$sections = $PaperSections
$newRows = @{}
foreach ($section in $sections) { $newRows[$section] = [System.Collections.Generic.List[string]]::new() }
$added = 0
foreach ($paper in $papers) {
    $normalizedTitle = Get-NormalizedTitle $paper.Title
    if ($existingTitles.Contains($normalizedTitle)) { continue }
    $newRows[(Get-PaperSection $paper.Title)].Add("| 2026 | ICML | **$($paper.Title)** | [[paper]($($paper.Href))] | See paper |")
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
Set-Content -Path $readmePath -Value (($lines -join "`n").TrimEnd("`r", "`n")) -Encoding utf8
Write-Output "Candidates: $($papers.Count)"
Write-Output "Added: $added"
