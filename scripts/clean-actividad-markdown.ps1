param(
    [string[]]$Files,
    [int]$Start = 12,
    [int]$End = 24,
    [switch]$ValidateOnly
)

$patternWeb = '\[web:[^\]]+\]'
$patternIssues = '\[web:[^\]]+\]|(?<=\S) {2,}(?=\S)| {2,}$|^\s+$'

if (-not $Files -or $Files.Count -eq 0) {
    $Files = $Start..$End | ForEach-Object { "actividad_6_$_.md" }
}

$updatedCount = 0

foreach ($path in $Files) {
    if (-not (Test-Path $path)) {
        Write-Warning "Missing file: $path"
        continue
    }

    if (-not $ValidateOnly) {
        $content = Get-Content -Raw -Path $path
        $content = [regex]::Replace($content, $patternWeb, '')

        $lines = $content -split "`r?`n"
        $normalized = foreach ($line in $lines) {
            if ($line -match '^\s*$') {
                ''
                continue
            }

            if ($line -match '^(\s*)(.*)$') {
                $indent = $matches[1]
                $rest = $matches[2] -replace ' {2,}', ' '
                $rest = $rest.TrimEnd()
                "$indent$rest"
            }
            else {
                $line.TrimEnd()
            }
        }

        Set-Content -Path $path -Value $normalized -Encoding utf8
        $updatedCount++
        Write-Output "UPDATED $path"
    }
}

$issues = @()
foreach ($path in $Files) {
    if (Test-Path $path) {
        $matches = Select-String -Path $path -Pattern $patternIssues
        if ($matches) {
            $issues += $matches
        }
    }
}

if ($issues.Count -eq 0) {
    Write-Output 'OK - no pending issues.'
}
else {
    Write-Output 'Found issues:'
    $issues | ForEach-Object { "{0}:{1}: {2}" -f $_.Path, $_.LineNumber, $_.Line }
}

if (-not $ValidateOnly) {
    Write-Output "Processed files: $updatedCount"
}
