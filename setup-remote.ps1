# Setup Git remote and push to GitHub
# Make sure Git is installed first

Write-Host "Checking Git installation..." -ForegroundColor Yellow

# Check if Git is available
$gitAvailable = $false
try {
    $null = git --version 2>&1
    $gitAvailable = $true
    Write-Host "Git found!" -ForegroundColor Green
} catch {
    Write-Host "Git not found. Please install Git from https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

if (-not $gitAvailable) {
    Write-Host "Git not available. Please install Git first." -ForegroundColor Red
    exit 1
}

Write-Host "`nInitializing Git repository..." -ForegroundColor Yellow

# Initialize git if not exists
if (-not (Test-Path ".git")) {
    git init
    Write-Host "Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "Git repository already exists" -ForegroundColor Green
}

Write-Host "`nRemoving old remotes..." -ForegroundColor Yellow

# Remove old remotes
$remotes = git remote 2>&1
if ($remotes -and $remotes.Count -gt 0) {
    foreach ($remote in $remotes) {
        if ($remote -notmatch "fatal") {
            git remote remove $remote
            Write-Host "Removed remote: $remote" -ForegroundColor Green
        }
    }
} else {
    Write-Host "No old remotes to remove" -ForegroundColor Gray
}

Write-Host "`nAdding new remote..." -ForegroundColor Yellow

# Add new remote
git remote add origin https://github.com/LongNguyen81-bidv/Library_vibeCode.git
Write-Host "Added remote: origin -> https://github.com/LongNguyen81-bidv/Library_vibeCode.git" -ForegroundColor Green

Write-Host "`nAdding all files..." -ForegroundColor Yellow
git add .

Write-Host "`nCommitting..." -ForegroundColor Yellow
git commit -m "Initial commit"

Write-Host "`nChecking current branch..." -ForegroundColor Yellow
$currentBranch = git branch --show-current 2>&1
if (-not $currentBranch -or $currentBranch -match "fatal") {
    Write-Host "No branch found, creating main branch..." -ForegroundColor Yellow
    git branch -M main
} elseif ($currentBranch -ne "main") {
    Write-Host "Current branch is: $currentBranch. Renaming to main..." -ForegroundColor Yellow
    git branch -M main
} else {
    Write-Host "Already on main branch" -ForegroundColor Green
}

Write-Host "`nPushing to GitHub..." -ForegroundColor Yellow
Write-Host "Note: You may need to authenticate with GitHub" -ForegroundColor Yellow

# Try to push
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nSuccess! Pushed to https://github.com/LongNguyen81-bidv/Library_vibeCode" -ForegroundColor Green
} else {
    Write-Host "`nPush failed. You may need to:" -ForegroundColor Yellow
    Write-Host "1. Authenticate with GitHub (Personal Access Token)" -ForegroundColor Yellow
    Write-Host "2. Or run: git push -u origin main --force" -ForegroundColor Yellow
}

Write-Host "`nDone!" -ForegroundColor Green

