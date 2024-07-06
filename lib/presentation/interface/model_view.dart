import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter/material.dart';
import 'package:yapi_model/presentation/interface/code_view.dart';

class ModelView extends StatelessWidget {
  const ModelView({super.key, required this.models});

  final List<Class> models;

  @override
  Widget build(BuildContext context) {
    final emitter = DartEmitter();
    final modelsCodeList = models.map(
      (model) => model.accept(emitter).toString(),
    );
    final dartCode = DartFormatter().format(modelsCodeList.join("\n"));
    return CodeView(code: dartCode, language: CodeLanguage.dart);
  }
}
