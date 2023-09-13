import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/core/constants.dart';
import 'package:studentgetx/getx/db_functions/db_functions.dart';
import 'package:studentgetx/screens/form/form_screen.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final studentDB = Get.put(StudentDB());
    studentDB.getAllStudents();  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Card(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      FileImage(File(studentDB.students[index].profile)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'NAME : ${studentDB.students[index].name.toUpperCase()}',
                  style: profileTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'EMAIL : ${studentDB.students[index].email.toLowerCase()} ',
                  style: profileTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'AGE : ${studentDB.students[index].age.toString()}',
                  style: profileTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'CONTACT : ${studentDB.students[index].contact.toString()}',
                  style: profileTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () => Get.to( ScreenAdd(isEdit: true,index: index,)),  
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit')),
              ],
            ),
          ),
        ),
      ),),
    );
  }
}
