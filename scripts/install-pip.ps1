# Install ClusterAudienceKit using pip (PowerShell)
# Usage: .\install-pip.ps1 [-Version "latest"]

param(
    [string]$Version = "latest"
)

Write-Host "🚀 Installing ClusterAudienceKit with pip..." -ForegroundColor Green
Write-Host "Python version: $(python --version)" -ForegroundColor Blue

if ($Version -eq "latest") {
    Write-Host "📦 Installing latest version from PyPI..." -ForegroundColor Cyan
    python -m pip install --upgrade clusteraudiencekit
} else {
    Write-Host "📦 Installing version $Version..." -ForegroundColor Cyan
    python -m pip install "clusteraudiencekit==$Version"
}

Write-Host ""
Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Verify installation:" -ForegroundColor Yellow
python -c "from clusteraudiencekit import AudienceSegmenter; print('✅ ClusterAudienceKit imported successfully!')"

Write-Host ""
Write-Host "📚 Next steps:" -ForegroundColor Blue
Write-Host "1. Check the documentation: https://github.com/Mullassery/clusteraudiencekit"
Write-Host "2. Run examples: python examples/basic_segmentation.py"
Write-Host "3. Import and use: from clusteraudiencekit import AudienceSegmenter"
