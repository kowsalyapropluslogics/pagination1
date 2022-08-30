import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pagination/controller/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiController apiController = Get.put(ApiController());
  RefreshController controller = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return SmartRefresher(
            onLoading: () async {
              final result = await apiController.paginationController(
                  controller: controller, isRefreshing: true);
              print(result);
              if (result == true) {
                controller.loadComplete();
              } else {
                controller.loadFailed();
              }
            },
            onRefresh: () async {
              final result = await apiController.paginationController(
                  controller: controller, isRefreshing: true);

              if (result == true) {
                controller.refreshCompleted();
              } else {
                controller.refreshFailed();
              }
            },
            enablePullDown: true,
            enablePullUp: true,
            controller: controller,
            child: ListView.builder(
              itemCount: apiController.model.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                    height: 30,
                    child: Card(child: Text(apiController.model[index].id!)));
              },
            ),
          );
        }));
  }
}
