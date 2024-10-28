import 'package:flutter/material.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/menu_detail_list.dart';
import 'package:venturo_food/utils/enums/enum.dart';

class BuildMenuProperties extends StatelessWidget {
  const BuildMenuProperties({
    super.key,
    required this.menuItem,
    required this.isCart,
  });

  final Map<String, dynamic> menuItem;
  final bool isCart;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (menuItem['category'] == 'minuman') ...[
          MenuDetailList(
            menuItem: menuItem,
            detailType: DetailType.harga,
            isCart: isCart,
          ),
          const Divider(),
          MenuDetailList(
            menuItem: menuItem,
            detailType: DetailType.level,
            isCart: isCart,
          ),
          const Divider(),
          MenuDetailList(
            menuItem: menuItem,
            detailType: DetailType.catatan,
            isCart: isCart,
          )
        ] else ...[
          MenuDetailList(
            menuItem: menuItem,
            detailType: DetailType.harga,
            isCart: isCart,
          ),
          const Divider(),
          MenuDetailList(
            menuItem: menuItem,
            detailType: DetailType.level,
            isCart: isCart,
          ),
          const Divider(),
          MenuDetailList(
            menuItem: menuItem,
            detailType: DetailType.toping,
            isCart: isCart,
          ),
          const Divider(),
          MenuDetailList(
            menuItem: menuItem,
            detailType: DetailType.catatan,
            isCart: isCart,
          )
        ],
        const Divider(),
      ],
    );
  }
}
