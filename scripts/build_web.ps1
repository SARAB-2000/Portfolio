param(
    [string]$BaseHref = "/"
)

Write-Host "Building Flutter web (base-href: $BaseHref)..." -ForegroundColor Cyan
flutter pub get
flutter gen-l10n
flutter build web --release --base-href $BaseHref

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build complete! Output: build/web" -ForegroundColor Green
} else {
    Write-Host "Build failed." -ForegroundColor Red
    exit 1
}
