.global _start

.text
// ==========================================
// PROSEDUR UTAMA: MAIN
// ==========================================
_start:
    // 1. Panggil prosedur input_char
    bl input_char
    
    // Simpan karakter hasil input dari w0 ke variabel 'char' di memori
    ldr x1, =char
    strb w0, [x1]

    // 2. Siapkan argumen untuk prosedur calc_sum
    ldr x0, =array      // x0 = alamat basis array
    mov x1, #5          // x1 = ukuran array (array_size equ 5)
    
    // Panggil prosedur calc_sum
    bl calc_sum         // Hasil penjumlahan total akan dikembalikan di w0

    // Simpan hasil penjumlahan dari w0 ke variabel 'sum' di memori
    ldr x1, =sum
    strh w0, [x1]       // strh digunakan untuk menyimpan data 2-byte (Halfword / dw)

    // 3. Keluar dari program dengan aman (Exit Syscall)
    mov x0, #0          // Status 0 (Sukses)
    mov x8, #93         // Syscall exit
    svc #0


// ==========================================
// PROSEDUR: input_char
// ==========================================
input_char:
    // Menampilkan prompt kecil ke layar agar user tahu harus mengetik
    mov x0, #1
    ldr x1, =prompt
    mov x2, #15
    mov x8, #64         // sys_write
    svc #0

    // Membaca 1 karakter dari keyboard
    mov x0, #0          // stdin
    ldr x1, =buffer_in  // Alamat penampung sementara
    mov x2, #1          // Baca 1 byte
    mov x8, #63         // sys_read
    svc #0

    // Ambil karakter yang diketik dari memori ke register w0 (sebagai return value)
    ldr x1, =buffer_in
    ldrb w0, [x1]
    ret                 // Kembali ke pemanggil (MAIN)


// ==========================================
// PROSEDUR: calc_sum
// Input: x0 = alamat array, x1 = jumlah elemen
// Output: w0 = hasil penjumlahan
// ==========================================
calc_sum:
    mov w0, #0          // Inisialisasi total penjumlahan = 0 (mov ax, 0)

cs1:
    cbz x1, calc_sum_end // Jika x1 (counter) sudah 0, keluar dari loop
    
    ldrh w2, [x0]       // Ambil data 2-byte dari alamat array saat ini (add ax, [bx])
    add w0, w0, w2      // Jumlahkan ke w0
    
    add x0, x0, #2      // Geser pointer array ke elemen berikutnya (add bx, 2)
    sub x1, x1, #1      // Kurangi counter (loop cs1)
    b cs1               // Lompat kembali ke awal loop

calc_sum_end:
    ret                 // Kembali ke pemanggil (MAIN)


.data
prompt:
    .ascii "Ketik 1 huruf: "

// Array data biner 16-bit (dw) sesuai dengan yang ada di buku teks kamu
array:
    .hword 0x100, 0x200, 0x300, 0x400, 0x500 

.bss
buffer_in:
    .skip 1
char:
    .skip 1
sum:
    .skip 2             // Tempat menyimpan hasil akhir (dw / 2 byte)

