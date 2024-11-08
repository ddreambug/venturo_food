import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/utils/services/dio_service.dart';

class ListRepository {
  List<Map<String, dynamic>> data = [];

  final List<Map<String, dynamic>> promo = [
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

  // API Fetch - Conflict data structure
  Future<List<Map<String, dynamic>>> fetchApiData() async {
    final dio = DioService().getDio(
      token: 'f512231c56daa09bcfe7e44d010252a2e2f8f111',
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
      print('fetch data length: ${data.length}');
      return data;
    } catch (e) {
      return data;
    }
  }

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
    int limit = 35 + offset;
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
