import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/getx/form/student_form.dart';
import 'package:studentgetx/getx/form_image.dart';


FormImage imageController = Get.put(FormImage());
FormFunctions studentFormController = Get.put(FormFunctions());

class ScreenForm extends StatelessWidget {
  const ScreenForm({ 
    super.key,
    required this.isEdit,
    required this.index,
  });
  final bool isEdit;
  final int index;
  @override
  Widget build(BuildContext context) {
    isEdit ? studentFormController.isUpdate(index) : studentFormController.reset();

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Sutdent Details' : 'Add Student'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: studentFormController.formKey, 
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () => imageController.getImage(),
                    child: imageController.imgPath.value == ''
                        ? ClipOval(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      imageController.assetAvatar.value),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )
                        : ClipOval(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(
                                      File(imageController.imgPath.value)),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: studentFormController.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                      studentFormController.nameController.text.isEmpty
                          ? 'Name field is empty'
                          : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: studentFormController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) =>
                      studentFormController.emailController.text.isEmpty
                          ? 'Email field is empty'
                          : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: studentFormController.ageController,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age of student',
                    prefixIcon: Icon(Icons.av_timer),
                  ),
                  validator: (value) =>
                      studentFormController.ageController.text.isEmpty
                          ? 'Age field is empty'
                          : null,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: studentFormController.contactController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Contact Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) =>
                      studentFormController.contactController.text.isEmpty
                          ? 'Contact field is empty'
                          : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (studentFormController.formKey.currentState!
                              .validate()) {
                            if (imageController.imgPath.value != '') {
                              isEdit
                                  ? studentFormController.updateData(index)
                                  : studentFormController.submitData();
                            } else {
                              studentFormController.notSuccess();
                            }
                          }
                        },
                        child: Text(isEdit ? 'Update' : 'Submit'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
