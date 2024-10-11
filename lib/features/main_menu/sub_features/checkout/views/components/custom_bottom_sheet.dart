import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_choice_chip.dart';

/// Called from checkout_controller.dart
class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.menuItem,
    required this.detailType,
    required this.editType,
  });

  final Map<String, dynamic> menuItem;
  final DetailType detailType;
  final EditType editType;

  @override
  Widget build(BuildContext context) {
    String bottomSheetTitle;

    if (detailType.name == 'catatan') {
      bottomSheetTitle = 'Buat Catatan';
    } else if (detailType.name == 'toping') {
      bottomSheetTitle = 'Pilih Toping';
    } else {
      bottomSheetTitle = 'Pilih Level';
    }

    return Wrap(
      children: [
        Container(
          width: double.infinity.w,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
            color: MainColor.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(68, 24, 24, 24),
                blurRadius: 15,
                spreadRadius: -1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 140.w,
                  right: 140.w,
                ),
                child: Divider(
                  thickness: 4.h,
                  color: const Color.fromARGB(126, 181, 181, 181),
                ),
              ),
              SizedBox(width: 20.w),
              Text(
                bottomSheetTitle,
                textAlign: TextAlign.end,
                style: GoogleTextStyle.w600.copyWith(fontSize: 18.sp),
              ),

              /// Conditional bottom sheet widget
              if (detailType.name == 'catatan') ...{
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        final count = CheckoutController.to.catatanLength.value;
                        return Expanded(
                          child: TextField(
                            controller:
                                CheckoutController.to.catatanTextController,
                            autofocus: true,
                            maxLength: 100,
                            decoration: InputDecoration(
                              isDense: true,
                              counterText: '$count/100',
                              counterStyle: GoogleTextStyle.w400.copyWith(
                                fontSize: 10.sp,
                                color: const Color.fromARGB(255, 134, 133, 133),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MainColor.primary),
                              ),
                            ),
                            style:
                                GoogleTextStyle.w400.copyWith(fontSize: 12.sp),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        CheckoutController.to.updateCatatan(
                            idMenu: menuItem['id_menu'], editType: editType);
                      },
                      child: Iconify(
                        Ic.round_check_circle,
                        size: 26.h,
                        color: MainColor.primary,
                      ),
                    ),
                  ],
                ),
              } else if (detailType.name == 'toping') ...{
                SizedBox(height: 10.h),
                CustomChoiceChip(
                  type: 'toping',
                  menu: menuItem,
                  editType: editType,
                ),
              } else ...{
                SizedBox(height: 10.h),
                CustomChoiceChip(
                  type: 'level',
                  menu: menuItem,
                  editType: editType,
                ),
              }
            ],
          ),
        ),
      ],
    );
  }
}
