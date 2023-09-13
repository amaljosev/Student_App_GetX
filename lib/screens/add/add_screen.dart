import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/getx/form_image.dart';

final nameController = TextEditingController();
final emailController = TextEditingController();
final ageController = TextEditingController();
final contactController = TextEditingController();
final formKey = GlobalKey<FormState>();

class ScreenAdd extends StatelessWidget {
  const ScreenAdd({super.key});

  @override
  Widget build(BuildContext context) {
    FormImage imageController = Get.put(FormImage());
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              ClipOval(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(imageController.assetAvatar.value),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
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
                validator: (value) =>
                    nameController.text.isEmpty ? 'Name field is empty' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Age of student',
                  prefixIcon: Icon(Icons.av_timer),
                ),
                validator: (value) =>
                    ageController.text.isEmpty ? 'Age field is empty' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contact Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) => contactController.text.isEmpty
                    ? 'Contact field is empty'
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              isSccess();
                            }
                          },
                          child: const Text('Submit'))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void isSccess() {
  print('Success');
}
