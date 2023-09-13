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
  const ScreenAdd({
    super.key,
    required this.isEdit,
    required this.index,
  });
  final bool isEdit;
  final int index;
  @override
  Widget build(BuildContext context) {
    isEdit ? isUpdate(index) : reset();

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Sutdent Details' : 'Add Student'),
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
                              isEdit ? updateData(index) : submitData();
                            } else {
                              notSuccess();
                            }
                          }
                        },
                        child: const Text('Submit'),
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

Future<void> isUpdate(int index) async {
  final studentDB = Get.put(StudentDB());
  await studentDB.getAllStudents();
  imageController.imgPath.value = studentDB.students[index].profile;
  nameController.text = studentDB.students[index].name;
  emailController.text = studentDB.students[index].email;
  ageController.text = studentDB.students[index].age.toString();
  contactController.text = studentDB.students[index].contact.toString();
}

void notSuccess() {
  Get.snackbar('Image not added!!', 'Please add a image of student');
}

Future<void> submitData() async {
  final studentObject = StudentModel(
      id: DateTime.now(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      age: int.parse(ageController.text.trim()),
      contact: int.parse(contactController.text.trim()),
      profile: imageController.imgPath.value);

  await StudentDB().addStudent(studentObject);
  reset();
  final studentDB = Get.put(StudentDB());
  studentDB.getAllStudents();
  Get.back();
}

Future<void> updateData(int index) async {
  final studentObject = StudentModel(
      id: DateTime.now(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      age: int.parse(ageController.text.trim()),
      contact: int.parse(contactController.text.trim()),
      profile: imageController.imgPath.value);
  await StudentDB().editStudent(index, studentObject);
  final studentDB = Get.put(StudentDB());
  studentDB.getAllStudents();
  Get.back();
}

reset() {
  imageController.imgPath.value = '';
  nameController.text = '';
  emailController.text = '';
  ageController.text = '';
  contactController.text = '';
}
