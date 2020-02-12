import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as Http;

class NetworkHelper {
  const NetworkHelper(this.url);

  final String url;

  Future getData() async {
    Http.Response response = await Http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
