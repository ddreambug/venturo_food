import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

import '../../../../configs/localization/localization.dart';
import '../views/components/image_picker_dialog.dart';
import '../views/components/language_bottom_sheet.dart';
import '../views/components/custom_bottom_sheet.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final Rx<File?> _imageFile = Rx<File?>(null);
  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerif = false.obs;
  RxString currentLang = Localization.currentLanguage.obs;
  Rx<Map<String, dynamic>> user = Rx<Map<String, dynamic>>({
    'nama': '-',
    'tanggalLahir': '-',
    'nomorTelepon': '-',
    'alamatEmail': '-',
    'pin': '-',
    'foto': '-',
  });

  File? get imageFile => _imageFile.value;
  File? ktpFile;

  @override
  void onInit() {
    super.onInit();

    loadUser();
    getDeviceInformation();
  }

  void loadUser() async {
    var box = Hive.box('venturo');

    user.value = {
      'nama': box.get('nama', defaultValue: ''),
      'tanggalLahir': box.get('tanggalLahir', defaultValue: ''),
      'nomorTelepon': box.get('nomorTelepon', defaultValue: ''),
      'alamatEmail': box.get('alamatEmail', defaultValue: ''),
      'pin': box.get('pin', defaultValue: ''),
      'foto': box.get('foto', defaultValue: ''),
      'token': box.get('token', defaultValue: ''),
    };
  }

  Future<void> pickImage() async {
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );
    if (imageSource == null) return;

    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile.value!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper'.tr,
            toolbarColor: MainColor.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          )
        ],
      );

      if (croppedFile != null) {
        _imageFile.value = File(croppedFile.path);
      }
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      ktpFile = File(result.files.single.path!);

      isVerif.value = true;
    }
  }

  Future getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  Future<void> updateLanguage() async {
    String? language = await Get.bottomSheet(
      const LanguageBottomSheet(),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (language != null) {
      Localization.changeLocale(language);
      currentLang(language);
    }
  }

  Future<void> updateUser(String title) async {
    var value = user.value['nama'];
    var key = '';
    if (title == 'Name'.tr) {
      value = user.value['nama'];
      key = 'nama';
    } else if (title == 'Phone number'.tr) {
      value = user.value['nomorTelepon'];
      key = 'nomorTelepon';
    } else if (title == 'Email'.tr) {
      value = user.value['alamatEmail'];
      key = 'alamatEmail';
    } else {
      value = user.value['pin'];
      key = 'pin';
    }

    String? nameInput = await Get.bottomSheet(
      CustomBottomSheet(
        value: value,
        title: title,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (nameInput != null && nameInput.isNotEmpty) {
      user.value = {
        ...user.value,
        key: nameInput,
      };
    }
  }

  Future<void> updateBirthDate(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Container(
            height: 300.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SfDateRangePicker(
                showNavigationArrow: true,
                maxDate: DateTime.now(),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: GoogleTextStyle.w400.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                backgroundColor: Colors.white,
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  var value = dateRangePickerSelectionChangedArgs.value;

                  if (value != null) {
                    user.value = {
                      ...user.value,
                      'tanggalLahir': DateFormat('dd/MM/yyy').format(value),
                    };
                  }
                  Get.back();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void privacyPolicyWebView() {
   Get.toNamed(MainRoute.privacyPolicy);
 }

}
