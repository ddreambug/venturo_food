import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/features/main_menu/repositories/list_repository.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/search_app_bar.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();

  /// Bottom Navbar property
  final RxInt currentNavBarIndex = 0.obs;

  /// Appbar property
  final FocusNode focusNode = FocusNode();
  var isFocused = false.obs;
  RxString appbarType = 'main'.obs;
  Widget appBar = SearchAppBar(
    onChange: (value) => ListController.to.keyword(value),
  );

  /// List property
  late final ListRepository repository;
  final RxInt page = 0.obs;
  final RxList<Map<String, dynamic>> promo = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> allItems = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> selectedItems =
      <Map<String, dynamic>>[].obs;
  final RxBool canLoadMore = true.obs;
  final RxString selectedCategory = 'all menu'.obs;
  final RxString keyword = ''.obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final List<String> categories = [
    'All Menu',
    'Food',
    'Beverages',
    'Snack',
  ];

  @override
  void onInit() async {
    super.onInit();

    repository = ListRepository();
    await repository.fetchApiData();
    await getListOfData();

    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });

    CheckoutController.to.catatanTextController.addListener(
      () {
        CheckoutController.to.catatanLength.value =
            CheckoutController.to.catatanTextController.text.length;
      },
    );
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  void onRefresh() async {
    page(0);
    canLoadMore(true);
    final result = await getListOfData();

    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

  List<Map<String, dynamic>> get filteredList => items
      .where(
        (element) =>
            element['name']
                .toString()
                .toLowerCase()
                .contains(keyword.value.toLowerCase()) &&
            (selectedCategory.value == 'all menu' ||
                element['category'].toString().tr == selectedCategory.value),
      )
      .toList();

  List<Map<String, dynamic>> get makananList => items
      .where(
        (element) =>
            element['name']
                .toString()
                .toLowerCase()
                .contains(keyword.value.toLowerCase()) &&
            element['category'] == 'makanan',
      )
      .toList();

  List<Map<String, dynamic>> get minumanList => items
      .where(
        (element) =>
            element['name']
                .toString()
                .toLowerCase()
                .contains(keyword.value.toLowerCase()) &&
            element['category'] == 'minuman',
      )
      .toList();

  List<Map<String, dynamic>> get snackList => items
      .where(
        (element) =>
            element['name']
                .toString()
                .toLowerCase()
                .contains(keyword.value.toLowerCase()) &&
            element['category'] == 'snack',
      )
      .toList();

  Future<bool> getListOfData() async {
    try {
      allItems.value = repository.data;
      final result = repository.getListOfData(
        offset: page.value,
      );

      if (result['previous'] == null) {
        items.clear();
      }

      if (result['next'] == null) {
        canLoadMore(false);
        refreshController.loadNoData();
        return false;
      }

      items.addAll(result['data']);

      page.value += 5;
      refreshController.loadComplete();

      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      refreshController.loadFailed();
      return false;
    }
  }

  Future<void> deleteItem(Map<String, dynamic> item) async {
    try {
      repository.deleteItem(item['id_menu']);

      items.remove(item);

      selectedItems.remove(item);
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

  void emptyListItem() async {
    page.value = 0;
    items.clear();
    canLoadMore(true);

    await getListOfData();
    update();
  }
}
