# Sederhana - Pemrograman Assembly AArch64 di Termux

Repositori ini berisi kumpulan program Assembly tingkat rendah (low-level) sederhana yang dirancang khusus untuk arsitektur **AArch64 (ARM 64-bit)**. Semua program di dalam proyek ini dikembangkan dan dijalankan langsung menggunakan aplikasi **Termux** di perangkat Android tanpa bantuan emulator eksternal.

Proyek ini dibuat sebagai sarana belajar memahami arsitektur CPU, manajemen memori, register, serta interaksi langsung dengan kernel Linux melalui *System Calls* (Syscalls).

---

## 📂 Daftar Program

| Nama File | Deskripsi Fungsi |
| :--- | :--- |
| **`hello.s`** | Program dasar untuk mencetak teks `"Hello, World!"` ke layar terminal. |
| **`sapa.s`** | Program interaktif yang membaca input nama dari keyboard, lalu menampilkan sapaan balik secara dinamis. |

---

## 🛠️ Persiapan Lingkungan Kerja (Setup Environment)

Sebelum merakit atau mengompilasi kode program, pastikan alat-alat penunjang (`binutils` untuk *assembler* & *linker*) sudah terpasang di Termux kamu. Jika belum, jalankan perintah berikut:

```bash
pkg update && pkg upgrade -y
pkg install binutils clang -y

# 1. Assembling (Mengubah kode .s menjadi object file .o)
as -o sapa.o sapa.s

# 2. Linking (Menghubungkan object file menjadi file biner final)
ld -o sapa sapa.o

# 3. Eksekusi Program
./sapa

