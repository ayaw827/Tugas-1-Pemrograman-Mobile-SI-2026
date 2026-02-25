# Tugas 1 Pemrograman Aplikasi Bergerak SI 2026
Nurhidayah | 2409116002 A'24

## 🛍️ 1. Halaman Katalog (Album Taste)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/979f0387-4312-48b0-99b7-32ec21035d5b" />

Pada halaman katalog, aplikasi menampilkan daftar produk album yang tersedia untuk dibeli oleh pengguna. Setiap produk ditampilkan dalam bentuk card yang berisi gambar album, nama produk, deskripsi singkat, serta harga. Terdapat tiga varian album yang ditawarkan, yaitu Savory Version, Full Spread Version, dan Tin Case Version. Selain itu, setiap card dilengkapi dengan tombol “Add” yang memungkinkan pengguna untuk menambahkan produk ke dalam keranjang belanja. Tampilan halaman ini dirancang sederhana dan informatif agar pengguna dapat dengan mudah memilih produk yang diinginkan.

## 🛒 2. Keranjang Kosong (Empty Cart State)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2ae17f45-8460-4732-a499-530efe8cd163" />

Pada kondisi ketika pengguna belum menambahkan produk ke dalam keranjang, aplikasi akan menampilkan halaman keranjang kosong. Halaman ini berisi ikon keranjang dan pesan “Your cart is empty” sebagai indikator bahwa belum ada item yang dipilih. Selain itu, terdapat tombol “Continue Shopping” yang berfungsi untuk mengarahkan pengguna kembali ke halaman katalog. Fitur ini membantu memberikan pengalaman pengguna yang jelas terkait kondisi keranjang yang masih kosong.

## 🧺 3. Keranjang Belanja (Shopping Cart)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/287c5a22-a7bb-46f8-8605-c25cf5e2b836" />

Setelah pengguna menambahkan produk, halaman keranjang akan menampilkan daftar item yang telah dipilih. Setiap item ditampilkan lengkap dengan gambar, nama produk, harga, serta jumlah (quantity). Pengguna dapat menambah atau mengurangi jumlah item menggunakan tombol plus (+) dan minus (-). Selain itu, tersedia tombol hapus (ikon tempat sampah) untuk menghapus produk dari keranjang. Di bagian bawah halaman, ditampilkan total harga keseluruhan dari semua item yang ada di keranjang. Tersedia juga tombol “Checkout” yang digunakan untuk melanjutkan proses pembelian.

## 💳 4. Checkout Modal

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/01538cfa-f5fe-45ca-a636-2ade4ec72c2b" />

Ketika pengguna menekan tombol checkout, akan muncul sebuah modal sebagai konfirmasi sebelum transaksi dilakukan. Modal ini menampilkan ringkasan pesanan berupa total harga yang harus dibayar dan jumlah item yang dibeli. Pengguna diberikan dua pilihan, yaitu tombol “Cancel” untuk membatalkan proses checkout, dan tombol “Confirm” untuk melanjutkan transaksi. Fitur ini bertujuan untuk memastikan pengguna melakukan konfirmasi sebelum pesanan diproses.

## 🎉 5. Konfirmasi Pesanan

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4ec4acf4-c79e-405e-b2e6-642a53345906" />

Setelah pengguna menekan tombol konfirmasi, aplikasi akan menampilkan notifikasi “Order placed!” sebagai tanda bahwa pesanan telah berhasil dilakukan. Setelah itu, keranjang belanja akan dikosongkan secara otomatis dan pengguna akan diarahkan kembali ke halaman katalog. Hal ini menandakan bahwa proses transaksi telah selesai dan pengguna dapat kembali melakukan pembelian lainnya.

## 🔁 Flow Penggunaan (Singkat)

1. User lihat produk → klik **Add**
2. Masuk ke **Shopping Cart**
3. Atur jumlah / hapus item
4. Klik **Checkout**
5. Konfirmasi → **Order placed**

Santai 😄 ini aku buatin **judul + penjelasan per file (per .dart)** yang bisa langsung kamu salin ke laporan. Sudah dibuat formal tapi tetap gampang dipahami.

# 📱 Penjelasan Implementasi Kode Program

## 1. `main.dart`

## 🧠 main.dart

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/cart_model.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}
```

File `main.dart` merupakan titik awal (entry point) dari aplikasi Flutter. Pada file ini, aplikasi dijalankan menggunakan fungsi `main()` yang membungkus `MyApp` dengan `ChangeNotifierProvider`.

Penggunaan **Provider** bertujuan untuk mengelola state aplikasi, khususnya data keranjang belanja (`CartModel`). Dengan pendekatan ini, data cart dapat diakses dan diperbarui dari berbagai halaman dalam aplikasi.

Class `MyApp` merupakan widget utama yang mengatur konfigurasi aplikasi seperti:

* Judul aplikasi (Shopping Cart)
* Tema aplikasi menggunakan `Material3`
* Halaman awal (`home`) yang diarahkan ke `ProductListPage`

Dengan struktur ini, aplikasi memiliki arsitektur yang terorganisir dan mendukung pengelolaan state secara efisien.

## 2. `product_list_page.dart`

File ini berfungsi untuk menampilkan halaman katalog produk. Data produk disimpan dalam bentuk list yang berisi objek `AlbumTaste`, yang mencakup informasi seperti nama produk, harga, gambar, dan deskripsi.

Tampilan utama menggunakan `GridView.builder` yang bersifat responsif. Jumlah kolom akan menyesuaikan dengan lebar layar menggunakan `LayoutBuilder`, sehingga aplikasi dapat berjalan dengan baik di berbagai ukuran perangkat.

Setiap produk ditampilkan dalam bentuk card yang terdiri dari:

* Gambar produk
* Nama dan deskripsi
* Harga
* Tombol **Add**

Ketika tombol **Add** ditekan, fungsi `addItem()` dari `CartModel` akan dipanggil untuk menambahkan produk ke dalam keranjang. Selain itu, ditampilkan notifikasi `SnackBar` sebagai feedback kepada pengguna.

Pada bagian AppBar, terdapat ikon keranjang yang dilengkapi badge jumlah item. Badge ini akan otomatis berubah karena menggunakan `Consumer<CartModel>`, yang akan merespon perubahan state secara real-time.

## 3. `cart_page.dart`

File ini digunakan untuk menampilkan halaman keranjang belanja. Data cart diambil menggunakan `Consumer<CartModel>` sehingga tampilan akan otomatis diperbarui ketika terjadi perubahan.

Terdapat dua kondisi utama:

1. **Keranjang kosong**

   * Menampilkan ikon dan pesan *“Your cart is empty”*
   * Tombol untuk kembali ke halaman katalog

2. **Keranjang berisi**

   * Menampilkan daftar item menggunakan `ListView.builder`
   * Setiap item memiliki:

     * Gambar produk
     * Nama dan harga
     * Kontrol jumlah (tombol + dan -)
     * Tombol hapus item
     * Subtotal harga

Di bagian bawah terdapat total harga keseluruhan dan tombol **Checkout**. Ketika tombol checkout ditekan, akan muncul dialog konfirmasi yang menampilkan total harga dan jumlah item.

Jika pengguna menekan tombol **Confirm**, maka:

* Data cart akan dikosongkan
* Kembali ke halaman sebelumnya
* Muncul notifikasi *“Order placed!”*

## 4. `product.dart` (Model Produk)

File ini berisi class `AlbumTaste` yang digunakan sebagai model data produk. Class ini menyimpan atribut:

* `id`
* `name`
* `price`
* `image`
* `description`

Model ini memudahkan pengelolaan data karena setiap produk direpresentasikan sebagai objek yang terstruktur.

## 5. `cart_model.dart`

File ini merupakan inti dari logika aplikasi, yaitu pengelolaan state keranjang belanja. Class `CartModel` menggunakan `ChangeNotifier` sehingga setiap perubahan data dapat langsung memperbarui UI.

Data cart disimpan dalam bentuk `Map<String, CartItem>` untuk mempermudah pencarian dan manipulasi data.

Fungsi utama dalam class ini meliputi:

* `addItem()` → menambahkan produk ke cart
* `removeItem()` → menghapus produk
* `increaseQuantity()` → menambah jumlah item
* `decreaseQuantity()` → mengurangi jumlah item
* `clear()` → menghapus seluruh isi cart

Selain itu, terdapat getter seperti:

* `totalPrice` → menghitung total harga
* `totalQuantity` → menghitung total item
* `isEmpty` → mengecek apakah cart kosong

Setiap perubahan akan memanggil `notifyListeners()` agar UI langsung ter-update.

## 6. `cart_item.dart`

File ini berisi class `CartItem` yang merepresentasikan item di dalam keranjang. Class ini menyimpan:

* Data produk (`AlbumTaste`)
* Jumlah item (`quantity`)

Selain itu, terdapat getter `totalPrice` yang digunakan untuk menghitung total harga berdasarkan jumlah item yang dipilih.
