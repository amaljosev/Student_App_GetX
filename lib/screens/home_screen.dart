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
                  onPressed: () {
                    StudentDB().deleteStudent(index);
                    studentDB.getAllStudents();
                  },
                  icon: const Icon(Icons.delete)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ScreenAdd(
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
