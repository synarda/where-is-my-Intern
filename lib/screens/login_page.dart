import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/controllers/login_controller.dart';
import 'package:whereismyintern/screens/register_page.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/helper.dart';
import 'package:whereismyintern/widgets/textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colorss.backgroundColor,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: Helper.mainLinearGradient),
          child: SingleChildScrollView(
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/png/splash_logo.png", fit: BoxFit.cover, height: 200.h, width: 200.w),
              ),
              SizedBox(
                height: 80.h,
              ),
              TextfieldWidget(
                  labelColor: Colorss.borderColor,
                  borderColor: Colorss.borderColor,
                  type: TextInputType.emailAddress,
                  radius: 10,
                  controller: controller.emailController,
                  icon: const Icon(
                    Icons.person,
                    color: Colorss.borderColor,
                  ),
                  label: "Email",
                  limit: 50,
                  fillColor: Colors.white.withOpacity(0.5),
                  obscure: false),
              SizedBox(
                height: 20.h,
              ),
              TextfieldWidget(
                  type: TextInputType.number,
                  labelColor: Colorss.borderColor,
                  borderColor: Colorss.borderColor,
                  radius: 10,
                  controller: controller.passwordController,
                  icon: const Icon(
                    Icons.password,
                    color: Colorss.borderColor,
                  ),
                  label: "Password",
                  limit: 50,
                  fillColor: Colors.white.withOpacity(0.5),
                  obscure: true),
              SizedBox(
                height: 60.h,
              ),
              GestureDetector(
                onTap: controller.sigIn,
                child: Container(
                    height: 60.h,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colorss.themeNeon1),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: Styles.smallTitleStyle.copyWith(color: Colors.white),
                      ),
                    )),
              ),
              Column(
                children: [
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Get.to(const RegisterPage()),
                    child: Container(
                      height: 50.h,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Don't have an account ?",
                        style: Styles.smallTextStyle.copyWith(
                            fontSize: 12.sp, decoration: TextDecoration.underline, color: Colorss.forebackground),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
