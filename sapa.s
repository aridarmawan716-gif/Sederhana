.global _start

.text
_start:
    // 1. Cetak teks pertanyaan (Tanya nama)
    mov x0, #1          // stdout
    ldr x1, =tanya      // Alamat string 'tanya'
    mov x2, #19         // Panjang string
    mov x8, #64         // Syscall write
    svc #0

    // 2. Baca input dari user (Keyboard)
    mov x0, #0          // stdin (keyboard)
    ldr x1, =input      // Buffer untuk menyimpan input
    mov x2, #30         // Maksimal 30 karakter yang dibaca
    mov x8, #63         // Syscall read
    svc #0
    mov x19, x0         // Simpan panjang input yang dibaca ke x19

    // 3. Cetak teks sapaan ("Halo, ")
    mov x0, #1          // stdout
    ldr x1, =sapa       // Alamat string 'sapa'
    mov x2, #6          // Panjang string "Halo, "
    mov x8, #64         // Syscall write
    svc #0

    // 4. Cetak nama yang tadi diinput user
    mov x0, #1          // stdout
    ldr x1, =input      // Alamat buffer input tadi
    mov x12, x19        // Pindahkan panjang karakter ke register x12
    mov x2, x12         // Masukkan panjang karakter ke x2 untuk dicetak
    mov x8, #64         // Syscall write
    svc #0

    // 5. Keluar dari program (Exit)
    mov x0, #0          // Return code 0
    mov x8, #93         // Syscall exit
    svc #0

.data
tanya:
    .ascii "Masukkan nama kamu: "
sapa:
    .ascii "Halo, "

.bss
input:
    .skip 30            // Alokasikan memori kosong sebesar 30 byte

