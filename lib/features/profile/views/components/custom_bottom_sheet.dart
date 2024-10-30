import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatefulWidget {
  final String title;
  final String value;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  State<CustomBottomSheet> createState() => _NameBottomSheetState();
}

class _NameBottomSheetState extends State<CustomBottomSheet> {
  late final TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 17.r,
        vertical: 19.r,
      ),
      child: Wrap(
        children: [
          16.verticalSpacingRadius,
          Text(widget.title, style: Get.textTheme.bodyMedium),
          13.verticalSpacingRadius,
          Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: controller,
                    style: Get.textTheme.bodySmall,
                    decoration: InputDecoration(
                      hintText: widget.title,
                      hintStyle: Get.textTheme.bodySmall,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.w,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.w,
                        ),
                      ),
                    ),
                    maxLength: widget.title == 'Phone number'.tr
                        ? 12
                        : widget.title == 'Change PIN'.tr
                            ? 6
                            : 100,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is required'.tr;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              6.horizontalSpace,
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Get.back(result: controller.text);
                  }
                },
                radius: 20.r,
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
