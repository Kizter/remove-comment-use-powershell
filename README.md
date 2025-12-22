# Remove Comments Script

PowerShell script untuk menghapus semua komentar dari file HTML, JavaScript, dan CSS dalam sebuah project.

## Deskripsi

Script ini secara otomatis memproses file-file dalam sebuah project dan menghapus semua komentar yang ada di dalamnya:

- Komentar HTML `<!-- -->`
- Komentar JavaScript single-line `//`
- Komentar JavaScript multi-line `/* */`
- Komentar CSS `/* */`

Script ini melewati folder `node_modules` secara otomatis dan memproses file dengan encoding UTF-8.

## Fitur

- Menghapus komentar HTML dari file `.html`
- Menghapus komentar single-line dan multi-line dari file `.js`
- Menghapus komentar dari file `.css`
- Menampilkan progress untuk setiap file yang diproses
- Menampilkan jumlah karakter yang dihapus
- Melewati folder `node_modules`
- Menangani URL dengan benar (tidak menghapus `//` dalam `http://` atau `https://`)

## Cara Menggunakan

### Persiapan

1. Pastikan PowerShell terinstall di sistem Anda
2. Download atau clone repository ini
3. Edit file `remove_comments.ps1` pada baris ke-3 untuk mengatur path project Anda:

```powershell
$projectPath = "c:\Project"
```

Ganti `c:\Project` dengan path lengkap ke folder project yang ingin dibersihkan dari komentar.

### Menjalankan Script

1. Buka PowerShell sebagai Administrator (opsional, tergantung permission folder)
2. Navigate ke folder tempat script berada:

```powershell
cd c:\delete-comment
```

3. Jalankan script:

```powershell
.\remove_comments.ps1
```

### Alternatif: Menjalankan dengan Execution Policy

Jika mendapat error execution policy, jalankan dengan:

```powershell
powershell -ExecutionPolicy Bypass -File .\remove_comments.ps1
```

## Output

Script akan menampilkan:

- Nama setiap file yang sedang diproses
- Jumlah karakter yang dihapus dari setiap file
- Total file yang berhasil diproses

Contoh output:

```
Processing: index.html
  OK - Removed 523 characters
Processing: app.js
  OK - Removed 1024 characters
Processing: styles.css
  - No comments found

Completed! Processed 2 files.
```

## Peringatan

**PENTING:** Script ini akan mengubah file secara langsung tanpa membuat backup. Pastikan untuk:

1. Membuat backup project Anda terlebih dahulu
2. Menggunakan version control (Git) sebelum menjalankan script
3. Memeriksa hasil sebelum commit

Script ini TIDAK dapat di-undo secara otomatis.

## Persyaratan Sistem

- Windows dengan PowerShell 5.1 atau lebih tinggi
- Read/Write permission ke folder project yang akan diproses

## Batasan

- Script ini menggunakan regex untuk mendeteksi komentar, sehingga ada kemungkinan edge case yang tidak tertangani
- Tidak menangani komentar dalam string literals dengan sempurna
- Pastikan untuk test di development environment terlebih dahulu

## Lisensi

Script ini bebas digunakan untuk keperluan apapun.

## Kontribusi

Silakan buat pull request atau issue jika menemukan bug atau ingin menambahkan fitur baru.
