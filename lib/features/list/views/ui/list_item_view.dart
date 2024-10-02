import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';
import 'package:venturo_food/features/list/repositories/list_repository.dart';
import 'package:venturo_food/features/list/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/list/views/components/list_category.dart';
import 'package:venturo_food/features/list/views/components/list_item.dart';
import 'package:venturo_food/features/list/views/components/list_promo.dart';

import '../components/search_app_bar.dart';
import '../components/section_header.dart';

class ListItemView extends StatelessWidget {
  const ListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> promoRepo = ListRepository().promo;
    final listController = ListController.to;

    return SafeArea(
      child: GestureDetector(
        onTap: ListController.to.focusNode.unfocus,
        child: Scaffold(
          backgroundColor: MainColor.white,
          appBar: SearchAppBar(
              onChange: (value) => ListController.to.keyword(value)),
          bottomNavigationBar: Obx(
            () => CustomBottomnavbar(
              currentIndex: listController.currentNavBarIndex.value,
            ),
          ),
          body: NestedScrollView(
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(child: 22.verticalSpace),
                  // list of promo
                  SliverToBoxAdapter(
                    child: SectionHeader(
                      icon: Image.asset(ImageConstant.promoIcon),
                      title: 'Promo Yang Tersedia (${promoRepo.length})',
                    ),
                  ),
                  SliverToBoxAdapter(child: 22.verticalSpace),
                  const ListPromo(),
                  SliverToBoxAdapter(child: 22.verticalSpace),
                  // Row of categories
                  const ListCategory(),
                  SliverToBoxAdapter(child: 10.verticalSpace),
                ];
              },
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // List item Header
                  Obx(() {
                    final currentCategory =
                        ListController.to.selectedCategory.value;
                    return Container(
                      width: 1.sw,
                      height: 35.h,
                      color: Colors.grey[100],
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: SectionHeader(
                        color: MainColor.primary,
                        title: currentCategory == 'semua menu'
                            ? 'Semua Menu'
                            : currentCategory == 'makanan'
                                ? 'Makanan'
                                : 'Minuman',
                        icon: currentCategory == 'semua menu'
                            ? SvgPicture.asset(
                                ImageConstant.listIconSvg,
                                color: MainColor.primary,
                              )
                            : currentCategory == 'makanan'
                                ? SvgPicture.asset(
                                    ImageConstant.makananIconSvg,
                                  )
                                : SvgPicture.asset(
                                    ImageConstant.minumanIconSvg,
                                  ),
                      ),
                    );
                  }),
                  //List Item
                  const ListItem()
                ],
              )),
        ),
      ),
    );
  }
}
