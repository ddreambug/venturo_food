class ListRepository {
  // Dummy list of data
  final List<Map<String, dynamic>> data = [
    {
      "id_menu": 2,
      "name": "Chicken Slam ",
      "category": "makanan",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.s",
      "foto":
          "https://www.nrn.com/sites/nrn.com/files/styles/article_featured_retina/public/Dennys-6.99-Endless-Breakfast%20Credit%20Dennys%20Corp.jpg",
      "status": 1
    },
    {
      "id_menu": 3,
      "name": "Lemon Tea",
      "category": "minuman",
      "harga": 5000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Daun Teh dengan irisan lemon",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660e379fdf4.png",
      "status": 1
    },
    {
      "id_menu": 12,
      "name": "Chicken Slam Noodles",
      "category": "makanan",
      "harga": 16000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': false,
      "deskripsi": "as",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660e47317ea.png",
      "status": 1
    },
    {
      "id_menu": 13,
      "name": "Fried Rice",
      "category": "makanan",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "fr",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660ef6630d6.png",
      "status": 1
    },
    {
      "id_menu": 14,
      "name": "Fried Rice Noodles",
      "category": "makanan",
      "harga": 15000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "frn",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f05b2072.png",
      "status": 1
    },
    {
      "id_menu": 15,
      "name": "Bebek Goreng",
      "category": "makanan",
      "harga": 24000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "bg",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f2091f8c.png",
      "status": 1
    },
    {
      "id_menu": 16,
      "name": "Ayam Goreng",
      "category": "makanan",
      "harga": 15000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "AG",
      "foto":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMiX5F4A6GovnkUztggJyX8h21dKS8gjASPO0McSjTcWJR6vOtnLomhqsRJXn4zq5_s5s&usqp=CAU',
      "status": 1
    },
    {
      "id_menu": 17,
      "name": "Puyuh Goreng",
      "category": "makanan",
      "harga": 18000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "PG",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f43c0542.png",
      "status": 1
    },
    {
      "id_menu": 18,
      "name": "Frieno Java Code",
      "category": "makanan",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "FJC",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f519a3fb.png",
      "status": 1
    },
    {
      "id_menu": 19,
      "name": "Grilled Sausage",
      "category": "makanan",
      "harga": 16000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Sosis Bakar",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f6f077fc.png",
      "status": 1
    },
    {
      "id_menu": 20,
      "name": "French Fries",
      "category": "makanan",
      "harga": 10000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Kentang Goreng Dengan Saus Yang Gokil",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660f838c846.png",
      "status": 1
    },
    {
      "id_menu": 22,
      "name": "Potato Wedges",
      "category": "makanan",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Racikan Kentang Dengan Bumbu Spesial Khas Java Code",
      "foto": "https://javacode.landa.id/img/menu/gambar_62660fa11c345.png",
      "status": 1
    },
    {
      "id_menu": 23,
      "name": "Sascram Eggs",
      "category": "makanan",
      "harga": 15000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Sosis Bakar Yang Di Padukan Dengan Olahan Telur Scribble",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266100049ab0.png",
      "status": 1
    },
    {
      "id_menu": 24,
      "name": "Beef Burger",
      "category": "makanan",
      "harga": 14000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Burger Dengan Olahan Daging Sapi, Sayuran, Serta Keju",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661010e0ef6.png",
      "status": 1
    },
    {
      "id_menu": 25,
      "name": "Nugget",
      "category": "makanan",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "NG",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661020bdb0b.png",
      "status": 1
    },
    {
      "id_menu": 26,
      "name": "Maryam",
      "category": "makanan",
      "harga": 15000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Olahan Roti Khas timur tengah dengan topping coklat/Keju",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611270bce4.png",
      "status": 1
    },
    {
      "id_menu": 27,
      "name": "V60",
      "category": "minuman",
      "harga": 14000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Biji kopi arabika yang diolah menggunakan metode V60",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661057cc43c.png",
      "status": 1
    },
    {
      "id_menu": 28,
      "name": "Tubruk",
      "category": "minuman",
      "harga": 6000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Kopi Robusta Alami",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266108602d08.png",
      "status": 1
    },
    {
      "id_menu": 29,
      "name": "Kopi Susu Strong",
      "category": "minuman",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Kopi Robusta, Susu Uht, Creamer, Kental Manis",
      "foto": "https://javacode.landa.id/img/menu/gambar_626610a407c58.png",
      "status": 1
    },
    {
      "id_menu": 30,
      "name": "Kopi Brown Sugar",
      "category": "minuman",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Kopi Robusta + Susu + Brown Sugar",
      "foto": "https://javacode.landa.id/img/menu/gambar_626610bc4165e.png",
      "status": 1
    },
    {
      "id_menu": 31,
      "name": "Coffee Beer",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Coffee beer olahan",
      "foto": "https://javacode.landa.id/img/menu/gambar_626610ce5de4c.png",
      "status": 1
    },
    {
      "id_menu": 32,
      "name": "Vietnam Drip",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi":
          "Kopi Robusta, Kental Manis, Diolah Dengan metode khas Vietnam Drip",
      "foto":
          "https://www.shutterstock.com/image-photo/vietnamese-drip-coffee-condensed-milk-600w-2446020503.jpg",
      "status": 1
    },
    {
      "id_menu": 33,
      "name": "Kopi Java Code",
      "category": "minuman",
      "harga": 5000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "50% Robusta 50%Arabika",
      "foto":
          "https://media.istockphoto.com/id/681750926/id/foto/es-kopi-atau-caffe-latte.jpg?s=612x612&w=0&k=20&c=8csy9uvSMF86ErFR-8RYlwb9Zev3rpyJoyeKsEhL9zA=",
      "status": 1
    },
    {
      "id_menu": 34,
      "name": "Kopi Susu Creamy",
      "category": "minuman",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Kopi Robusta Olahan, Susu UHT, Creamer, Kental Manis",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661139ef69d.png",
      "status": 1
    },
    {
      "id_menu": 35,
      "name": "Long Black",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Kopi Robusta dengan metode Manual Brewing",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266114e5b5fb.png",
      "status": 1
    },
    {
      "id_menu": 36,
      "name": "Choco Coffee Creamy",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Kopi susu creamy + Chocolate spesial",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611611aa4d.png",
      "status": 1
    },
    {
      "id_menu": 37,
      "name": "Tea",
      "category": "minuman",
      "harga": 3000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Daun Teh Pilihan",
      "foto": "https://javacode.landa.id/img/menu/gambar_626612ccd777e.png",
      "status": 1
    },
    {
      "id_menu": 38,
      "name": "Matcha Hot",
      "category": "minuman",
      "harga": 11000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Greentea, Susu,Creamer",
      "foto":
          "https://t4.ftcdn.net/jpg/06/49/44/19/360_F_649441929_JZGvp4GcO38ZX4QqtjrukttYrVJje5EO.jpg",
      "status": 1
    },
    {
      "id_menu": 39,
      "name": "Ice Matcha",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Greentea, Susu,Creamer Ice",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611abc99af.png",
      "status": 1
    },
    {
      "id_menu": 40,
      "name": "Dark Chocolate Hot",
      "category": "minuman",
      "harga": 10000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Chocolate original + Susu ",
      "foto":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHGGe7lxf6sgNXMWEBiCVda_UhxdEzcNYL1g&s",
      "status": 1
    },
    {
      "id_menu": 41,
      "name": "Dark Chocolate Ice",
      "category": "minuman",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Chocolate original + Susu ",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611ec41fb8.png",
      "status": 1
    },
    {
      "id_menu": 42,
      "name": "Strawberry Lava",
      "category": "minuman",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Selai strawberry + Susu strawberry",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266120ada9ba.png",
      "status": 1
    },
    {
      "id_menu": 43,
      "name": "Susu Ovaltine",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Ovaltine+Susu",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266121c02b28.png",
      "status": 1
    },
    {
      "id_menu": 44,
      "name": "Lemon Tea",
      "category": "minuman",
      "harga": 5000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Daun teh irisan lemon",
      "foto": "https://javacode.landa.id/img/menu/gambar_62661234a177c.png",
      "status": 1
    },
    {
      "id_menu": 45,
      "name": "Blue Blood Ocean",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Jeruk Nipis, Coconut, Soda, Selasih",
      "foto": "https://javacode.landa.id/img/menu/gambar_626611fc53691.png",
      "status": 1
    },
    {
      "id_menu": 46,
      "name": "Blood Moon",
      "category": "minuman",
      "harga": 13000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Jeruk Nipis, Coconut, Soda, Selasih",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266123f80172.png",
      "status": 1
    },
    {
      "id_menu": 47,
      "name": "Orange Squash",
      "category": "minuman",
      "harga": 12000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Jeruk,Soda, Selasih, irisan lemon",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266124e669bc.png",
    },
    {
      "id_menu": 48,
      "name": "Jahe Merah",
      "category": "minuman",
      "harga": 5000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "Jahe Merah Tumbuk Hot",
      "foto": "https://javacode.landa.id/img/menu/gambar_6266125b05bc9.png",
    },
    {
      "id_menu": 52,
      "name": "empon empon",
      "category": "minuman",
      "harga": 8000,
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': true,
      "deskripsi": "ee",
      "foto": "https://javacode.landa.id/img/menu/gambar_626612746acd7.png",
    }
  ];

  // Dummy Promo
  final List<Map<String, dynamic>> promo = [
    {
      'promo_name': 'Voucher',
      'promo_property': 'Rp.200.000',
      'promo_description':
          'Berhasil mereferensikan rekan/teman untuk menjadi karyawan',
      'promo_requirement': [
        'Calon karyawan harus manusia',
        'Bisa membaca',
        'Mengerti setidaknya angka 1-10',
        'Mandiri secara harfiah',
      ],
      'promo_thumbnail':
          'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png',
    },
    {
      'promo_name': 'Diskon',
      'promo_property': '10%',
      'promo_description': 'Mengikuti kegiatan tahsin/mengaji',
      'promo_requirement': [
        'Ikut kegiatan tahsin',
        'Beragama Islam',
        'Bisa membaca Al-Quran',
        'Sudah Baligh',
      ],
      'promo_thumbnail':
          'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png',
    },
    {
      'promo_name': 'Diskon',
      'promo_property': '100%',
      'promo_description': 'Mengambil Makanan diam diam',
      'promo_requirement': [
        'Berseragam',
        'Memakai topi',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
        'item desc',
      ],
      'promo_thumbnail':
          'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png',
    },
  ];

  List<Map<String, dynamic>> sortData(
    List<Map<String, dynamic>> list,
  ) {
    list.sort(
      (a, b) => a['category'].toString().compareTo(
            b['category'].toString(),
          ),
    );
    return list;
  }

  // Get list of data
  Map<String, dynamic> getListOfData({int offset = 0}) {
    int limit = 5 + offset;
    sortData(data);

    if (limit > data.length) limit = data.length;
    return {
      'data': data.getRange(offset, limit).toList(),
      'next': limit < data.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  Map<String, dynamic> getListOfPromo() {
    return {
      'promo': promo.toList(),
    };
  }

  // Delete item
  void deleteItem(int id) {
    data.removeWhere((element) => element['id_menu'] == id);
  }
}