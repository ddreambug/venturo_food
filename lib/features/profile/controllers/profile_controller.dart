import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../../../configs/localization/localization.dart';
import '../views/components/image_picker_dialog.dart';
import '../views/components/language_bottom_sheet.dart';
import '../views/components/name_bottom_sheet.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final Rx<File?> _imageFile = Rx<File?>(null);
  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerif = false.obs;
  RxString currentLang = Localization.currentLanguage.obs;
  Rx<Map<String, dynamic>> user = Rx<Map<String, dynamic>>({});

  File? get imageFile => _imageFile.value;
  File? ktpFile;

  @override
  void onInit() {
    super.onInit();

    /// Load Device Info
    getDeviceInformation();
  }

  /// Pilih image untuk update photo
  Future<void> pickImage() async {
    /// Buka dialog untuk sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// pengecekan sumber gambar
    if (imageSource == null) return;

    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    /// setelah dipilih, akan terbuka crop gambar
    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: _imageFile.value!.path, uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper'.tr,
          toolbarColor: MainColor.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        )
      ]);

      /// Jika gambar telah dipilih, maka akan dimasukkan ke variabel image file, karena ini masih menggunakan local file
      if (croppedFile != null) {
        _imageFile.value = File(croppedFile.path);
      }
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      ktpFile = File(result.files.single.path!);

      /// Selanjutnya apa yang ingin diinginkan
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

  Future<void> updateUser({
    String? nama,
    DateTime? tglLahir,
    String? telepon,
    String? email,
    String? pin,
  }) async {
    final reqData = <String, String>{};

    if (nama != null) reqData["nama"] = nama;
    if (tglLahir != null) {
      reqData["tgl_lahir"] = DateFormat('yyy-MM-dd').format(tglLahir);
    }

    if (telepon != null) reqData["telepon"] = telepon;
    if (email != null) reqData["email"] = email;
    if (pin != null) reqData["pin"] = pin;

    // update user data
    user.update((val) {
      val?.addAll(reqData);
    });
  }

  Future<void> updateProfileName() async {
    String? nameInput = await Get.bottomSheet(
      NameBottomSheet(nama: user.value['nama'] ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (nameInput != null && nameInput.isNotEmpty) {
      await updateUser(nama: nameInput);
    }
  }

  Future<void> updateBirthDate() async {
    DateTime? birthDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(DateTime.now().year - 21),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (birthDate != null) {
      await updateUser(tglLahir: birthDate);
    }
  }
}
