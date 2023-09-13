import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/getx/db_functions/db_functions.dart';
import 'package:studentgetx/getx/form_image.dart';
import 'package:studentgetx/models/student_model.dart';

FormImage imageController = Get.put(FormImage());
final nameController = TextEditingController();
final emailController = TextEditingController();
final ageController = TextEditingController();
final contactController = TextEditingController();
final formKey = GlobalKey<FormState>();

class ScreenAdd extends StatelessWidget {
  const ScreenAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Student'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => nameController.text.isEmpty
                      ? 'Name field is empty'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) => emailController.text.isEmpty
                      ? 'Email field is empty'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: ageController,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age of student',
                    prefixIcon: Icon(Icons.av_timer),
                  ),
                  validator: (value) =>
                      ageController.text.isEmpty ? 'Age field is empty' : null,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: contactController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Contact Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) => contactController.text.isEmpty
                      ? 'Contact field is empty'
                      : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (imageController.imgPath.value != '') {
                              isSccess();
                            } else {
                              notSuccess();
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void notSuccess() {
  Get.snackbar('Image not added!!', 'Please add a image of student');
}

Future<void> isSccess() async {
  final studentObject = StudentModel(
      id: DateTime.now(),
      name: nameController.text,
      email: emailController.text,
      age: int.parse(ageController.text),
      contact: int.parse(contactController.text),
      profile: imageController.imgPath.value);

  await StudentDB().addStudent(studentObject);
  imageController.imgPath.value = '';
  nameController.text = '';
  emailController.text = '';
  ageController.text = '';
  contactController.text = '';
  final studentDB = Get.put(StudentDB());
  studentDB.getAllStudents();
  Get.back();
}
