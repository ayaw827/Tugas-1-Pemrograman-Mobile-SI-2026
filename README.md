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

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      AlbumTaste(
        id: '1',
        name: 'TASTE - Savory Ver.',
        price: 350000,
        image: 'savory.jpg',
        description: 'CD-R, photobook, postcards, secret message card.',
      ),
      AlbumTaste(
        id: '2',
        name: 'TASTE - Full Spread Ver.',
        price: 420000,
        image: 'fullspread.jpg',
        description: '96p photobook, poster, sticker, photocard.',
      ),
      AlbumTaste(
        id: '3',
        name: 'TASTE - Tin Case Ver.',
        price: 500000,
        image: 'tincase.jpg',
        description: 'Tin case, mini CD, accordion photos, pin.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Taste'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = (constraints.maxWidth / 250).floor();
          if (crossAxisCount < 1) crossAxisCount = 1;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, AlbumTaste product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/${product.image}',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Text('Rp ${product.price.toStringAsFixed(0)}'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartModel>().addItem(product);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

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

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return cart.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Clear Cart?'),
                            content: const Text('Remove all items from cart?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<CartModel>().clear();
                                  Navigator.pop(ctx);
                                },
                                child: const Text('Clear'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100),
                  const SizedBox(height: 20),
                  const Text('Your cart is empty'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Continue Shopping'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.itemsList.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.itemsList[index];
                    final product = cartItem.product;

                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Rp ${product.price}'),
                      trailing: Text('x${cartItem.quantity}'),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: Rp ${cart.totalPrice}'),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Checkout'),
                            content: Text(
                              'Total: Rp ${cart.totalPrice}\nItems: ${cart.totalQuantity}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cart.clear();
                                  Navigator.pop(ctx);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Order placed!'),
                                    ),
                                  );
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

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

```dart
import 'package:flutter/foundation.dart';
import 'product.dart';
import 'cart_item.dart';

class CartModel extends ChangeNotifier {
  // Private state - Map for O(1) lookup
  final Map<String, CartItem> _items = {};

  // Getters
  Map<String, CartItem> get items => _items;

  List<CartItem> get itemsList => _items.values.toList();

  int get itemCount => _items.length;

  int get totalQuantity {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  bool get isEmpty => _items.isEmpty;

  // Methods
  void addItem(AlbumTaste product) {
    if (_items.containsKey(product.id)) {
      // Product already in cart, increase quantity
      _items[product.id]!.quantity++;
    } else {
      // New product, add to cart
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners(); // ← Notif UInyaw!
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      // If quantity becomes 0, remove item
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
```

File ini berisi class `AlbumTaste` yang digunakan sebagai model data produk. Class ini menyimpan atribut:

* `id`
* `name`
* `price`
* `image`
* `description`

Model ini memudahkan pengelolaan data karena setiap produk direpresentasikan sebagai objek yang terstruktur.

## 5. `cart_model.dart`

```dart
import 'package:flutter/foundation.dart';
import 'product.dart';
import 'cart_item.dart';

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  // Getters
  Map<String, CartItem> get items => _items;

  List<CartItem> get itemsList => _items.values.toList();

  int get itemCount => _items.length;

  int get totalQuantity {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  bool get isEmpty => _items.isEmpty;

  // Methods
  void addItem(AlbumTaste product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners(); // ← Notif UInyaw!
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
```

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

```dart
import 'product.dart';

class CartItem {
  final AlbumTaste product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}
```

File ini berisi class `CartItem` yang merepresentasikan item di dalam keranjang. Class ini menyimpan:

* Data produk (`AlbumTaste`)
* Jumlah item (`quantity`)

Selain itu, terdapat getter `totalPrice` yang digunakan untuk menghitung total harga berdasarkan jumlah item yang dipilih.
