import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/core.dart';
import 'package:productivity_app/helpers/custom_button.dart';
import 'package:productivity_app/helpers/loading.dart';
import 'package:productivity_app/helpers/validators.dart';
import 'package:productivity_app/ui/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SvgPicture.asset(
                              "assets/icon/ic_construction.svg",
                              height: 200,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            "Welcome back,\nEngineer!",
                            style: GoogleFonts.montserrat(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryTextColor,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Login",
                            style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryTextColor,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            onSaved: (value) => controller.emailController,
                            validator: Validator().email,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Email Address",
                              hintText: "Email Address",
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.passwordController,
                            obscureText: true,
                            onSaved: (value) => controller.passwordController,
                            validator: Validator().password,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Password",
                              hintText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          CustomButton.primaryButton(
                            onClick: () {
                              controller.validateForm();
                            },
                            text: "Login",
                            textColor: kAccentTextColor,
                            backgroundColor: kPrimaryColor,
                            borderRadius: 10.0,
                            height: 52.0,
                            fontSize: 16.0,
                            borderSideColor: kPrimaryColor,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Start fresh now? ",
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.REGISTER);
                                },
                                child: Text(
                                  "Register Now",
                                  style: GoogleFonts.montserrat(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                controller.isLoading ? LoadingIndicator() : SizedBox(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
