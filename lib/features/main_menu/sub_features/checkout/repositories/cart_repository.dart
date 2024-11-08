import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:convert';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/utils/services/dio_service.dart';

class CartRepository {
  List<Map<String, dynamic>>? cart;
  var box = Hive.box('venturo');
  Dio get dio => DioService().getDio(token: box.get('token', defaultValue: ''));

  Future<Response<dynamic>> postOrder(
    num potongan,
    num total,
    num idVoucher,
    List<Map<String, dynamic>> menu,
  ) async {
    try {
      var requestBody = {
        "order": {
          "id_user": 1001,
          "id_voucher": idVoucher,
          "potongan": potongan,
          "total_bayar": total
        },
        "menu": menu
      };
      final response = await dio.post(
        'https://trainee.landa.id/javacode/order/add',
        data: jsonEncode(requestBody),
      );
      await Sentry.captureMessage(
        'Order posted successfully: $response',
        level: SentryLevel.info,
      );

      return response;
    } catch (error, stackTrace) {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  List<Map<String, dynamic>> sortCart(List<Map<String, dynamic>> list) {
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

    return {'cart': cart!.getRange(0, cart!.length).toList()};
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
