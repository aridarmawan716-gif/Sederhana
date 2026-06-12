.global _start

.text
_start:
    // 1. Inisialisasi variabel aljabar ke dalam register
    mov w1, #5          // a = 5
    mov w2, #3          // b = 3
    mov w3, #2          // c = 2

    // 2. Operasi Aljabar: y = (a + b) * c
    add w4, w1, w2      // w4 = a + b  (5 + 3 = 8)
    mul w0, w4, w3      // w0 = w4 * c (8 * 2 = 16) -> Hasil akhir disimpan di w0

    // 3. Konversi hasil (16) menjadi karakter ASCII ('16') agar bisa dicetak
    // Untuk kesederhanaan angka di bawah 100:
    mov w5, #10
    udiv w6, w0, w5     // w6 = 16 / 10 = 1 (Angka puluhan)
    msub w7, w6, w5, w0 // w7 = 16 - (1 * 10) = 6 (Angka satuan)

    // Ubah angka menjadi karakter ASCII dengan menambahkannya dengan '0' (48)
    add w6, w6, #48     // Karakter '1'
    add w7, w7, #48     // Karakter '6'

    // Simpan karakter ke dalam memori buffer 'hasil'
    ldr x1, =hasil
    strb w6, [x1]       // Simpan '1' di byte pertama
    strb w7, [x1, #1]   // Simpan '6' di byte kedua

    // 4. Cetak teks "Hasil y = "
    mov x0, #1          // stdout
    ldr x1, =msg        // Alamat teks msg
    mov x2, #10         // Panjang teks "Hasil y = "
    mov x8, #64         // Syscall write
    svc #0

    // 5. Cetak nilai hasil aljabar yang tadi dihitung ("16")
    mov x0, #1          // stdout
    ldr x1, =hasil      // Alamat memori 'hasil'
    mov x2, #3          // Panjang karakter (termasuk baris baru \n)
    mov x8, #64         // Syscall write
    svc #0

    // 6. Keluar dari program (Exit)
    mov x0, #0          // Return code 0
    mov x8, #93         // Syscall exit
    svc #0

.data
msg:
    .ascii "Hasil y = "

.bss
hasil:
    .skip 3             // Menyediakan tempat 3 byte di memori untuk "16\n"

