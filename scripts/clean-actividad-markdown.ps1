param(
    [string[]]$Files,
    [int]$Start = 0,
    [int]$End = 24,
    [switch]$ValidateOnly
)

$patternWeb = '\[web:[^\]]+\]'
$patternIssues = '\[web:[^\]]+\]|(?<=\S) {2,}(?=\S)| {2,}$|^\s+$'

function Get-FileEncodingAndContent {
    param([string]$Path)

    $bytes = [System.IO.File]::ReadAllBytes($Path)

    if ($bytes.Length -ge 4 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE -and $bytes[2] -eq 0x00 -and $bytes[3] -eq 0x00) {
        $enc = [System.Text.Encoding]::UTF32
    }
    elseif ($bytes.Length -ge 4 -and $bytes[0] -eq 0x00 -and $bytes[1] -eq 0x00 -and $bytes[2] -eq 0xFE -and $bytes[3] -eq 0xFF) {
        $enc = [System.Text.Encoding]::GetEncoding('utf-32BE')
    }
    elseif ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $enc = [System.Text.UTF8Encoding]::new($true)
    }
    elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE) {
        $enc = [System.Text.Encoding]::Unicode
    }
    elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFE -and $bytes[1] -eq 0xFF) {
        $enc = [System.Text.Encoding]::BigEndianUnicode
    }
    else {
        # No BOM: try strict UTF-8 first, then fallback to Windows-1252.
        try {
            $utf8Strict = [System.Text.UTF8Encoding]::new($false, $true)
            $null = $utf8Strict.GetString($bytes)
            $enc = [System.Text.UTF8Encoding]::new($false)
        }
        catch {
            $enc = [System.Text.Encoding]::GetEncoding(1252)
        }
    }

    return [pscustomobject]@{
        Encoding = $enc
        Content  = $enc.GetString($bytes)
    }
}

function Test-HasPendingIssues {
    param([string]$Text)

    $lines = $Text -split "`r?`n", 0, 'SimpleMatch'
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match $patternIssues) {
            return $true
        }
    }

    return $false
}

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
        $fileInfo = Get-FileEncodingAndContent -Path $path
        $content = $fileInfo.Content
        $encoding = $fileInfo.Encoding
        $newline = if ($content -match "`r`n") { "`r`n" } else { "`n" }

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

        $newContent = [string]::Join($newline, $normalized)
        [System.IO.File]::WriteAllText($path, $newContent, $encoding)

        $updatedCount++
        Write-Output "UPDATED $path"
    }
}

$issues = @()
foreach ($path in $Files) {
    if (Test-Path $path) {
        $fileInfo = Get-FileEncodingAndContent -Path $path
        if (Test-HasPendingIssues -Text $fileInfo.Content) {
            $issues += $path
        }
    }
}

if ($issues.Count -eq 0) {
    Write-Output 'OK - no pending issues.'
}
else {
    Write-Output 'Found issues:'
    $issues | ForEach-Object { $_ }
}

if (-not $ValidateOnly) {
    Write-Output "Processed files: $updatedCount"
}
