import 'dart:convert';

import 'package:flutter/material.dart';

import 'code_view.dart';

class JsonView extends StatelessWidget {
  const JsonView({super.key, required this.json});

  final Object json;

  @override
  Widget build(BuildContext context) {
    //https://stackoverflow.com/questions/59428776/how-to-format-json-string-in-logcat-when-using-flutter-print-statement
    return CodeView(
      code: const JsonEncoder.withIndent("  ").convert(json),
      language: CodeLanguage.json,
    );
  }
}
