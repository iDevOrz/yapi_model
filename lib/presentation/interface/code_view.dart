import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/dart.dart' show dart;
import 'package:highlight/languages/json.dart' show json;

enum CodeLanguage {
  json,
  dart,
}

extension CodeLanguageMode on CodeLanguage {
  Mode get languageMode {
    switch (this) {
      case CodeLanguage.json:
        return json;
      case CodeLanguage.dart:
        return dart;
    }
  }
}

//样式 https://bertrandbev.github.io/code_field/#/
class CodeView extends StatefulWidget {
  const CodeView({super.key, required this.code, required this.language});

  final String code;

  final CodeLanguage language;

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  CodeController? _codeController;

  @override
  void initState() {
    super.initState();
    // Instantiate the CodeController
    _codeController = CodeController(
      text: widget.code,
      language: widget.language.languageMode,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: const CodeThemeData(styles: atomOneLightTheme),
      child: CodeField(
        controller: _codeController!,
      ),
    );
  }
}
