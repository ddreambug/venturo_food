import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

/// Used in main_menu_view.dart
class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    this.searchController,
    this.onChange,
  });

  final TextEditingController? searchController;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68.w,
      padding: EdgeInsets.symmetric(
        horizontal: 25.w,
        vertical: 12.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(68, 24, 24, 24),
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Obx(
        () => TextField(
          controller: searchController,
          style: GoogleTextStyle.w500.copyWith(fontSize: 16.sp),
          autofocus: false,
          focusNode: ListController.to.focusNode,
          cursorColor: ListController.to.isFocused.value
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          maxLines: 1,
          onChanged: onChange,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            isDense: true,
            prefixIcon: GestureDetector(
              onTap: () {
                print(ListController.to.filteredList.length);
              },
              child: Icon(
                Icons.search,
                size: 26.h,
              ),
            ),
            prefixIconColor: Theme.of(context).primaryColor,
            hintText: 'Pencarian'.tr,
            hintStyle: GoogleTextStyle.w500.copyWith(
              fontSize: 16.sp,
              color: MainColor.grey,
            ),
            contentPadding: EdgeInsets.only(top: 2.w),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
