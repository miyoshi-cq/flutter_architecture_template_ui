import 'package:flutter_architecture_template_ui/utility/request_item.dart';
import 'package:flutter_architecture_template_ui/utility/http_method.dart';

class Request<T extends RequestItem, R> {
  final String baseUrl;
  final String path;
  final HttpMethod method;
  final T? body;
  final R Function(dynamic) response;

  Request(
    this.baseUrl,
    this.path,
    this.method,
    this.body,
    this.response,
  );
}
