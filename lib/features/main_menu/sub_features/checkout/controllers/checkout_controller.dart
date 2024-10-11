import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/features/main_menu/repositories/list_repository.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/repositories/cart_repository.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_bottom_sheet.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find<CheckoutController>();
  final CartRepository _cartRepository = CartRepository();
  final TextEditingController catatanTextController = TextEditingController();
  RxInt catatanLength = 0.obs;
  final RxList<Map<String, dynamic>> items = ListController.to.items;
  final RxList<Map<String, dynamic>> cart = <Map<String, dynamic>>[].obs;
  final RxMap<String, dynamic> editCart = {
    'jumlah': 0,
    'level': 0,
    'toping': 'Tanpa Toping',
    'catatan': 'Tambahkan Catatan'
  }.obs;
  final RxList<Map<String, dynamic>> selectedItems =
      <Map<String, dynamic>>[].obs;
  final List<Map<String, dynamic>> voucher = [];

  @override
  void onInit() async {
    super.onInit();
    getVoucherList();
    await getListOfCart();
  }

  void showMenuProperty(
      Map<String, dynamic> menuItem, DetailType detailType, EditType editType) {
    Get.bottomSheet(
      barrierColor: const Color.fromARGB(40, 55, 55, 55),
      CustomBottomSheet(
        menuItem: menuItem,
        detailType: detailType,
        editType: editType,
      ),
    );
  }

  void updateLevel({
    required int idMenu,
    required int newLevel,
    EditType editType = EditType.list,
  }) {
    if (editType == EditType.cart) {
      int itemIndex = cart.indexWhere((item) => item['id_menu'] == idMenu);
      cart[itemIndex]['level'] = newLevel;

      cart.refresh();
    } else {
      int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
      items[itemIndex]['level'] = newLevel;

      if (items[itemIndex]['jumlah'] == 0) {
        updateItemCount(idMenu: idMenu, modifier: 1);
      }

      items.refresh();
    }
  }

  void updateToping({
    required int idMenu,
    required String newToping,
    EditType editType = EditType.list,
  }) {
    if (editType == EditType.cart) {
      int itemIndex = cart.indexWhere((item) => item['id_menu'] == idMenu);
      cart[itemIndex]['toping'] = newToping;

      if (cart[itemIndex]['jumlah'] == 0) {
        updateItemCount(idMenu: idMenu, modifier: 1, editType: editType);
      }
      cart.refresh();
    } else {
      int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
      items[itemIndex]['toping'] = newToping;

      if (items[itemIndex]['jumlah'] == 0) {
        updateItemCount(idMenu: idMenu, modifier: 1);
      }
      items.refresh();
    }
  }

  void updateCatatan({
    required int idMenu,
    EditType editType = EditType.list,
  }) {
    if (editType == EditType.cart) {
      int itemIndex = cart.indexWhere((item) => item['id_menu'] == idMenu);
      cart[itemIndex]['catatan'] = catatanTextController.text;

      cart.refresh();
    } else {
      int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
      items[itemIndex]['catatan'] = catatanTextController.text;

      if (items[itemIndex]['jumlah'] == 0) {
        updateItemCount(idMenu: idMenu, modifier: 1);
      }
      items.refresh();
    }

    catatanTextController.clear();
    Get.back();
  }

  void updateItemCount({
    required int idMenu,
    required int modifier,
    EditType editType = EditType.list,
  }) {
    if (editType == EditType.cart) {
      int itemIndex = cart.indexWhere((item) => item['id_menu'] == idMenu);
      cart[itemIndex]['jumlah'] = cart[itemIndex]['jumlah'] + modifier;

      if (cart[itemIndex]['jumlah'] == 0) {
        deleteCartItem(idMenu);
      }
      cart.refresh();
    } else {
      int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
      items[itemIndex]['jumlah'] = items[itemIndex]['jumlah'] + modifier;

      if (items[itemIndex]['jumlah'] == 0) {
        resetItemProperty(idMenu: idMenu);
      }
      items.refresh();
    }
  }

  void resetItemProperty({required int idMenu}) {
    int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);

    items[itemIndex]['catatan'] = 'Tambahkan Catatan';
    items[itemIndex]['level'] = 0;
    items[itemIndex]['toping'] = 'Tanpa Toping';
    items.refresh();
  }

  ///Cart
  Future<String> addCartItem(Map<String, dynamic> newItem) async {
    try {
      Map<String, dynamic> cartItem = Map.from(newItem);
      var random = Random();
      int randomId = random.nextInt(1000000);
      cartItem['id_menu'] = randomId;

      _cartRepository.addCartItem(cartItem);
      cart.add(cartItem);

      return 'Success';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<bool> deleteCartItem(int idItem) async {
    try {
      _cartRepository.deleteCartItem(idItem);
      cart.removeWhere((item) => item['id_menu'] == idItem);
      cart.refresh();
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      return false;
    }
  }

  Future<bool> getListOfCart() async {
    try {
      final result = _cartRepository.getListOfCart();
      cart.addAll(result['cart']);

      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      return false;
    }
  }

  void getVoucherList() {
    final List<Map<String, dynamic>> promo = ListRepository().promo;
    for (var item in promo) {
      if (item['promo_name'] == 'Voucher') {
        voucher.add(item);
      }
    }
  }

  /// Getter
  List<Map<String, dynamic>> get makananCart => cart
      .where(
        (element) => element['category'] == 'makanan',
      )
      .toList();

  List<Map<String, dynamic>> get minumanCart => cart
      .where(
        (element) => element['category'] == 'minuman',
      )
      .toList();

  num get totalHarga {
    num hargaTotal = 0;
    for (var i = 0; i < cart.length; i++) {
      hargaTotal = hargaTotal + cart[i]['harga'] * cart[i]['jumlah'];
    }
    return hargaTotal;
  }
}
