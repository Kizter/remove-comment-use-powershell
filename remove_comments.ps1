

$projectPath = "c:\Project"

function Remove-HtmlComments {
    param([string]$content)
    return $content -replace '<!--[\s\S]*?-->', ''
}

function Remove-JsSingleLineComments {
    param([string]$content)
    $lines = $content -split "`r`n"
    $result = @()
    
    foreach ($line in $lines) {
        if ($line -match '^\s*//') {
            continue
        }
        
        if ($line -match '(.+?)\s*//[^"''`]*$') {
            $beforeComment = $matches[1]
            if ($beforeComment -notmatch 'https?://') {
                $result += $beforeComment.TrimEnd()
                continue
            }
        }
        
        $result += $line
    }
    
    return ($result -join "`r`n")
}

function Remove-JsMultiLineComments {
    param([string]$content)
    return $content -replace '/\*[\s\S]*?\*/', ''
}

function Remove-CssComments {
    param([string]$content)
    return $content -replace '/\*[\s\S]*?\*/', ''
}

$files = Get-ChildItem -Path $projectPath -Recurse -Include *.html, *.js, *.css | Where-Object {
    $_.FullName -notmatch 'node_modules'
}

$processedCount = 0

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Cyan
    
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    if (!$content) {
        Write-Host "  - Skipped (empty file)" -ForegroundColor Gray
        continue
    }
    
    $originalLength = $content.Length
    
    switch ($file.Extension) {
        '.html' {
            $content = Remove-HtmlComments $content
        }
        '.js' {
            $content = Remove-JsMultiLineComments $content
            $content = Remove-JsSingleLineComments $content
        }
        '.css' {
            $content = Remove-CssComments $content
        }
    }
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    
    $newLength = $content.Length
    $saved = $originalLength - $newLength
    
    if ($saved -gt 0) {
        Write-Host "  OK - Removed $saved characters" -ForegroundColor Green
        $processedCount++
    }
    else {
        Write-Host "  - No comments found" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Completed! Processed $processedCount files." -ForegroundColor Green
