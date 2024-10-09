import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/constants/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_bottom_sheet.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find<CheckoutController>();

  final TextEditingController catatanTextController = TextEditingController();
  RxInt catatanLength = 0.obs;
  final RxList<Map<String, dynamic>> items = ListController.to.items;

  void showMenuProperty(Map<String, dynamic> menuItem, DetailType detailType) {
    Get.bottomSheet(
      barrierColor: const Color.fromARGB(40, 55, 55, 55),
      CustomBottomSheet(menuItem: menuItem, detailType: detailType),
    );
  }

  void updateLevel({required int idMenu, required int newLevel}) {
    int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
    items[itemIndex]['level'] = newLevel;

    if (items[itemIndex]['jumlah'] == 0) {
      updateItemCount(idMenu: idMenu, modifier: 1);
    }

    items.refresh();
  }

  void updateToping({required int idMenu, required String newToping}) {
    int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
    items[itemIndex]['toping'] = newToping;

    if (items[itemIndex]['jumlah'] == 0) {
      updateItemCount(idMenu: idMenu, modifier: 1);
    }

    items.refresh();
  }

  void updateCatatan({required int idMenu}) {
    int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
    items[itemIndex]['catatan'] = catatanTextController.text;

    if (items[itemIndex]['jumlah'] == 0) {
      updateItemCount(idMenu: idMenu, modifier: 1);
    }

    items.refresh();
    catatanTextController.clear();
    Get.back();
  }

  void updateItemCount({required int idMenu, required int modifier}) {
    int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
    items[itemIndex]['jumlah'] = items[itemIndex]['jumlah'] + modifier;

    if (items[itemIndex]['jumlah'] == 0) {
      resetItemProperty(idMenu: idMenu);
    }

    items.refresh();
  }

  void resetItemProperty({required int idMenu}) {
    int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);

    items[itemIndex]['catatan'] = 'Tambahkan Catatan';
    items[itemIndex]['level'] = 0;
    items[itemIndex]['toping'] = 'Tanpa Toping';
    items.refresh();
  }
}
