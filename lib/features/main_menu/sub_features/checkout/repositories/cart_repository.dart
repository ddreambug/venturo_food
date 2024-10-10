class CartRepository {
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
}
