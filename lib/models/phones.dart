import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<PhoneModel> modelPhoneModelFromJson(String str) =>
    List<PhoneModel>.from(json.decode(str).map((x) => PhoneModel.fromJson(x)));

String modelPhoneModelToJson(List<PhoneModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhoneModel{
  PhoneModel({
    required this.phoneUnit,
    required this.modelList,
  });
  late final String phoneUnit;
  late final List<PhoneModel> modelList;
  // ignore: prefer_typing_uninitialized_variables
  bool isExpanded = false;

  PhoneModel.fromJson(Map<String, dynamic> json) {
    phoneUnit = json['Name'];
    modelList =
        List.from(json['Children']).map((e) => PhoneModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = phoneUnit;
    _data['Children'] = modelList.map((e) => e.toJson()).toList();
    return _data;
  }
}

// class Children {
//   Children({
//     required this.modelName,
//     required this.phoneModel,
//   });
//   late final String modelName;
//   late final List<dynamic> phoneModel;

//   Children.fromJson(Map<String, dynamic> json) {
//     modelName = json['Name'];
//     phoneModel = List.castFrom<dynamic, dynamic>(json['Children']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Name'] = modelName;
//     _data['Children'] = phoneModel;
//     return _data;
//   }
// }
