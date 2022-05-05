import 'dart:convert';
import 'dart:convert' as convert;
import 'package:biddano/models/phones.dart';
import 'package:biddano/utils/env.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  Map<String, String> commonHeaders = {
    'Agent': 'iPhone',
    'App-Version': '1.0.0',
    'Content-Type': 'application/json'
  }; //common header properties for all http requests

  Future httpGetRequestAsync(String serviceUrl,
      {Map<String, dynamic>? headers,
      void Function(bool status, List<dynamic>? responseData)?
          completionHandler}) async {
    var httpHeaders = commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }
    try {
      final response = await http.get(Uri.parse('$base_url$serviceUrl'),
          headers: httpHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        completionHandler!(true, data);
      } else {
        completionHandler!(false, []);
      }
    } catch (e) {
      completionHandler!(false, []);
    }
  }

  void httpPostRequestAsync(String serviceUrl, Map<String, dynamic> postData,
      {Map<String, dynamic>? headers,
      void Function(bool status, List<Map<String, dynamic>>? responseData)?
          completionHandler}) async {
    var httpHeaders = commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    try {
      final response = await http.post(Uri.parse('$base_url$serviceUrl'),
          body: json.encode(postData), headers: httpHeaders);
      if (response.statusCode == 200) {
        final d = response.body;
        //print('WebServiceRequest - $serviceUrl \nResponse - $d');
        completionHandler!(true, json.decode(d));
      } else {
        completionHandler!(false, null);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception - $e');
      }
      completionHandler!(false, null);
    }
  }
}
