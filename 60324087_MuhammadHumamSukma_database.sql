-- 1. CREATE DATABASE

CREATE DATABASE perpustakaan_lengkap;

-- 2. TABEL kategori_buku

CREATE TABLE kategori_buku (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE,
    deskripsi TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 3. TABEL penerbit

CREATE TABLE penerbit (
    id_penerbit INT AUTO_INCREMENT PRIMARY KEY,
    nama_penerbit VARCHAR(100) NOT NULL,
    alamat TEXT,
    telepon VARCHAR(15),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. TABEL buku (RELASI Foreign Key)

CREATE TABLE buku (
    id_buku INT AUTO_INCREMENT PRIMARY KEY,
    kode_buku VARCHAR(20) NOT NULL UNIQUE,
    judul VARCHAR(200) NOT NULL,
    pengarang VARCHAR(100) NOT NULL,
    tahun YEAR NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL DEFAULT 0,
    deskripsi TEXT,
    id_kategori INT NOT NULL,
    id_penerbit INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_kategori
        FOREIGN KEY (id_kategori)
        REFERENCES kategori_buku(id_kategori)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_penerbit
        FOREIGN KEY (id_penerbit)
        REFERENCES penerbit(id_penerbit)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 5. INSERT KATEGORI

INSERT INTO kategori_buku (nama_kategori, deskripsi) VALUES
('Programming', 'Buku tentang pemrograman'),
('Database', 'Buku tentang basis data'),
('Web Design', 'Buku tentang desain web'),
('Networking', 'Buku tentang jaringan komputer'),
('Mobile Development', 'Buku tentang aplikasi mobile');


-- 6. INSERT PENERBIT

INSERT INTO penerbit (nama_penerbit, alamat, telepon, email) VALUES
('Informatika', 'Bandung', '0811111111', 'info@informatika.com'),
('Graha Ilmu', 'Yogyakarta', '0822222222', 'info@grahailmu.com'),
('Erlangga', 'Jakarta', '0833333333', 'info@erlangga.com'),
('Andi Offset', 'Yogyakarta', '0844444444', 'info@andi.com'),
('Gramedia', 'Jakarta', '0855555555', 'info@gramedia.com');

-- 7. INSERT BUKU

INSERT INTO buku 
(kode_buku, judul, pengarang, tahun, harga, stok, deskripsi, id_kategori, id_penerbit)
VALUES
('BK-001', 'Belajar PHP Dasar', 'Budi Raharjo', 2023, 75000, 10, 'Panduan PHP dasar', 1, 1),
('BK-002', 'Mastering MySQL', 'Andi Nugroho', 2022, 95000, 5, 'Database MySQL', 2, 2),
('BK-003', 'Laravel Advanced', 'Siti Aminah', 2024, 125000, 8, 'Framework Laravel', 1, 1),
('BK-004', 'UI/UX Design', 'Dedi Santoso', 2023, 85000, 15, 'Desain modern', 3, 4),
('BK-005', 'Network Security', 'Rina Wijaya', 2023, 110000, 3, 'Keamanan jaringan', 4, 3),
('BK-006', 'REST API PHP', 'Budi Raharjo', 2024, 90000, 12, 'API development', 1, 1),
('BK-007', 'PostgreSQL Expert', 'Ahmad Yani', 2024, 115000, 7, 'Database lanjut', 2, 2),
('BK-008', 'JavaScript Modern', 'Siti Aminah', 2023, 80000, 6, 'JS modern', 1, 5),
('BK-009', 'Flutter Mobile', 'Rizky', 2024, 120000, 9, 'Mobile dev', 5, 5),
('BK-010', 'React Native', 'Ahmad Yani', 2024, 135000, 10, 'Mobile app', 5, 5),
('BK-011', 'HTML CSS Guide', 'Dedi Santoso', 2022, 70000, 20, 'Web design dasar', 3, 4),
('BK-012', 'Cisco Networking', 'Rina Wijaya', 2023, 130000, 4, 'Jaringan lanjut', 4, 3),
('BK-013', 'SQL Optimization', 'Andi Nugroho', 2024, 105000, 6, 'Optimasi DB', 2, 2),
('BK-014', 'Bootstrap Design', 'Siti Aminah', 2023, 75000, 11, 'Frontend design', 3, 4),
('BK-015', 'Android Studio', 'Rizky', 2024, 125000, 8, 'Android dev', 5, 5);

-- 8. QUERY JOIN

-- JOIN untuk tampilkan buku dengan nama kategori dan penerbit
SELECT 
    b.judul,
    k.nama_kategori,
    p.nama_penerbit,
    b.harga,
    b.stok
FROM buku b
JOIN kategori_buku k ON b.id_kategori = k.id_kategori
JOIN penerbit p ON b.id_penerbit = p.id_penerbit;

-- Jumlah buku per kategori
SELECT 
    k.nama_kategori,
    COUNT(b.id_buku) AS jumlah_buku
FROM buku b
JOIN kategori_buku k ON b.id_kategori = k.id_kategori
GROUP BY k.nama_kategori;

-- Jumlah buku per penerbit
SELECT 
    p.nama_penerbit,
    COUNT(b.id_buku) AS jumlah_buku
FROM buku b
JOIN penerbit p ON b.id_penerbit = p.id_penerbit
GROUP BY p.nama_penerbit;

-- Detail buku lengkap

SELECT 
    b.kode_buku AS 'Kode Buku',
    b.judul AS 'Judul',
    b.pengarang AS 'Pengarang',
    k.nama_kategori AS 'Kategori',
    p.nama_penerbit AS 'Penerbit',
    CONCAT('Rp ', FORMAT(b.harga, 0)) AS 'Harga',
    b.stok AS 'Stok',
    b.tahun AS 'Tahun'
FROM buku b
JOIN kategori_buku k ON b.id_kategori = k.id_kategori
JOIN penerbit p ON b.id_penerbit = p.id_penerbit
ORDER BY b.harga DESC;