import 'dart:convert';
import 'package:flutter/services.dart';


dynamic jsonDecodeUtf8(List<int> codeUnits,
    {Object? reviver(Object? key, Object? value)?}) =>
    json.decode(utf8.decode(codeUnits), reviver: reviver);