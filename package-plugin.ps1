# Packaging script for Material Theme Plugin for OJS deployment
$ErrorActionPreference = "Stop"

$themeDir = $PSScriptRoot
$pluginName = "material"
$zipName = "$pluginName-v3.1.0-4.tar.gz"
$distFolder = "$themeDir\dist-plugin"
$pluginSubDir = "$distFolder\$pluginName"

Write-Host "1. Building minified production Tailwind CSS..." -ForegroundColor Cyan
npm run build:css

Write-Host "2. Preparing clean plugin staging directory..." -ForegroundColor Cyan
if (Test-Path $distFolder) { Remove-Item -Path $distFolder -Recurse -Force }
New-Item -ItemType Directory -Path $pluginSubDir -Force | Out-Null

Write-Host "3. Copying production theme files..." -ForegroundColor Cyan
$includePaths = @(
    "MaterialThemePlugin.php",
    "index.php",
    "version.xml",
    "settings.xml",
    "templates",
    "styles/dist",
    "js",
    "resources",
    "fonts",
    "locale",
    "docs",
    "package.json",
    "README.md",
    "COPYING"
)

foreach ($item in $includePaths) {
    $src = Join-Path $themeDir $item
    if (Test-Path $src) {
        $dest = Join-Path $pluginSubDir $item
        $parent = Split-Path $dest -Parent
        if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        Copy-Item -Path $src -Destination $dest -Recurse -Force
    }
}

Write-Host "4. Creating release archive ($zipName)..." -ForegroundColor Cyan
Set-Location $distFolder
tar -czf "$themeDir\$zipName" $pluginName
Set-Location $themeDir
Remove-Item -Path $distFolder -Recurse -Force

Write-Host "SUCCESS! Release archive created at:" -ForegroundColor Green
Write-Host "$themeDir\$zipName" -ForegroundColor Yellow
