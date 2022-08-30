import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pagination/model/model.dart';

class Service {
  Future<Model?> service({page}) async {
    var baseUrl = 'https://jsonplaceholder.typicode.com/posts';
    try {
      var response = await http.get(Uri.parse(
          'https://api.instantwebtools.net/v1/passenger?$page=$page&size=5'));

      log(response.body.toString());
      var jsonresponse = jsonDecode(response.body);
      print(jsonresponse);
      if (response.statusCode == 200) {
        return Model.fromJson(jsonresponse);
      }
    } catch (e) {
      rethrow;
    }
  }
}
