import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/repositories/list_repository.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/repositories/cart_repository.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/fingerprint_dialog.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/order_success_dialog.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/pin_dialog.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_bottom_sheet.dart';
import 'package:local_auth/local_auth.dart';

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
  final RxNum finalHarga = RxNum(0);
  final RxDouble discount = (20 / 100).obs;
  final RxMap<String, int> voucherValue = <String, int>{}.obs;

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
    //

    return hargaTotal;
  }

  void changeFinalHarga() {
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

  void changeVoucherValue(String desc, int newValue) {
    if (voucherValue.containsKey(desc)) {
      voucherValue.remove(desc);
      changeFinalHarga();
    } else {
      voucherValue.value = {desc: newValue};
      changeFinalHarga();
    }
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
    } catch (e) {
      // Handle the error gracefully and use PIN authentication
      print('Biometric authentication not supported: $e');
      await showPinDialog();
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
    // ensure all modal is closed before show pin dialog
    Get.until((route) => Get.currentRoute == '/detail-pesanan');

    const userPin = '123456';

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const PinDialog(pin: userPin),
    );

    if (authenticated == true) {
      // if succeed, order cart
      showOrderSuccessDialog();
    } else if (authenticated != null) {
      // if failed 3 times, show order failed dialog
      Get.until((route) => Get.currentRoute == '/detail-pesanan');
      Get.showSnackbar(
        const GetSnackBar(
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
    );

    Get.back();
  }
}
