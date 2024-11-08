import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/utils/services/dio_service.dart';

class ListRepository {
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> promo = [];
  var box = Hive.box('venturo');
  String get token => DioService()
      .getDio(
        token: box.get(
          'token',
          defaultValue: 'f512231c56daa09bcfe7e44d010252a2e2f8f111',
        ),
      )
      .toString();

  final List<Map<String, dynamic>> promos = [
    {
      'promo_name': 'Voucher',
      'promo_property': 'Rp.200.000',
      'value': 200000,
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
      'promo_image': ImageConstant.voucherReferral,
      'valid_date': '19/11/2021 - 31/01/2022',
    },
    {
      'promo_name': 'Voucher',
      'promo_property': 'Rp.100.000',
      'value': 100000,
      'promo_description': 'Koordinator Program Kekompakan',
      'promo_requirement': [
        'Hanya untuk Koordinator Program Karyawan',
      ],
      'promo_thumbnail':
          'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png',
      'promo_image': ImageConstant.voucherKoordinator,
      'valid_date': '19/11/2021 - 31/01/2022',
    },
    {
      'promo_name': 'Voucher',
      'promo_property': 'Rp.100.000',
      'value': 100000,
      'promo_description': 'Ulang Tahun',
      'promo_requirement': [
        'Hanya berlaku hingga H+1 hari ulang tahun',
      ],
      'promo_thumbnail':
          'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png',
      'promo_image': ImageConstant.voucherBirthday,
      'valid_date': '19/11/2021 - 31/01/2022',
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

  // API Fetch - Menu
  Future<List<Map<String, dynamic>>> fetchApiData() async {
    final dio = DioService().getDio(
      token: "f512231c56daa09bcfe7e44d010252a2e2f8f111",
    );

    try {
      var response = await dio.get(
        'https://trainee.landa.id/javacode/menu/all',
      );
      if (response.data['status_code'] == 200) {
        var listdata = response.data['data'] as List;

        data = listdata.map((item) => transformApiData(item)).toList();
        return data;
      }
      return data;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      return data;
    }
  }

  // API Fetch - Promo
  Future<List<Map<String, dynamic>>> fetchApiPromo() async {
    final dio = DioService().getDio(
      token: "f512231c56daa09bcfe7e44d010252a2e2f8f111",
    );

    try {
      var response = await dio.get(
        'https://trainee.landa.id/javacode/promo/all',
      );
      if (response.data['status_code'] == 200) {
        var promoData = response.data['data'] as List;

        promo = promoData.map((item) => transformApiPromo(item)).toList();
        return promo;
      }
      return promo;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      return promo;
    }
  }

  // Get list of data
  Map<String, dynamic> getListOfData({int offset = 0}) {
    int limit = 5 + offset;
    sortData(data);

    if (limit > data.length) limit = data.length;
    return {
      'data': limit == 35
          ? data.getRange(offset, data.length).toList()
          : data.getRange(offset, limit).toList(),
      'next': limit < data.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  // Get list of promo
  Map<String, dynamic> getListOfPromo() {
    return {
      'promo': promo.toList(),
    };
  }

  // Delete item
  void deleteItem(int id) {
    data.removeWhere((element) => element['id_menu'] == id);
  }

  /// API Structure Transformer
  // Data Transform
  Map<String, dynamic> transformApiData(Map<String, dynamic> apiData) {
    return {
      "id_menu": apiData["id_menu"],
      "name": apiData["nama"],
      "category": apiData["kategori"],
      "harga": apiData["harga"],
      'jumlah': 0,
      'level': 0,
      'toping': 'Tanpa Toping',
      'catatan': 'Tambahkan Catatan',
      'stok': apiData["status"] == 1,
      "deskripsi": apiData["deskripsi"],
      "foto": apiData["foto"],
    };
  }

  // Promo Transform
  Map<String, dynamic> transformApiPromo(Map<String, dynamic> apiPromo) {
    final today = DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy');
    final expiryDays = apiPromo['kadaluarsa'];
    final endDate =
        expiryDays != null ? today.add(Duration(days: expiryDays)) : today;
    final validDate =
        '${dateFormat.format(today)} - ${dateFormat.format(endDate)}';
    final imageUrl = (apiPromo['foto'] != null && apiPromo['foto']!.isNotEmpty)
        ? apiPromo['foto']
        : 'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png';
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    return {
      'id_promo': apiPromo['id_promo'],
      'promo_name': apiPromo['type'] ?? 'voucher',
      'promo_property': apiPromo['diskon'] != null
          ? '${apiPromo['diskon'].toString()}%'
          : formatter.format(apiPromo['nominal']),
      'value': apiPromo['nominal'] ?? 0,
      'promo_description': apiPromo['nama'] ?? '',
      'promo_requirement':
          _parseRequirements(apiPromo['syarat_ketentuan'] ?? ''),
      'promo_thumbnail': imageUrl,
      'promo_image': imageUrl,
      'valid_date': validDate,
    };
  }

  /// Helpers
  // Data Sort
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

  // HTML Cleaner
  List<String> _parseRequirements(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }
}
