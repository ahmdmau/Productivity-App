import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/helpers/app_bar_custom.dart';
import 'package:productivity_app/helpers/custom_button.dart';
import 'package:productivity_app/helpers/validators.dart';
import 'package:productivity_app/ui/form/form_result/form_result_controller.dart';

class FormResultPage extends GetView<FormResultController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormResultController>(builder: (controller) {
      return Scaffold(
        appBar: AppBarCustom(title: "Tambah Pekerjaan"),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: controller.workFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      validator: Validator().notEmpty,
                      controller: controller.workProductivityController,
                      onChanged: (value) {},
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixText: controller.unit + "/orang-jam",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Produktivitas",
                        hintText: "Produktivitas",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Effective",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: controller.validateWorker,
                      controller: controller.directWorkController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Pekerjaan Langsung",
                        hintText: "Pekerjaan Langsung",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Contributory",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: controller.validateWorker,
                      controller: controller.prepareMaterialController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Mempersiapkan Material",
                        hintText: "Mempersiapkan Material",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "InEffective",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: controller.validateWorker,
                      controller: controller.unemployedController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Menganggur",
                        hintText: "Menganggur",
                      ),
                    ),
                    SizedBox(height: 32),
                    CustomButton.primaryButton(
                      onClick: () {
                        controller.validateForm();
                      },
                      text: "Simpan",
                      textColor: kAccentTextColor,
                      backgroundColor: kPrimaryColor,
                      borderRadius: 10.0,
                      height: 52.0,
                      fontSize: 16.0,
                      borderSideColor: kPrimaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
