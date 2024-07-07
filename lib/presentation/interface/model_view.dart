import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Model", style: Theme.of(context).textTheme.headlineMedium),
            CodeView(code: dartCode, language: CodeLanguage.dart),
          ],
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: dartCode)).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Code copied to clipboard")));
                });
              },
              child: CircleAvatar(
                child: Icon(
                  Icons.copy,
                ),
              )),
        )
      ],
    );
  }
}
