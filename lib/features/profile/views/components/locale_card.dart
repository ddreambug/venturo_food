import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LocaleCard extends StatelessWidget {
  final bool isSelected;
  final String flag;
  final String language;
  final void Function()? onTap;

  const LocaleCard({
    super.key,
    required this.isSelected,
    required this.flag,
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.r),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(10.r),
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                flag,
                width: 56.r,
                height: 38.r,
                fit: BoxFit.contain,
              ),
              9.horizontalSpaceRadius,
              Text(
                language,
                style: Get.textTheme.labelMedium!.copyWith(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColorDark),
              ),
              ...Conditional.list(
                context: context,
                conditionBuilder: (context) => isSelected,
                widgetBuilder: (context) => [
                  6.horizontalSpaceRadius,
                  Icon(Icons.check, size: 20.r, color: Colors.white),
                ],
                fallbackBuilder: (context) => [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
