param(
    [switch]$ValidateOnly
)

$root = Split-Path -Parent $PSScriptRoot
$cleanScript = Join-Path $PSScriptRoot 'clean-actividad-markdown.ps1'

if (-not (Test-Path $cleanScript)) {
    Write-Error "Required script not found: $cleanScript"
    exit 1
}

$files = Get-ChildItem -Path $root -Filter 'actividad_6_*.md' -File |
    Sort-Object Name |
    ForEach-Object { $_.FullName }

if (-not $files -or $files.Count -eq 0) {
    Write-Warning 'No files matching actividad_6_*.md were found.'
    exit 0
}

if ($ValidateOnly) {
    & $cleanScript -Files $files -ValidateOnly
}
else {
    & $cleanScript -Files $files
}
