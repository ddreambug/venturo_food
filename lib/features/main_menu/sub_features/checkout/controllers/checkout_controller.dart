import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/repositories/cart_repository.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/fingerprint_dialog.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/order_success_dialog.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/pin_dialog.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_bottom_sheet.dart';
import 'package:local_auth/local_auth.dart';
import 'package:venturo_food/utils/services/firebase_messaging_service.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find<CheckoutController>();
  final CartRepository _cartRepository = CartRepository();
  final TextEditingController catatanTextController = TextEditingController();
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
  final RxList<Map<String, dynamic>> voucher = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> discounts = <Map<String, dynamic>>[].obs;

  final RxNum finalHarga = RxNum(0);
  final RxDouble discountValue = 20.0.obs;
  final RxMap<String, int> voucherValue = <String, int>{}.obs;
  RxInt catatanLength = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await getListOfCart();
  }

  void showMenuProperty(
    Map<String, dynamic> menuItem,
    DetailType detailType,
    EditType editType,
  ) {
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
      changeFinalHarga();
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
      changeFinalHarga();
      return 'Success';
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      return 'error $exception';
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

  Future<bool> emptyCartItem() async {
    try {
      _cartRepository.emptyCartItem();
      cart.removeRange(0, cart.length);
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
    final List<Map<String, dynamic>> promo = ListController.to.promo;
    for (var item in promo) {
      if (item['promo_name'] == 'voucher') {
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
  List<Map<String, dynamic>> get snackCart => cart
      .where(
        (element) => element['category'] == 'snack',
      )
      .toList();

  num get totalHarga {
    num hargaTotal = 0;
    for (var i = 0; i < cart.length; i++) {
      hargaTotal = hargaTotal + cart[i]['harga'] * cart[i]['jumlah'];
    }

    return hargaTotal;
  }

  void changeFinalHarga() {
    final RxDouble discount = (discountValue / 100).obs;

    if (voucherValue.isNotEmpty) {
      if (totalHarga - voucherValue.values.first < 0) {
        finalHarga.value = 0;
      } else {
        finalHarga.value = totalHarga - voucherValue.values.first;
      }
    } else {
      finalHarga.value = totalHarga - (totalHarga * discount.value);
    }
  }

  void changeVoucherValue(int id, String desc, int newValue) {
    if (voucherValue.containsKey(desc)) {
      voucherValue.remove(desc);
      changeFinalHarga();
    } else {
      voucherValue.value = {desc: newValue};
      changeFinalHarga();
    }
  }

  void changeDiscountValue(double newValue) {
    discountValue.value = newValue;
    discountValue.refresh();
    changeFinalHarga();
  }

  Future<void> verify() async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();
      final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      final bool isBiometricSupported = await localAuth.isDeviceSupported();

      if (canCheckBiometrics && isBiometricSupported) {
        final String? authType = await showFingerprintDialog();

        if (authType == 'fingerprint') {
          final bool authenticated = await localAuth.authenticate(
            localizedReason: 'Please authenticate to confirm order'.tr,
            options: const AuthenticationOptions(biometricOnly: true),
          );
          if (authenticated) {
            showOrderSuccessDialog();
          }
        } else if (authType == 'pin') {
          await showPinDialog();
        }
      } else {
        await showPinDialog();
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

  Future<String?> showFingerprintDialog() async {
    // ensure all modal is closed before show fingerprint dialog
    Get.until((route) => Get.currentRoute == '/detail-pesanan');
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );

    return result;
  }

  Future<void> showPinDialog() async {
    Get.until((route) => Get.currentRoute == '/detail-pesanan');
    const userPin = '123456';
    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const PinDialog(pin: userPin),
    );

    if (authenticated == true) {
      showOrderSuccessDialog();
    } else if (authenticated != null) {
      Get.until((route) => Get.currentRoute == '/detail-pesanan');
      Get.showSnackbar(
        const GetSnackBar(
          snackPosition: SnackPosition.TOP,
          title: 'Error',
          message: 'PIN already wrong 3 times. Please try again later.',
          icon: Iconify(
            MaterialSymbols.warning_outline,
            color: MainColor.danger,
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> showOrderSuccessDialog() async {
    Get.until((route) => Get.currentRoute == '/detail-pesanan');
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
      barrierDismissible: false,
    );
  }

  void saveOrder() async {
    var repository = CartRepository();
    int? index;

    List<Map<String, dynamic>> newOrders =
        cart.map((item) => Map<String, dynamic>.from(item)).toList();

    final RxMap<String, int> newVoucher = RxMap<String, int>.from(
      voucherValue,
    );

    final List<Map<String, dynamic>> menu = transformedCart();
    final num potongan = totalHarga - finalHarga.value;

    if (newVoucher.isNotEmpty) {
      index = voucher.indexWhere(
        (voucherItem) =>
            voucherItem['promo_description'] ==
            newVoucher.keys.first.toString(),
      );
    }

    //POST ke api
    await repository.postOrder(
      potongan,
      finalHarga.value,
      index == null ? 1 : voucher[index]['id_promo'] as num,
      menu,
    );

    final saveOrder = await OrderController.to.addOrder(
      newOrders,
      newVoucher,
      finalHarga.value,
    );

    if (saveOrder) {
      emptyCartItem();
      voucherValue.clear();
      FirebaseMessagingService.showNotification(
        title: 'Success'.tr,
        body: 'Order Created Succesfully'.tr,
      );
    }
  }

  List<Map<String, dynamic>> transformedCart() {
    final masterData = ListController.to.allItems;

    return cart.map((cartItem) {
      var matchingMasterItem = masterData.firstWhere(
        (masterItem) => masterItem["name"] == cartItem["name"],
      );

      return {
        "id_menu": matchingMasterItem["id_menu"],
        "harga": cartItem["harga"],
        "level": cartItem["level"] == 0 ? 1 : cartItem["level"],
        "topping": cartItem["toping"] == "Tanpa Toping" ? [] : [1],
        "jumlah": cartItem["jumlah"],
        "catatan": cartItem["catatan"],
      };
    }).toList();
  }

  int getItemCount() {
    int count = 0;

    if (minumanCart.isNotEmpty) {
      count += minumanCart.length + 1;
    }

    if (makananCart.isNotEmpty) {
      count += makananCart.length + 1;
    }

    if (snackCart.isNotEmpty) {
      count += snackCart.length + 1;
    }

    return count;
  }
}
