import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/model.dart';
import '../service/service.dart';

class ApiController extends GetxController {
  RxInt current = 1.obs;

  RxBool isLoading = false.obs;
  ScrollController? controllers;
  var model = <Datum>[].obs;

  Future<bool> paginationController(
      {RefreshController? controller, bool isRefreshing = false}) async {
    isLoading(true);
    var response = await Service().service(page: current.value);
    if (response != null) {
      for (var element in response.data!) {
        model.add(element);
      }
      current.value++;
      return true;
    } else {
      return false;
    }
  }
}

///
 
