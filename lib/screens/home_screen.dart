import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../getx/routes.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Center(child: Text('data')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RouteClass.getAddScreenRoute());
          },
          child: const Icon(
            Icons.add,

          ),
          ),
    );
  }
}
