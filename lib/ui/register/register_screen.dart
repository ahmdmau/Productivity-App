import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/helpers/custom_button.dart';
import 'package:productivity_app/helpers/loading.dart';
import 'package:productivity_app/helpers/validators.dart';
import 'package:productivity_app/ui/register/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            "Create New\nAccount",
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
                            "Register",
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
                            controller: controller.nameController,
                            onChanged: (value) {},
                            validator: Validator().name,
                            onSaved: (name) =>
                                controller.nameController.text = name!,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Fullname",
                              hintText: "Fullname",
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            onChanged: (value) {},
                            validator: Validator().email,
                            onSaved: (email) => controller.emailController,
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
                            validator: Validator().password,
                            onChanged: (value) {},
                            onSaved: (password) =>
                                controller.passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Password",
                              hintText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.workController,
                            obscureText: false,
                            onChanged: (value) {},
                            onSaved: (value) => controller.workController,
                            validator: Validator().notEmpty,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Pekerjaan",
                              hintText: "Pekerjaan",
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          CustomButton.primaryButton(
                            onClick: () {
                              controller.validateForm();
                            },
                            text: "Register",
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
                                "Have an Account? ",
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Sign In Here",
                                  style: GoogleFonts.montserrat(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
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
        );
      },
    );
  }
}
