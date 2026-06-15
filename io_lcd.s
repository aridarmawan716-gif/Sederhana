.global _start

.text
_start:
    // 1. Bersihkan Layar LCD Terminal (Clear Screen)
    mov x0, #1          // stdout
    ldr x1, =clear_cmd  // Panggil kode ANSI escape untuk clear screen
    mov x2, #4          // Panjang karakter "\033[2J"
    mov x8, #64         // sys_write
    svc #0

    // 2. Pindahkan Kursor ke Koordinat Tertentu (Baris 5, Kolom 10)
    mov x0, #1
    ldr x1, =move_cmd   // Panggil kode ANSI untuk posisi kursor
    mov x2, #8          // Panjang karakter "\033[5;10H"
    mov x8, #64         // sys_write
    svc #0

    // 3. Cetak Teks Utama dengan Warna Hijau
    mov x0, #1
    ldr x1, =text_msg   // Teks yang disisipkan kode warna hijau
    mov x2, #24         // Panjang total string teks + kode warna
    mov x8, #64         // sys_write
    svc #0

    // 4. Reset Warna LCD Kembali ke Normal & Turun Baris
    mov x0, #1
    ldr x1, =reset_cmd  // Panggil kode ANSI reset warna
    mov x2, #5          // Panjang karakter "\033[0m\n"
    mov x8, #64         // sys_write
    svc #0

    // 5. Keluar dari Program (Exit)
    mov x0, #0
    mov x8, #93         // sys_exit
    svc #0

.data
// \033 atau \x1b adalah karakter ESC (Escape) dalam kode ANSI

clear_cmd:
    .ascii "\033[2J"      // Perintah bersihkan seluruh layar

move_cmd:
    .ascii "\033[5;10H"   // Perintah pindah ke Baris 5, Kolom 10

text_msg:
    .ascii "\033[32m[ LCD Termux Aktif ]" // \033[32m mengubah teks jadi hijau

reset_cmd:
    .ascii "\033[0m\n"    // Membalikan warna ke default dan cetak enter (\n)

