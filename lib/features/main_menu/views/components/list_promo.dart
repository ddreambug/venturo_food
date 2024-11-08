import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/promo_card.dart';

/// Used in main_menu_view.dart
class ListPromo extends StatelessWidget {
  const ListPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        var promoRepo = ListController.to.promo;
        return SizedBox(
          height: 140.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            itemBuilder: (context, index) {
              final promoItem = promoRepo[index];
              return Hero(
                tag: promoItem,
                child: PromoCard(
                  onTap: () {
                    Get.toNamed(
                      '/detail-promo',
                      arguments: {
                        'promoItem': promoItem,
                      },
                    );
                  },
                  enableShadow: false,
                  promoName: promoItem['promo_name'],
                  promoDesc: promoItem['promo_description'],
                  discountNominal: '${promoItem['promo_property']}',
                  thumbnailUrl: promoItem['promo_thumbnail'],
                ),
              );
            },
            separatorBuilder: (context, index) => 26.horizontalSpace,
            itemCount: promoRepo.length,
          ),
        );
      }),
    );
  }
}
