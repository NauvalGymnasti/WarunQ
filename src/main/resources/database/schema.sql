-- SQLBook: Code
-- mysql -h mysql-warunq-warunq.d.aivencloud.com -P 28737 -u avnadmin -p "AVNS_dHcesTccniEeErK2qOH" --ssl-ca=c:\Users\hp\Downloads\ca.pem  defaultdb

SHOW DATABASES;
SHOW TABLES;

USE `db_warunq`;

DROP TABLE IF EXISTS `detail_transaksi`;
DROP TABLE IF EXISTS `pesanan`;
DROP TABLE IF EXISTS `transaksi`;
DROP TABLE IF EXISTS `barang`;
DROP TABLE IF EXISTS `akun`;

CREATE TABLE `akun` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `nama` VARCHAR(255) NOT NULL UNIQUE,
    `kata_sandi` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `barang` (
    `kode` VARCHAR(255),
    `nama` VARCHAR(255) NOT NULL UNIQUE,
    `harga` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    `stok` INT UNSIGNED NOT NULL DEFAULT 0,
    `tanggal_belanja` DATE NULL DEFAULT (CURRENT_DATE),
    `biaya_belanja` DECIMAL(15, 2) NULL,
    PRIMARY KEY (`kode`)
);

CREATE TABLE `transaksi` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `tanggalwaktu` DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `total` DECIMAL(15, 2) NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `detail_transaksi` (
    `id_transaksi` INT UNSIGNED AUTO_INCREMENT,
    `kode_barang` VARCHAR(255),
    `kuantitas_barang` INT UNSIGNED NOT NULL DEFAULT 0,
    `subtotal` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`id_transaksi`, `kode_barang`),
    FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi`(`id`),
    FOREIGN KEY (`kode_barang`) REFERENCES `barang`(`kode`)
);

CREATE TABLE `pesanan` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `kode_barang` VARCHAR(255),
    `nama_pemesan` VARCHAR(255) NOT NULL,
    `kuantitas_barang` INT NOT NULL DEFAULT 0,
    `tenggat_pesanan` DATE NULL DEFAULT (CURRENT_DATE),
    `subtotal` DECIMAL(15, 2) NULL DEFAULT 0.00,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`kode_barang`) REFERENCES `barang`(`kode`)
);