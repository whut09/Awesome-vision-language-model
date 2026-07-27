<# Rebuild the README paper tables using the shared detailed category rules. #>

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paper_categories.ps1')

$readmePath = Join-Path $PSScriptRoot '..\README.md'
$content = Get-Content -Raw $readmePath
$tableMatch = [regex]::Match($content, '(?s)<!-- PAPER_TABLES:START -->(?<tables>.*?)<!-- PAPER_TABLES:END -->')
if (-not $tableMatch.Success) { throw 'Paper-table markers not found' }

$rows = [regex]::Matches($tableMatch.Groups['tables'].Value, '(?m)^\|\s*\d{4}\s*\|.*$') | ForEach-Object { $_.Value }
$categorizedRows = @{}
foreach ($section in $PaperSections) { $categorizedRows[$section] = [System.Collections.Generic.List[string]]::new() }
foreach ($row in $rows) {
    $title = ([regex]::Match($row, '\*\*(?<title>[^*]+)\*\*')).Groups['title'].Value
    if ([string]::IsNullOrWhiteSpace($title)) { throw "Unable to parse title: $row" }
    $categorizedRows[(Get-PaperSection $title)].Add($row)
}

$blocks = [System.Collections.Generic.List[string]]::new()
foreach ($section in $PaperSections) {
    $blocks.Add("### $section")
    $blocks.Add('| Year | Pub | Title | Links | Main Institution |')
    $blocks.Add('|:---:|:---:|:---|:---:|:---:|')
    $sortedRows = $categorizedRows[$section] | Sort-Object {
        $parts = $_ -split '\|'
        '{0:D4}|{1}' -f (9999 - [int]$parts[1].Trim()), $parts[3].ToLowerInvariant()
    }
    foreach ($row in $sortedRows) { $blocks.Add($row) }
    $blocks.Add('')
}

$replacement = "<!-- PAPER_TABLES:START -->`n" + ($blocks -join "`n") + '<!-- PAPER_TABLES:END -->'
$updated = $content.Substring(0, $tableMatch.Index) + $replacement + $content.Substring($tableMatch.Index + $tableMatch.Length)
Set-Content -Path $readmePath -Value $updated.TrimEnd("`r", "`n") -Encoding utf8
Write-Output "Reclassified: $($rows.Count) papers"
