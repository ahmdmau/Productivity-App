import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/helpers/app_bar_custom.dart';
import 'package:productivity_app/helpers/custom_button.dart';
import 'package:productivity_app/helpers/validators.dart';
import 'package:productivity_app/ui/components/textfield_datepicker.dart';
import 'package:productivity_app/ui/form/form_data_work_controller.dart';

class FormDataWorkPage extends GetView<FormDataWorkController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormDataWorkController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarCustom(
            title: "Tambah Pekerjaan",
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Form(
                  key: controller.workFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      DropdownButton(
                        isExpanded: true,
                        hint: Text("Pilih Jenis Pekerjaan"),
                        value: controller.selectedWorkType,
                        items: controller.workTypeModel.map((value) {
                          return DropdownMenuItem(
                            child: Text(value.type),
                            value: value.type,
                            onTap: () {
                              controller.setSelectedWorkTypeId(value.id);
                              controller.getUnitType();
                            },
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          controller.setSelectedWorkType(value!);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      DropdownButton(
                        isExpanded: true,
                        hint: Text("Pilih Cuaca"),
                        value: controller.selectedWeather,
                        items: controller.weathers.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          controller.setSelectedWeather(value!);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.workNameController,
                        onChanged: (value) {},
                        validator: Validator().notEmpty,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Nama Pekerjaan",
                          hintText: "Nama Pekerjaan",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFieldDatePicker(
                        dateFormat: DateFormat("EEEE, d MMMM yyyy", "id_ID"),
                        labelText: "Tanggal",
                        suffixIcon: Icon(Icons.date_range),
                        lastDate: DateTime.now().add(Duration(days: 366)),
                        firstDate: DateTime(1900),
                        initialDate: DateTime.now(),
                        focusNode: FocusNode(),
                        onDateChanged: (selectedDate) {
                          controller.setSelectedDate(selectedDate);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: Validator().notEmpty,
                        controller: controller.workLocationController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Lokasi Pekerjaan",
                          hintText: "Lokasi Pekerjaan",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.workStartTimeController,
                        onChanged: (value) {},
                        validator: Validator().notEmpty,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Jam Mulai",
                          hintText: "Jam Mulai",
                        ),
                        readOnly: true,
                        onTap: () => _selectStartTime(
                          context,
                          controller.startTime == null
                              ? TimeOfDay.now()
                              : controller.startTime!,
                          (value) {
                            controller.setSelectedStartTime(value, context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.workEndTimeController,
                        onChanged: (value) {},
                        validator: Validator().notEmpty,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Jam Selesai",
                          hintText: "Jam Selesai",
                        ),
                        readOnly: true,
                        onTap: () => _selectStartTime(
                          context,
                          controller.startTime == null
                              ? TimeOfDay.now()
                              : controller.startTime!,
                          (value) {
                            controller.setSelectedEndTime(value, context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: Validator().notEmpty,
                        controller: controller.workDurationController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Durasi",
                          hintText: "Durasi",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: Validator().notEmpty,
                        controller: controller.workerController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Jumlah Pekerja",
                          hintText: "Jumlah Pekerja",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: Validator().notEmpty,
                        controller: controller.workResultController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          suffixText: controller.unit,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Hasil",
                          hintText: "Hasil",
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      CustomButton.primaryButton(
                        onClick: () {
                          controller.validateForm(context);
                        },
                        text: "Lanjut",
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
      },
    );
  }

  Future<Null> _selectStartTime(BuildContext context, TimeOfDay selectedTime,
      ValueChanged<TimeOfDay> onTimeChanged) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      onTimeChanged(pickedTime);
    }
  }
}
