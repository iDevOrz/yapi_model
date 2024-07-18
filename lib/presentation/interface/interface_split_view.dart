import 'package:flutter/material.dart';

class InterfaceSplitView extends StatelessWidget {
  const InterfaceSplitView(
      {super.key,
      required this.breakWidth,
      required this.infoContent,
      required this.mockJsonContent,
      required this.modelContent});

  final Widget infoContent;

  final Widget mockJsonContent;

  final Widget modelContent;

  final double breakWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ct, constrain) {
        if (constrain.maxWidth > breakWidth) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  width: 500, child: SingleChildScrollView(child: infoContent)),
              const SizedBox(width: 10),
              Expanded(
                  child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: mockJsonContent,
                ),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: modelContent,
                ),
              )),
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [infoContent, mockJsonContent, modelContent],
            ),
          );
        }
      },
    );
  }
}
