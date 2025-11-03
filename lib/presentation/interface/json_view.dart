import 'package:flutter/material.dart';

import 'code_view.dart';

class JsonView extends StatelessWidget {
  const JsonView({super.key, required this.jsonCode});

  final String jsonCode;

  @override
  Widget build(BuildContext context) {
    //https://stackoverflow.com/questions/59428776/how-to-format-json-string-in-logcat-when-using-flutter-print-statement
    return CodeView(code: jsonCode, language: CodeLanguage.json);
  }
}
