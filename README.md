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

## Praktikum 3
### Soal 5
```dart
late Completer completer;

  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  }
```
Penjelasan:
Setelah 5 detik, nilai 42 tersedia di Future yang dikembalikan oleh getNumber().
![Capture soal 5](images/books5.gif)

### Soal 6
```dart
Future calculate() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    } catch (_) {
      completer.completeError({});
    }
}

getNumber() 
    .then((value) {
      setState(() {
        result = value.toString();
      });
    })
    .catchError((e) {
      result = 'An Error Occurred';
    });
```
Penjelasan:
1. getNumber() tetap sama seperti sebelumnya, tetapi cara menggunakannya berbeda.
2. calculate() menggunakan try-catch untuk menangani error:
    - Jika sukses, Future selesai dengan complete(42).
    - Jika gagal, Future akan menyelesaikan dengan error (completeError({})).
3. Ketika memanggil getNumber(), kita menangani hasilnya dengan:
    - then((value) { ... }) → Jika sukses, hasil disimpan di result.
    - catchError((e) { ... }) → Jika gagal, akan menampilkan pesan error "An Error Occurred".

Perbedaan dengan langkah 2 adalah tidak ada error handling:
* Tanpa error handling:
    - Jika terjadi error, Future tidak akan pernah selesai.
    - Kode yang menunggu hasilnya akan terjebak selamanya.
    - UI bisa menjadi tidak responsif atau stuck.
* Dengan error handling:
    - Jika terjadi error, Future akan selesai dengan completeError().
    - catchError() dapat menangani error dengan baik.
    - Aplikasi tetap stabil dan responsif.
![Capture soal 6](images/books6.gif)

## Praktikum 4
### Soal 7
![Capture soal 7](images/books7.gif)

### Soal 8
Perbedaan langkah 1 dan langkah 4
* Future.wait<int>
Kelebihan:
    - Eksekusi semua Future secara paralel, lalu mengambil hasilnya sekaligus.
    - Cocok jika kita ingin menunggu semua Future selesai tanpa harus mengelolanya satu per satu.
    - Tidak fleksibel dalam menangani error → Jika satu Future gagal, semua dianggap gagal.
    - Tidak bisa menambah Future setelah Future.wait([...]) dipanggil.

* FutureGroup<int>
    - Lebih fleksibel → Kita bisa menambahkan Future satu per satu sebelum close().
    - Bisa menangani Future secara lebih dinamis, misalnya kita bisa menambahkan Future berdasarkan kondisi tertentu.
    - Harus menggunakan package async, karena FutureGroup bukan bagian dari Dart core.
    - Tidak seintuitif Future.wait() jika hanya ingin menjalankan beberapa Future sederhana.

## Praktikum 5
### Soal 9
![Capture soal 9](images/books8.gif)

### Soal 10
Hasilnya sama tapi ada perbedaan
Perbedaan langkah 1 dan langkah 4
* Method returnError()
    - Kurang rapi kalau logic kompleks
    - Penanganan error Diatur langsung di UI

* Method handleError()
    - Lebih rapi, reusable
    - Penanganan error diatur dalam method terpisah

## Praktikum 6
### Soal 12
Bisa, Karena browser modern (seperti Chrome, Firefox, Edge) mendukung HTML5 Geolocation API, yang memungkinkan web app (termasuk Flutter Web) untuk meminta lokasi perangkat.
![Capture soal 12](images/books9.gif)

## Praktikum 7
### Soal 13
Ya, terdapat perbedaan pada UI-nya. Perbedaan antara kode sekarang dengan FutureBuilder dan kode sebelumnya dengan setState terletak pada cara UI diperbarui saat data lokasi sudah tersedia.FutureBuilder secara otomatis membangun ulang UI berdasarkan status Future, sehingga lebih rapi dan reaktif tanpa perlu memanggil setState secara manual. Sementara pada versi setState, kamu harus menunggu hasil secara manual dan memicu pembaruan UI dengan setState setelah data diterima.
![Capture soal 13](images/books10.gif)