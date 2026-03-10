# Fix Polish characters in ESP32-HAM-CLOCK.ino
# This script fixes mojibaked Polish diacritical marks

$file = "C:\Users\biuro\OneDrive\Dokumenty\PlatformIO\Projects\ESP32-HAM-CLOCK\src\ESP32-HAM-CLOCK.ino"
$content = Get-Content $file -Raw

# Map of corrupted sequences to correct Polish characters
$fixes = @(
    @{ old = "Ă""; new = "ó" },
    @{ old = "Ĺ‚"; new = "ł" },
    @{ old = "Ĺ›"; new = "ś" },
    @{ old = "Ä‡"; new = "ć" },
    @{ old = "Ä™"; new = "ę" },
    @{ old = "Ä…"; new = "ą" },
    @{ old = "Ĺ„"; new = "ń" },
    @{ old = "Ĺ‚"; new = "ł" },
    @{ old = "Ĺş"; new = "ź" },
    @{ old = "Ĺź"; new = "ż" }
)

# Apply replacements
foreach ($fix in $fixes) {
    $content = $content -replace [Regex]::Escape($fix.old), $fix.new
    Write-Host "Fixed: $($fix.old) -> $($fix.new)"
}

# Save the file with UTF-8 encoding
Set-Content -Path $file -Value $content -Encoding UTF8
Write-Host "File fixed and saved"
