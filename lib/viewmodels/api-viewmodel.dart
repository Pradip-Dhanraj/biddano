import 'package:biddano/models/phones.dart';
import 'package:biddano/viewmodels/baseViewModels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class APIViewModel extends BaseViewModel {
  APIViewModel() : super();

  late List<PhoneModel> _phonelist = [];
  List<PhoneModel> get phonelist => _phonelist;
  set phonelist(List<PhoneModel> value) {
    _phonelist = value;
    notifyListeners();
  }

  bool updatePhoneList(PhoneModel model, String text) {
    model.modelList.add(
      PhoneModel(
        modelList: [],
        phoneUnit: text,
      ),
    );
    return model.modelList.any((element) => element.phoneUnit.contains(text));
  }

  Future fetchApiData(context) async {
    try {
      if (isConnected) {
        // ignore: dead_code
        if (kDebugMode && false) {
          // await Future.delayed(
          //   const Duration(
          //     milliseconds: 3000,
          //   ),
          // );
          // List<dynamic>? dataMapping = jsonDecode(
          //     "[\r\n    {\r\n        \"Name\": \"Apple\",\r\n        \"Children\": [\r\n            {\r\n                \"Name\": \"iPhone 6\",\r\n                \"Children\": []\r\n            },\r\n            {\r\n                \"Name\": \"iPhone 5\",\r\n                \"Children\": []\r\n            }\r\n        ]\r\n    },\r\n    {\r\n        \"Name\": \"Android\",\r\n        \"Children\": [\r\n            {\r\n                \"Name\": \"Goole\",\r\n                \"Children\": [\r\n                    {\r\n                        \"Name\": \"Pixel 2\",\r\n                        \"Children\": []\r\n                    },\r\n                    {\r\n                        \"Name\": \"Pixel 3\",\r\n                        \"Children\": []\r\n                    }\r\n                ]\r\n            },\r\n            {\r\n                \"Name\": \"1 Plus\",\r\n                \"Children\": [\r\n                    {\r\n                        \"Name\": \"1 Plus 6\",\r\n                        \"Children\": []\r\n                    },\r\n                    {\r\n                        \"Name\": \"1 Plus 7\",\r\n                        \"Children\": []\r\n                    }\r\n                ]\r\n            }\r\n        ]\r\n    }\r\n]");
          // phonelist = dataMapping!.map((e) => PhoneModel.fromJson(e)).toList();
        } else if (phonelist.isEmpty) {
          await http.httpGetRequestAsync('/ia/phones.json', completionHandler: (
            bool bool,
            List<dynamic>? dataMapping,
          ) {
            phonelist =
                dataMapping!.map((e) => PhoneModel.fromJson(e)).toList();
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
