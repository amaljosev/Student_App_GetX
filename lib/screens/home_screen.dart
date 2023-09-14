import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/getx/db_functions/db_functions.dart';
import 'package:studentgetx/screens/form/form_screen.dart';
import 'package:studentgetx/screens/profile/profile_screen.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final studentDB = Get.put(StudentDB());
    studentDB.getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.search,
              )),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: studentDB.students.length,
          itemBuilder: (context, index) {
            final student = studentDB.students[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(File(student.profile)),
              ),
              title: Text(student.name),
              subtitle: Text('Age: ${student.age.toString()}'),
              onTap: () {
                Get.to(ScreenProfile(index: index));
              },
              trailing: IconButton(
                  onPressed: () => alertDialog(index, studentDB),
                  icon: const Icon(Icons.delete)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ScreenForm(
            isEdit: false,
            index: 0,
          ));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

void alertDialog(int index, StudentDB studentDB) {
  Get.defaultDialog(
    title: 'Delete Student!!',
    middleText: 'Are you sure you want to delete this student?',
    textConfirm: 'Delete',
    textCancel: 'Cancel',
    onConfirm: () {
      StudentDB().deleteStudent(index);
      studentDB.getAllStudents();
      Get.back();
    },
    onCancel: () {
      Get.back();
    },
  );
}
