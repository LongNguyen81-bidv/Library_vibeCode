# Script để thiết lập Git và push lên repository mới
# Chạy script này sau khi đã cài đặt Git

Write-Host "Đang kiểm tra Git..." -ForegroundColor Yellow

# Kiểm tra Git có sẵn không
try {
    $gitVersion = git --version
    Write-Host "Git đã được tìm thấy: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Lỗi: Git chưa được cài đặt hoặc chưa có trong PATH" -ForegroundColor Red
    Write-Host "Vui lòng cài đặt Git từ https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Write-Host "`nĐang khởi tạo Git repository..." -ForegroundColor Yellow

# Khởi tạo git repository nếu chưa có
if (-not (Test-Path ".git")) {
    git init
    Write-Host "Đã khởi tạo Git repository" -ForegroundColor Green
} else {
    Write-Host "Git repository đã tồn tại" -ForegroundColor Green
}

Write-Host "`nĐang xóa các remote cũ..." -ForegroundColor Yellow

# Xóa tất cả các remote cũ
$remotes = git remote
foreach ($remote in $remotes) {
    git remote remove $remote
    Write-Host "Đã xóa remote: $remote" -ForegroundColor Green
}

if ($remotes.Count -eq 0) {
    Write-Host "Không có remote cũ nào để xóa" -ForegroundColor Gray
}

Write-Host "`nĐang thêm remote mới..." -ForegroundColor Yellow

# Thêm remote mới
git remote add origin https://github.com/LongNguyen81-bidv/Library_vibeCode.git
Write-Host "Đã thêm remote: origin -> https://github.com/LongNguyen81-bidv/Library_vibeCode.git" -ForegroundColor Green

Write-Host "`nĐang thêm tất cả các file..." -ForegroundColor Yellow
git add .

Write-Host "`nĐang commit..." -ForegroundColor Yellow
git commit -m "Initial commit from library-starter-clone"

Write-Host "`nĐang push lên repository mới..." -ForegroundColor Yellow
Write-Host "Lưu ý: Bạn có thể cần xác thực với GitHub" -ForegroundColor Yellow

# Thử push, nếu lỗi thì hướng dẫn
try {
    git push -u origin main
    Write-Host "`nThành công! Đã push lên https://github.com/LongNguyen81-bidv/Library_vibeCode" -ForegroundColor Green
} catch {
    Write-Host "`nLỗi khi push. Có thể cần:" -ForegroundColor Yellow
    Write-Host "1. Đổi tên branch: git branch -M main (nếu branch hiện tại không phải main)" -ForegroundColor Yellow
    Write-Host "2. Xác thực với GitHub (Personal Access Token)" -ForegroundColor Yellow
    Write-Host "3. Hoặc chạy: git push -u origin main --force (nếu repo đã có nội dung)" -ForegroundColor Yellow
}

Write-Host "`nHoàn tất!" -ForegroundColor Green

