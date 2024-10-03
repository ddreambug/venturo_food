import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/features/list/repositories/list_repository.dart';
import 'package:venturo_food/features/list/views/components/search_app_bar.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();

  /// Bottom Navbar property
  final RxInt currentNavBarIndex = 0.obs;

  /// Appbar property
  final FocusNode focusNode = FocusNode();
  var isFocused = false.obs;
  RxString appbarType = 'main'.obs;
  Widget appBar =
      SearchAppBar(onChange: (value) => ListController.to.keyword(value));

  /// List property
  late final ListRepository repository;
  final RxInt page = 0.obs;
  final RxList<Map<String, dynamic>> promo = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> selectedItems =
      <Map<String, dynamic>>[].obs;
  final RxBool canLoadMore = true.obs;
  final RxString selectedCategory = 'semua menu'.obs;
  final RxString keyword = ''.obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final List<String> categories = [
    'Semua Menu',
    'Makanan',
    'Minuman',
  ];

  /// Menu Property
  RxInt itemCount = RxInt(0);

  @override
  void onInit() async {
    super.onInit();

    repository = ListRepository();
    await getListOfData();

    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
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

  void updateItemCount({required int idMenu, required int modifier}) {
    int itemIndex = items.indexWhere((item) => item['id_menu'] == idMenu);
    items[itemIndex]['jumlah'] = items[itemIndex]['jumlah'] + modifier;
    items.refresh();
  }

  List<Map<String, dynamic>> get filteredList => items
      .where(
        (element) =>
            element['name']
                .toString()
                .toLowerCase()
                .contains(keyword.value.toLowerCase()) &&
            (selectedCategory.value == 'semua menu' ||
                element['category'] == selectedCategory.value),
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

  Future<bool> getListOfData() async {
    try {
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
}
