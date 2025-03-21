# Laporan Praktikum

A Flutter project Books.

## Praktikum 1
### Soal 2
![Capture soal 2](images/books1.png)

### Soal 3
![Capture soal 3](images/books2.jpg)

```dart
onPressed: () {
            setState(() {});
            getData()
                .then((value) {
                    result = value.body.toString().substring(0, 450);
                    setState(() {});
                })
                .catchError((_) {
                    result = 'An Error Occurred';
                    setState(() {});
                });
            },
```
1. Penggunaan substring(0, 450)
substring(0, 450): Mengambil 450 karakter pertama dari hasil response.
Berguna jika response terlalu panjang, sehingga hanya sebagian kecil ditampilkan.

2. catchError(_) / Menangani Kesalahan (Error Handling)
Jika getData() gagal (misalnya koneksi terputus atau server error), fungsi catchError() akan menangkap error tersebut.
Error ditangani dengan menampilkan pesan "An Error Occurred" agar pengguna tahu ada masalah. 
setState(() {}); dipanggil agar UI diperbarui dengan pesan error.

## Praktikum 2
### Soal 4
* Langkah 1: Menambahkan Tiga Method Asynchronous
```dart
Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }
```

Penjelasan:
1. Future<int>: Method ini mengembalikan nilai bertipe Future<int>, yang berarti nilainya tidak langsung tersedia, melainkan akan didapatkan setelah proses asinkron selesai.
2. await Future.delayed(Duration(seconds: 3)): 
    - Simulasi proses yang membutuhkan waktu 3 detik (misalnya pemanggilan API atau proses berat lainnya).
    - await memastikan eksekusi menunggu selama 3 detik sebelum melanjutkan ke baris berikutnya.
3. Setelah menunggu, masing-masing method mengembalikan angka tertentu (1, 2, atau 3).

* Langkah 2: Menambahkan Method count()
```dart
Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }
```

Penjelasan:
1. Future count() async {} -> Method ini bertipe Future karena menggunakan await untuk menangani operasi asinkron.
2. int total = 0; -> Variabel untuk menyimpan hasil perhitungan.
3. Menjalankan tiga method async secara berurutan:
    - total = await returnOneAsync(); -> Tunggu 3 detik, lalu total = 1.
    - total += await returnTwoAsync(); -> Tunggu 3 detik lagi, lalu total = 1 + 2 = 3.
    - total += await returnThreeAsync(); -> Tunggu 3 detik lagi, lalu total = 3 + 3 = 6.
    - Total waktu eksekusi = 3 + 3 + 3 = 9 detik (karena dijalankan secara berurutan).
4. setState(() { result = total.toString(); }); -> Memperbarui UI setelah semua operasi selesai (9 detik), nilai total dikonversi ke String dan ditampilkan di UI.
![Capture soal 4](images/books4.gif)