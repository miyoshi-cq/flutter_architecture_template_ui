import 'package:flutter_architecture_template_ui/utility/http_method.dart';
import 'package:flutter_architecture_template_ui/utility/request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static Future<Response> request<Response>(Request request) async {
    final url = Uri.https(request.baseUrl, request.path, request.query);

    switch (request.method) {
      case HttpMethod.GET:
        final response = await http.get(url);

        final body = json.decode(response.body);

        return request.response(body);

      case HttpMethod.POST:
        String body = json.encode(request.body!.toJson());

        final response = await http.post(url, body: body);

        final result = json.decode(response.body);

        return request.response(result);
    }
  }
}
