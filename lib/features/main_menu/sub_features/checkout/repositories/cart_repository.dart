// import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CartRepository {
  // API post kendala beda struktur data
  //Future<void> postOrder() async {
  //   var dio = Dio();
  //   var headers = {
  //     'token': '5b90e85d28255df4e6c4e57053d0a87063157de3',
  //     'Content-Type': 'application/json',
  //   };
  //   var requestBody = {
  //     "order": {
  //       "id_user": 1,
  //       "id_voucher": 1,
  //       "potongan": 45000,
  //       "total_bayar": 12800
  //     },
  //     "menu": [
  //       {
  //         "id_menu": 2,
  //         "harga": 18000,
  //         "level": 1,
  //         "topping": [1, 2],
  //         "jumlah": 2
  //       },
  //       {
  //         "id_menu": 3,
  //         "harga": 10000,
  //         "level": 2,
  //         "topping": [2, 3],
  //         "jumlah": 1
  //       }
  //     ]
  //   };

  //   try {
  //     var response = await dio.post(
  //       'https://trainee.landa.id/javacode/order/add',
  //       data: jsonEncode(requestBody),
  //       options: Options(headers: headers),
  //     );

  //     if (response.statusCode == 200) {
  //       print('Response: ${response.data}');
  //     } else {
  //       print('Failed: ${response.statusMessage}');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  List<Map<String, dynamic>>? cart;

  List<Map<String, dynamic>> sortCart(
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
  Map<String, dynamic> getListOfCart() {
    sortCart(cart!);

    return {
      'cart': cart!.getRange(0, cart!.length).toList(),
    };
  }

  // Add Item
  void addCartItem(Map<String, dynamic> item) {
    cart ??= [];
    cart!.add(item);
    getListOfCart();
  }

  // Delete item
  void deleteCartItem(int id) {
    cart!.removeWhere((element) => element['id_menu'] == id);
  }

  Future<bool> emptyCartItem() async {
    try {
      cart!.removeRange(0, cart!.length);
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      return false;
    }
  }
}
