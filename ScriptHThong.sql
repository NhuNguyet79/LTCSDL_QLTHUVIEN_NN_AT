CREATE DATABASE QLThuVien;
GO
USE QLThuVien;
GO

CREATE TABLE TaiKhoan (
    MaTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
    MatKhau VARCHAR(100) NOT NULL,
    VaiTro NVARCHAR(50) NOT NULL CHECK (VaiTro IN (N'Admin', N'Thủ thư', N'Độc giả')),
    TrangThai NVARCHAR(50) NOT NULL CHECK (TrangThai IN (N'Hoạt động', N'Khóa'))
);
ALTER TABLE TaiKhoan
ADD NgayKhoa DATE NULL,
    NgayMoKhoa DATE NULL;

CREATE TABLE DocGia (
    MaDocGia VARCHAR(20) PRIMARY KEY,
    TenDocGia NVARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(100),
    MaTaiKhoan INT NOT NULL UNIQUE,
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);

CREATE TABLE ThuThu (
    MaThuThu INT IDENTITY(1,1) PRIMARY KEY,
    TenThuThu NVARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(100),
    MaTaiKhoan INT NOT NULL UNIQUE,
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);

CREATE TABLE Admin (
    MaAdmin INT IDENTITY(1,1) PRIMARY KEY,
    TenAdmin NVARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(100),
    MaTaiKhoan INT NOT NULL UNIQUE,
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);

CREATE TABLE TacGia (
    MaTacGia INT IDENTITY(1,1) PRIMARY KEY,
    TenTacGia NVARCHAR(150) NOT NULL
);

CREATE TABLE TheLoai (
    MaTheLoai INT IDENTITY(1,1) PRIMARY KEY,
    TenTheLoai NVARCHAR(100) NOT NULL
);

CREATE TABLE NXB (
    MaNXB INT IDENTITY(1,1) PRIMARY KEY,
    TenNXB NVARCHAR(200) NOT NULL
);

CREATE TABLE Sach (
    MaSach INT IDENTITY(1,1) PRIMARY KEY,
    TenSach NVARCHAR(250) NOT NULL,
    NamXuatBan INT,
    HinhThucMuon NVARCHAR(50) NOT NULL CHECK (HinhThucMuon IN (N'Đọc tại chỗ', N'Mượn về')),
    Gia DECIMAL(18,2) NOT NULL CHECK (Gia > 0),
    SoLuong INT NOT NULL CHECK (SoLuong >= 0),
    TrangThai NVARCHAR(50) NOT NULL CHECK (TrangThai IN (N'Còn sách', N'Hết sách')),
    MaTheLoai INT NOT NULL,
    MaNXB INT NOT NULL,
    MaTacGia INT NOT NULL,
    FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai),
    FOREIGN KEY (MaNXB) REFERENCES NXB(MaNXB),
    FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia)
);

CREATE TABLE PhieuMuon (
    MaPhieuMuon INT IDENTITY(1,1) PRIMARY KEY,

    NgayYeuCau DATETIME NOT NULL,
    NgayLapPhieu DATETIME NULL,
    NgayNhanSach DATETIME NULL,
    HanTra DATETIME NULL,
    NgayTraThucTe DATETIME NULL,

    PhiMuon DECIMAL(18,2) NOT NULL 
        DEFAULT 0 
        CHECK (PhiMuon >= 0),

    TrangThai NVARCHAR(50) NOT NULL
        CHECK (TrangThai IN (
            N'Đã tạo phiếu',
            N'Đã mượn sách',
            N'Đã trả sách',
            N'Có vi phạm',
            N'Đã hủy'
        )),

    MaDocGia VARCHAR(20) NOT NULL,
    MaThuThu INT NULL,
    MaSach INT NOT NULL,

    FOREIGN KEY (MaDocGia) REFERENCES DocGia(MaDocGia),
    FOREIGN KEY (MaThuThu) REFERENCES ThuThu(MaThuThu),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

CREATE TABLE PhieuPhat (
    MaPhieuPhat INT IDENTITY(1,1) PRIMARY KEY,
    MaPhieuMuon INT NOT NULL UNIQUE,
    NgayLapPhieu DATE NOT NULL,
    HanThanhToan DATE NOT NULL,
    TongTienPhat DECIMAL(18,2) NOT NULL CHECK (TongTienPhat >= 0),
    TrangThai NVARCHAR(50) NOT NULL
        CHECK (TrangThai IN (
            N'Chưa thanh toán',
            N'Đã thanh toán',
            N'Quá hạn thanh toán',
            N'Đã hủy'
        )),
    FOREIGN KEY (MaPhieuMuon) REFERENCES PhieuMuon(MaPhieuMuon)
);

CREATE TABLE ViPham (
    MaViPham INT IDENTITY(1,1) PRIMARY KEY,
    MaPhieuMuon INT NOT NULL,
    MaPhieuPhat INT NULL,
    LoaiViPham NVARCHAR(100) NOT NULL
        CHECK (LoaiViPham IN (
            N'Quá hạn',
            N'Không lấy sách',
            N'Dơ',
            N'Rách nhẹ',
            N'Rách nặng',
            N'Mất',
            N'Quá hạn thanh toán'
        )),
    SoNgayQuaHan INT NULL CHECK (SoNgayQuaHan >= 0),
    TienPhat DECIMAL(18,2) NOT NULL CHECK (TienPhat >= 0),
    TrangThai NVARCHAR(50) NOT NULL
        CHECK (TrangThai IN (
            N'Chưa lập phiếu phạt',
            N'Đã lập phiếu phạt'
        )),
    FOREIGN KEY (MaPhieuMuon) REFERENCES PhieuMuon(MaPhieuMuon),
    FOREIGN KEY (MaPhieuPhat) REFERENCES PhieuPhat(MaPhieuPhat)
);

CREATE TABLE ThanhToan (
    MaThanhToan INT IDENTITY(1,1) PRIMARY KEY,
    NgayThanhToan DATE NOT NULL,
    SoTien DECIMAL(18,2) NOT NULL CHECK (SoTien >= 0),
    TrangThai NVARCHAR(50) NOT NULL
        CHECK (TrangThai IN (
            N'Thành công',
            N'Thất bại',
            N'Chờ xử lý'
        )),
    MaPhieuPhat INT NOT NULL UNIQUE,
    FOREIGN KEY (MaPhieuPhat) REFERENCES PhieuPhat(MaPhieuPhat)
);
CREATE TABLE ThongBao (
    MaThongBao INT IDENTITY(1,1) PRIMARY KEY,

    NoiDung NVARCHAR(500) NOT NULL,

    NgayThongBao DATETIME NOT NULL,

    MaDocGia VARCHAR(20) NOT NULL,

    FOREIGN KEY (MaDocGia)
        REFERENCES DocGia(MaDocGia)
);


INSERT INTO TaiKhoan(TenDangNhap, MatKhau, VaiTro, TrangThai)
VALUES
('admin01', '123456', N'Admin', N'Hoạt động'),
('tt001', '123456', N'Thủ thư', N'Hoạt động'),
('docgia01', '123456', N'Độc giả', N'Hoạt động');

INSERT INTO Admin(TenAdmin, SDT, Email, MaTaiKhoan)
VALUES (N'Quản trị viên', '0900000001', 'admin@gmail.com', 1);
INSERT INTO ThuThu(TenThuThu, SDT, Email, MaTaiKhoan)
VALUES (N'Nguyễn Thị B', '0900000002', 'thuthu@gmail.com', 2);
INSERT INTO DocGia(MaDocGia, TenDocGia, SDT, Email, MaTaiKhoan)
VALUES ('2354050000', N'Nguyễn Văn A', '0900000003', '2354050000@gmail.com', 3);


CREATE TABLE Sach_Import (
    STT INT,
    [Nhan đề] NVARCHAR(250),
    [Loại tài liệu] NVARCHAR(100),
    [Tác giả] NVARCHAR(150),
    [Nhà xuất bản] NVARCHAR(200),
    [Năm xuất bản] INT,
    [Hình thức mượn] NVARCHAR(50),
    [Giá] DECIMAL(18,2),
    [Số lượng] INT
);

INSERT INTO TacGia(TenTacGia)
SELECT DISTINCT [Tác giả]
FROM Sach_Import
WHERE [Tác giả] IS NOT NULL;

INSERT INTO NXB(TenNXB)
SELECT DISTINCT [Nhà xuất bản]
FROM Sach_Import
WHERE [Nhà xuất bản] IS NOT NULL;

INSERT INTO TheLoai(TenTheLoai)
SELECT DISTINCT [Loại tài liệu]
FROM Sach_Import
WHERE [Loại tài liệu] IS NOT NULL;

SELECT * FROM NXB;
SELECT * FROM TacGia;
SELECT * FROM TheLoai;

INSERT INTO Sach (
    TenSach,
    NamXuatBan,
    HinhThucMuon,
    Gia,
    SoLuong,
    TrangThai,
    MaTheLoai,
    MaNXB,
    MaTacGia
)
SELECT
    si.[Nhan đề],
    si.[Năm xuất bản],
    si.[Hình thức mượn],
    si.[Giá],
    si.[Số lượng],
    CASE 
        WHEN si.[Số lượng] > 0 THEN N'Còn sách'
        ELSE N'Hết sách'
    END AS TrangThai,
    tl.MaTheLoai,
    nxb.MaNXB,
    tg.MaTacGia
FROM Sach_Import si
JOIN TheLoai tl ON si.[Loại tài liệu] = tl.TenTheLoai
JOIN NXB nxb ON si.[Nhà xuất bản] = nxb.TenNXB
JOIN TacGia tg ON si.[Tác giả] = tg.TenTacGia;

-------------------------------------------------------------------
CREATE VIEW v_DanhSachSach
AS
SELECT 
    s.MaSach,
    s.TenSach,
    tl.TenTheLoai,
    tg.TenTacGia,
    nxb.TenNXB,
    s.NamXuatBan,
    s.HinhThucMuon,
    s.Gia,
    s.SoLuong,
    s.TrangThai
FROM Sach s
JOIN TheLoai tl ON s.MaTheLoai = tl.MaTheLoai
JOIN TacGia tg ON s.MaTacGia = tg.MaTacGia
JOIN NXB nxb ON s.MaNXB = nxb.MaNXB;
GO
SELECT * FROM v_DanhSachSach;

CREATE PROCEDURE sp_DangNhap
    @TenDangNhap VARCHAR(50),
    @MatKhau VARCHAR(100)
AS
BEGIN
    SELECT 
        MaTaiKhoan,
        TenDangNhap,
        VaiTro,
        TrangThai
    FROM TaiKhoan
    WHERE TenDangNhap = @TenDangNhap
      AND MatKhau = @MatKhau;
END;
GO
--Test

CREATE VIEW v_PhieuMuon
AS
SELECT
    pm.MaPhieuMuon,
    dg.MaDocGia,
    dg.TenDocGia,
    s.MaSach,
    s.TenSach,
    pm.NgayYeuCau,
    pm.NgayLapPhieu,
    pm.NgayNhanSach,
    pm.HanTra,
    pm.NgayTraThucTe,
    pm.PhiMuon,
    pm.TrangThai,
    tt.TenThuThu
FROM PhieuMuon pm
JOIN DocGia dg ON pm.MaDocGia = dg.MaDocGia
JOIN Sach s ON pm.MaSach = s.MaSach
LEFT JOIN ThuThu tt ON pm.MaThuThu = tt.MaThuThu;
GO
--SP_GuiYeuCauMuon
CREATE PROCEDURE sp_GuiYeuCauMuon
    @MaDocGia VARCHAR(20),
    @MaSach INT,
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SoPhieuDangMuon INT;
    DECLARE @SoViPhamTrongThang INT;
    DECLARE @ConNoPhieuPhat INT;
    DECLARE @PhiMuon DECIMAL(18,2);

    SET @PhiMuon = 0;

    -- 1. Kiểm tra độc giả tồn tại và tài khoản không bị khóa
    IF NOT EXISTS (
        SELECT 1
        FROM DocGia dg
        JOIN TaiKhoan tk ON dg.MaTaiKhoan = tk.MaTaiKhoan
        WHERE dg.MaDocGia = @MaDocGia
          AND tk.TrangThai = N'Hoạt động'
    )
    BEGIN
        SET @KetQua = 2; -- Tài khoản không tồn tại hoặc đang bị khóa
        RETURN;
    END

    -- 2. Kiểm tra sách tồn tại, được mượn về, còn sách
    IF NOT EXISTS (
        SELECT 1
        FROM Sach
        WHERE MaSach = @MaSach
          AND HinhThucMuon = N'Mượn về'
          AND SoLuong > 0
          AND TrangThai = N'Còn sách'
    )
    BEGIN
        SET @KetQua = 3; -- Sách không đủ điều kiện mượn
        RETURN;
    END

    -- 3. Kiểm tra độc giả đang có bao nhiêu phiếu mượn chưa kết thúc
    SELECT @SoPhieuDangMuon = COUNT(*)
    FROM PhieuMuon
    WHERE MaDocGia = @MaDocGia
      AND TrangThai IN (
            N'Đã tạo phiếu',
            N'Đã mượn sách',
            N'Có vi phạm'
      );

    IF @SoPhieuDangMuon >= 5
    BEGIN
        SET @KetQua = 4; -- Đã đạt giới hạn 5 phiếu mượn
        RETURN;
    END

    -- 4. Đếm số vi phạm trong tháng hiện tại
    SELECT @SoViPhamTrongThang = COUNT(*)
    FROM ViPham vp
    JOIN PhieuMuon pm ON vp.MaPhieuMuon = pm.MaPhieuMuon
    WHERE pm.MaDocGia = @MaDocGia
      AND MONTH(pm.NgayYeuCau) = MONTH(GETDATE())
      AND YEAR(pm.NgayYeuCau) = YEAR(GETDATE());

    -- 5. Nếu đã có từ 3 vi phạm thì kiểm tra còn phiếu phạt chưa thanh toán không
    IF @SoViPhamTrongThang >= 3
    BEGIN
        SELECT @ConNoPhieuPhat = COUNT(*)
        FROM PhieuPhat pp
        JOIN PhieuMuon pm ON pp.MaPhieuMuon = pm.MaPhieuMuon
        WHERE pm.MaDocGia = @MaDocGia
          AND pp.TrangThai IN (N'Chưa thanh toán', N'Quá hạn thanh toán');

        IF @ConNoPhieuPhat > 0
        BEGIN
            SET @KetQua = 5; -- Đạt 3 vi phạm, cần thanh toán phiếu phạt trước khi mượn
            RETURN;
        END

        SET @PhiMuon = 30000;
    END

    -- 6. Tạo phiếu mượn
    INSERT INTO PhieuMuon (
        NgayYeuCau,
        NgayLapPhieu,
        PhiMuon,
        TrangThai,
        MaDocGia,
        MaSach
    )
    VALUES (
        GETDATE(),
        GETDATE(),
        @PhiMuon,
        N'Đã tạo phiếu',
        @MaDocGia,
        @MaSach
    );

    SET @KetQua = 1; -- Gửi yêu cầu mượn thành công
END;
GO


CREATE PROCEDURE sp_XacNhanNhanSach
    @MaPhieuMuon INT,
    @MaThuThu INT,
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1
        FROM PhieuMuon
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND TrangThai = N'Đã tạo phiếu'
    )
    BEGIN
        SET @KetQua = 2; -- Phiếu không tồn tại hoặc không ở trạng thái đã tạo
        RETURN;
    END

    UPDATE PhieuMuon
    SET 
        MaThuThu = @MaThuThu,
        NgayNhanSach = GETDATE(),
        HanTra = DATEADD(DAY, 14, GETDATE()),
        TrangThai = N'Đã mượn sách'
    WHERE MaPhieuMuon = @MaPhieuMuon;

    UPDATE Sach
    SET SoLuong = SoLuong - 1,
        TrangThai = CASE 
            WHEN SoLuong - 1 = 0 THEN N'Hết sách'
            ELSE N'Còn sách'
        END
    WHERE MaSach = (
        SELECT MaSach FROM PhieuMuon WHERE MaPhieuMuon = @MaPhieuMuon
    );

    SET @KetQua = 1; -- Thành công
END;
GO


CREATE PROCEDURE sp_HuyPhieuMuon
    @MaPhieuMuon INT,
    @MaDocGia VARCHAR(20),
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1
        FROM PhieuMuon
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND MaDocGia = @MaDocGia
    )
    BEGIN
        SET @KetQua = 2; -- Không tồn tại hoặc không thuộc độc giả
        RETURN;
    END

    IF NOT EXISTS (
        SELECT 1
        FROM PhieuMuon
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND TrangThai = N'Đã tạo phiếu'
    )
    BEGIN
        SET @KetQua = 3; -- Chỉ hủy được khi đã tạo phiếu
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM PhieuMuon
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND DATEDIFF(HOUR, NgayYeuCau, GETDATE()) > 24
    )
    BEGIN
        SET @KetQua = 4; -- Quá 24h
        RETURN;
    END

    UPDATE PhieuMuon
    SET TrangThai = N'Đã hủy'
    WHERE MaPhieuMuon = @MaPhieuMuon;

    SET @KetQua = 1; -- Hủy thành công
END;
GO
CREATE PROCEDURE sp_XuLyKhongLaySach
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE PhieuMuon
    SET TrangThai = N'Đã hủy'
    WHERE TrangThai = N'Đã tạo phiếu'
      AND DATEDIFF(DAY, NgayLapPhieu, GETDATE()) > 3;

    INSERT INTO ViPham (
        MaPhieuMuon,
        LoaiViPham,
        SoNgayQuaHan,
        TienPhat,
        TrangThai
    )
    SELECT
        pm.MaPhieuMuon,
        N'Không lấy sách',
        NULL,
        0,
        N'Chưa lập phiếu phạt'
    FROM PhieuMuon pm
    WHERE pm.TrangThai = N'Đã hủy'
      AND NOT EXISTS (
          SELECT 1
          FROM ViPham vp
          WHERE vp.MaPhieuMuon = pm.MaPhieuMuon
            AND vp.LoaiViPham = N'Không lấy sách'
      );
END;
GO


CREATE PROCEDURE sp_TraSach
    @MaPhieuMuon INT,
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1
        FROM PhieuMuon
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND TrangThai = N'Đã mượn sách'
    )
    BEGIN
        SET @KetQua = 2; -- Phiếu không hợp lệ
        RETURN;
    END

    UPDATE PhieuMuon
    SET 
        NgayTraThucTe = GETDATE(),
        TrangThai = N'Đã trả sách'
    WHERE MaPhieuMuon = @MaPhieuMuon;

    UPDATE Sach
    SET SoLuong = SoLuong + 1,
        TrangThai = N'Còn sách'
    WHERE MaSach = (
        SELECT MaSach FROM PhieuMuon WHERE MaPhieuMuon = @MaPhieuMuon
    );

    SET @KetQua = 1; -- Trả sách thành công
END;
GO

CREATE PROCEDURE sp_ThemViPham
    @MaPhieuMuon INT,
    @LoaiViPham NVARCHAR(100),
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @GiaSach DECIMAL(18,2);
    DECLARE @TienPhat DECIMAL(18,2);

    IF NOT EXISTS (
        SELECT 1
        FROM PhieuMuon
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND TrangThai IN (N'Đã trả sách', N'Có vi phạm')
    )
    BEGIN
        SET @KetQua = 2; -- Phiếu mượn không hợp lệ
        RETURN;
    END

    SELECT @GiaSach = s.Gia
    FROM PhieuMuon pm
    JOIN Sach s ON pm.MaSach = s.MaSach
    WHERE pm.MaPhieuMuon = @MaPhieuMuon;

    SET @TienPhat =
        CASE @LoaiViPham
            WHEN N'Dơ' THEN @GiaSach * 0.10
            WHEN N'Rách nhẹ' THEN @GiaSach * 0.20
            WHEN N'Rách nặng' THEN @GiaSach * 0.30
            WHEN N'Mất' THEN @GiaSach * 1.00
            ELSE -1
        END;

    IF @TienPhat < 0
    BEGIN
        SET @KetQua = 3; -- Loại vi phạm không hợp lệ
        RETURN;
    END

    INSERT INTO ViPham (
        MaPhieuMuon,
        LoaiViPham,
        SoNgayQuaHan,
        TienPhat,
        TrangThai
    )
    VALUES (
        @MaPhieuMuon,
        @LoaiViPham,
        NULL,
        @TienPhat,
        N'Chưa lập phiếu phạt'
    );

    UPDATE PhieuMuon
    SET TrangThai = N'Có vi phạm'
    WHERE MaPhieuMuon = @MaPhieuMuon;

    SET @KetQua = 1; -- Thêm vi phạm thành công
END;
GO

CREATE PROCEDURE sp_KiemTraQuaHanTraSach
    @MaPhieuMuon INT,
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SoNgayQuaHan INT;

    IF NOT EXISTS (
        SELECT 1
        FROM PhieuMuon
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND NgayTraThucTe IS NOT NULL
    )
    BEGIN
        SET @KetQua = 2; -- Phiếu chưa trả sách
        RETURN;
    END

    SELECT @SoNgayQuaHan = DATEDIFF(DAY, HanTra, NgayTraThucTe)
    FROM PhieuMuon
    WHERE MaPhieuMuon = @MaPhieuMuon;

    IF @SoNgayQuaHan <= 0
    BEGIN
        SET @KetQua = 3; -- Không quá hạn
        RETURN;
    END

    IF NOT EXISTS (
        SELECT 1
        FROM ViPham
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND LoaiViPham = N'Quá hạn'
    )
    BEGIN
        INSERT INTO ViPham (
            MaPhieuMuon,
            LoaiViPham,
            SoNgayQuaHan,
            TienPhat,
            TrangThai
        )
        VALUES (
            @MaPhieuMuon,
            N'Quá hạn',
            @SoNgayQuaHan,
            @SoNgayQuaHan * 5000,
            N'Chưa lập phiếu phạt'
        );

        UPDATE PhieuMuon
        SET TrangThai = N'Có vi phạm'
        WHERE MaPhieuMuon = @MaPhieuMuon;
    END

    SET @KetQua = 1; -- Có quá hạn và đã ghi nhận
END;
GO

CREATE PROCEDURE sp_LapPhieuPhat
    @MaPhieuMuon INT,
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TongTien DECIMAL(18,2);
    DECLARE @MaPhieuPhat INT;

    IF NOT EXISTS (
        SELECT 1
        FROM ViPham
        WHERE MaPhieuMuon = @MaPhieuMuon
          AND TrangThai = N'Chưa lập phiếu phạt'
    )
    BEGIN
        SET @KetQua = 2; -- Không có vi phạm cần lập phiếu phạt
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM PhieuPhat
        WHERE MaPhieuMuon = @MaPhieuMuon
    )
    BEGIN
        SET @KetQua = 3; -- Phiếu mượn đã có phiếu phạt
        RETURN;
    END

    SELECT @TongTien = SUM(TienPhat)
    FROM ViPham
    WHERE MaPhieuMuon = @MaPhieuMuon
      AND TrangThai = N'Chưa lập phiếu phạt';

    INSERT INTO PhieuPhat (
        MaPhieuMuon,
        NgayLapPhieu,
        HanThanhToan,
        TongTienPhat,
        TrangThai
    )
    VALUES (
        @MaPhieuMuon,
        GETDATE(),
        DATEADD(DAY, 7, GETDATE()),
        @TongTien,
        N'Chưa thanh toán'
    );

    SET @MaPhieuPhat = SCOPE_IDENTITY();

    UPDATE ViPham
    SET 
        MaPhieuPhat = @MaPhieuPhat,
        TrangThai = N'Đã lập phiếu phạt'
    WHERE MaPhieuMuon = @MaPhieuMuon
      AND TrangThai = N'Chưa lập phiếu phạt';

    SET @KetQua = 1; -- Lập phiếu phạt thành công
END;
GO

CREATE PROCEDURE sp_ThanhToanPhieuPhat
    @MaPhieuPhat INT,
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SoTien DECIMAL(18,2);

    IF NOT EXISTS (
        SELECT 1
        FROM PhieuPhat
        WHERE MaPhieuPhat = @MaPhieuPhat
          AND TrangThai IN (N'Chưa thanh toán', N'Quá hạn thanh toán')
    )
    BEGIN
        SET @KetQua = 2; -- Phiếu phạt không hợp lệ hoặc đã thanh toán
        RETURN;
    END

    SELECT @SoTien = TongTienPhat
    FROM PhieuPhat
    WHERE MaPhieuPhat = @MaPhieuPhat;

    INSERT INTO ThanhToan (
        NgayThanhToan,
        SoTien,
        TrangThai,
        MaPhieuPhat
    )
    VALUES (
        GETDATE(),
        @SoTien,
        N'Thành công',
        @MaPhieuPhat
    );

    UPDATE PhieuPhat
    SET TrangThai = N'Đã thanh toán'
    WHERE MaPhieuPhat = @MaPhieuPhat;

    SET @KetQua = 1; -- Thanh toán thành công
END;
GO

CREATE VIEW v_PhieuPhat
AS
SELECT
    pp.MaPhieuPhat,
    pm.MaPhieuMuon,
    dg.MaDocGia,
    dg.TenDocGia,
    s.TenSach,
    pp.NgayLapPhieu,
    pp.HanThanhToan,
    pp.TongTienPhat,
    pp.TrangThai
FROM PhieuPhat pp
JOIN PhieuMuon pm ON pp.MaPhieuMuon = pm.MaPhieuMuon
JOIN DocGia dg ON pm.MaDocGia = dg.MaDocGia
JOIN Sach s ON pm.MaSach = s.MaSach;
GO
SELECT * FROM v_PhieuPhat;

CREATE VIEW v_ViPham
AS
SELECT
    vp.MaViPham,
    vp.MaPhieuMuon,
    dg.MaDocGia,
    dg.TenDocGia,
    s.MaSach,
    s.TenSach,
    vp.LoaiViPham,
    vp.SoNgayQuaHan,
    vp.TienPhat,
    vp.TrangThai,
    vp.MaPhieuPhat
FROM ViPham vp
JOIN PhieuMuon pm ON vp.MaPhieuMuon = pm.MaPhieuMuon
JOIN DocGia dg ON pm.MaDocGia = dg.MaDocGia
JOIN Sach s ON pm.MaSach = s.MaSach;
GO

SELECT * FROM v_ViPham;

CREATE PROCEDURE sp_KiemTraQuaHanThanhToan
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE PhieuPhat
    SET TrangThai = N'Quá hạn thanh toán'
    WHERE TrangThai = N'Chưa thanh toán'
      AND HanThanhToan < CAST(GETDATE() AS DATE);
END;
GO


CREATE PROCEDURE sp_GhiNhanViPhamQuaHanThanhToan
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ViPham (
        MaPhieuMuon,
        MaPhieuPhat,
        LoaiViPham,
        SoNgayQuaHan,
        TienPhat,
        TrangThai
    )
    SELECT
        pp.MaPhieuMuon,
        pp.MaPhieuPhat,
        N'Quá hạn thanh toán',
        DATEDIFF(DAY, pp.HanThanhToan, GETDATE()),
        0,
        N'Đã lập phiếu phạt'
    FROM PhieuPhat pp
    WHERE pp.TrangThai = N'Quá hạn thanh toán'
      AND NOT EXISTS (
          SELECT 1
          FROM ViPham vp
          WHERE vp.MaPhieuPhat = pp.MaPhieuPhat
            AND vp.LoaiViPham = N'Quá hạn thanh toán'
      );
END;
GO



CREATE PROCEDURE sp_KhoaTaiKhoanViPham
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE tk
    SET 
        tk.TrangThai = N'Khóa',
        tk.NgayKhoa = CAST(GETDATE() AS DATE)
    FROM TaiKhoan tk
    JOIN DocGia dg ON tk.MaTaiKhoan = dg.MaTaiKhoan
    WHERE tk.VaiTro = N'Độc giả'
      AND tk.TrangThai = N'Hoạt động'
      AND DAY(GETDATE()) = 5
      AND (
          SELECT COUNT(*)
          FROM ViPham vp
          JOIN PhieuMuon pm ON vp.MaPhieuMuon = pm.MaPhieuMuon
          WHERE pm.MaDocGia = dg.MaDocGia
            AND MONTH(pm.NgayYeuCau) = MONTH(GETDATE())
            AND YEAR(pm.NgayYeuCau) = YEAR(GETDATE())
      ) >= 3;
END;
GO

CREATE PROCEDURE sp_MoKhoaTaiKhoan
    @MaDocGia VARCHAR(20),
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NgayKhoa DATE;
    DECLARE @NgayDuocMo DATE;

    IF NOT EXISTS (
        SELECT 1
        FROM DocGia dg
        JOIN TaiKhoan tk ON dg.MaTaiKhoan = tk.MaTaiKhoan
        WHERE dg.MaDocGia = @MaDocGia
          AND tk.TrangThai = N'Khóa'
    )
    BEGIN
        SET @KetQua = 2;
        RETURN;
    END

    SELECT @NgayKhoa = tk.NgayKhoa
    FROM TaiKhoan tk
    JOIN DocGia dg ON tk.MaTaiKhoan = dg.MaTaiKhoan
    WHERE dg.MaDocGia = @MaDocGia;

    SET @NgayDuocMo = DATEFROMPARTS(
        YEAR(DATEADD(MONTH, 1, @NgayKhoa)),
        MONTH(DATEADD(MONTH, 1, @NgayKhoa)),
        5
    );

    IF CAST(GETDATE() AS DATE) < @NgayDuocMo
    BEGIN
        SET @KetQua = 3;
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM PhieuPhat pp
        JOIN PhieuMuon pm ON pp.MaPhieuMuon = pm.MaPhieuMuon
        WHERE pm.MaDocGia = @MaDocGia
          AND pp.TrangThai IN (N'Chưa thanh toán', N'Quá hạn thanh toán')
    )
    BEGIN
        SET @KetQua = 4;
        RETURN;
    END

    UPDATE tk
    SET 
        tk.TrangThai = N'Hoạt động',
        tk.NgayMoKhoa = CAST(GETDATE() AS DATE)
    FROM TaiKhoan tk
    JOIN DocGia dg ON tk.MaTaiKhoan = dg.MaTaiKhoan
    WHERE dg.MaDocGia = @MaDocGia;

    SET @KetQua = 1;
END;
GO
DECLARE @KQ INT;



CREATE VIEW v_DocGia
AS
SELECT
    dg.MaDocGia,
    dg.TenDocGia,
    dg.SDT,
    dg.Email,
    tk.TenDangNhap,
    tk.TrangThai,
    tk.NgayKhoa,
    tk.NgayMoKhoa
FROM DocGia dg
JOIN TaiKhoan tk ON dg.MaTaiKhoan = tk.MaTaiKhoan;
GO


CREATE PROCEDURE sp_GuiThongBao
    @MaDocGia VARCHAR(20),
    @NoiDung NVARCHAR(500),
    @KetQua INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1 FROM DocGia WHERE MaDocGia = @MaDocGia
    )
    BEGIN
        SET @KetQua = 2; -- Độc giả không tồn tại
        RETURN;
    END

    INSERT INTO ThongBao (
        NoiDung,
        NgayThongBao,
        MaDocGia
    )
    VALUES (
        @NoiDung,
        GETDATE(),
        @MaDocGia
    );

    SET @KetQua = 1; -- Gửi thành công
END;
GO

CREATE VIEW v_ThongBao
AS
SELECT
    tb.MaThongBao,
    dg.MaDocGia,
    dg.TenDocGia,
    tb.NoiDung,
    tb.NgayThongBao
FROM ThongBao tb
JOIN DocGia dg ON tb.MaDocGia = dg.MaDocGia;
GO

SELECT * FROM v_ThongBao;

CREATE OR ALTER VIEW v_ThongKeTongQuan
AS
SELECT
    (SELECT COUNT(*) FROM Sach) AS TongSach,
    (SELECT COUNT(*) FROM DocGia) AS TongDocGia,
    (SELECT COUNT(*) FROM PhieuMuon 
        WHERE TrangThai = N'Đã mượn sách') AS SachDangMuon,
    (SELECT COUNT(*) FROM PhieuPhat
        WHERE TrangThai IN (N'Chưa thanh toán', N'Quá hạn thanh toán')) AS PhieuPhatChuaThanhToan,
    (SELECT COUNT(*) FROM TaiKhoan
        WHERE TrangThai = N'Khóa') AS TaiKhoanBiKhoa;
GO

SELECT * FROM v_ThongKeTongQuan;

CREATE OR ALTER VIEW v_SachQuaHan
AS
SELECT
    pm.MaPhieuMuon,
    dg.MaDocGia,
    dg.TenDocGia,
    s.TenSach,
    pm.NgayNhanSach,
    pm.HanTra,
    DATEDIFF(DAY, pm.HanTra, GETDATE()) AS SoNgayQuaHan
FROM PhieuMuon pm
JOIN DocGia dg ON pm.MaDocGia = dg.MaDocGia
JOIN Sach s ON pm.MaSach = s.MaSach
WHERE pm.TrangThai = N'Đã mượn sách'
AND pm.HanTra < GETDATE();
GO

SELECT * FROM v_SachQuaHan;
--TÌM SÁCH
CREATE OR ALTER PROCEDURE sp_TimSach
    @TuKhoa NVARCHAR(250)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM v_DanhSachSach
    WHERE
        TenSach LIKE N'%' + @TuKhoa + N'%'
        OR TenTacGia LIKE N'%' + @TuKhoa + N'%'
        OR TenTheLoai LIKE N'%' + @TuKhoa + N'%'
        OR TenNXB LIKE N'%' + @TuKhoa + N'%';
END;
GO


CREATE OR ALTER PROCEDURE sp_LichSuMuonSach
    @MaDocGia VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM v_PhieuMuon
    WHERE MaDocGia = @MaDocGia
    ORDER BY MaPhieuMuon DESC;
END;
GO

CREATE OR ALTER PROCEDURE sp_XemPhieuPhat
    @MaDocGia VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM v_PhieuPhat
    WHERE MaDocGia = @MaDocGia
    ORDER BY MaPhieuPhat DESC;
END;
GO
CREATE OR ALTER PROCEDURE sp_XemThongBao
    @MaDocGia VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM v_ThongBao
    WHERE MaDocGia = @MaDocGia
    ORDER BY NgayThongBao DESC;
END;
GO

SELECT * FROM TaiKhoan;
SELECT * FROM DocGia;
SELECT * FROM Sach;
SELECT * FROM PhieuMuon;
SELECT * FROM ViPham;
SELECT * FROM PhieuPhat;
SELECT * FROM ThanhToan;