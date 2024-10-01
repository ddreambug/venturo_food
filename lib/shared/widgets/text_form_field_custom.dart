import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/forgot_password/controllers/forgot_password_controller.dart';
import 'package:venturo_food/features/login/controllers/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    required this.fieldType,
    this.obscureText = false,
  });
  final String fieldType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController.to;

    ///Field Property
    TextEditingController textController = loginController.emailController;

    ///conditional assignment
    if (fieldType == 'emailInput') {
      textController = loginController.emailController;
    } else if (fieldType == 'passwordInput') {
      textController = loginController.passwordController;
    } else if (fieldType == 'forgotEmailInput') {
      textController = ForgotPasswordController.to.emailController;
    }

    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        label: Text(fieldType == 'emailInput' ? 'Alamat Email' : 'Kata Sandi'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle:
            Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18.sp),
        hintText: fieldType == 'emailInput'
            ? 'Lorem.ipsum@gmail.com'
            : '***************',
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: MainColor.primary,
          ),
        ),
        contentPadding: const EdgeInsets.only(bottom: 5),
        isDense: true,
        suffix: fieldType == 'emailInput'
            ? null
            : GestureDetector(
                onTap: () {
                  loginController.changePasswordVisibility();
                },
                child: Iconify(
                  loginController.obscureText.value
                      ? AntDesign.eye_outlined
                      : AntDesign.eye_invisible_outlined,
                  size: 22.w,
                  color: const Color.fromARGB(81, 0, 0, 0),
                ),
              ),
      ),
      validator: (value) {
        /// validasi Jika sebagai input email
        if (fieldType == 'emailInput') {
          if (value == null || value.trim().isEmpty) {
            return 'Isikan Email';
          } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$")
              .hasMatch(value)) {
            return 'Email harus valid!';
          }
        }

        /// validasi Jika sebagai input password
        else if (fieldType == 'passwordInput') {
          if (value == null || value.trim().isEmpty) {
            return 'Isikan Password';
          } else if (value.contains(RegExp(r' '))) {
            return 'Tidak boleh ada Whitespace!';
          }
        }
        return null;
      },
      onSaved: (newValue) {
        if (fieldType == 'emailInput') {
          loginController.emailValue.value = newValue!;
        } else if (fieldType == 'passwordInput') {
          loginController.passwordValue.value = newValue!;
        }
      },
    );
  }
}
