# Install AudiencePro using pip (PowerShell)
# Usage: .\install-pip.ps1 [-Version "latest"]

param(
    [string]$Version = "latest"
)

Write-Host "🚀 Installing AudiencePro with pip..." -ForegroundColor Green
Write-Host "Python version: $(python --version)" -ForegroundColor Blue

if ($Version -eq "latest") {
    Write-Host "📦 Installing latest version from PyPI..." -ForegroundColor Cyan
    python -m pip install --upgrade audience-pro
} else {
    Write-Host "📦 Installing version $Version..." -ForegroundColor Cyan
    python -m pip install "audience-pro==$Version"
}

Write-Host ""
Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Verify installation:" -ForegroundColor Yellow
python -c "from audience_pro import AudienceSegmenter; print('✅ AudiencePro imported successfully!')"

Write-Host ""
Write-Host "📚 Next steps:" -ForegroundColor Blue
Write-Host "1. Check the documentation: https://github.com/Mullassery/AudiencePro"
Write-Host "2. Run examples: python examples/basic_segmentation.py"
Write-Host "3. Import and use: from audience_pro import AudienceSegmenter"
