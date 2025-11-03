import 'package:flutter/material.dart';

class InterfaceSplitView extends StatelessWidget {
  const InterfaceSplitView({
    super.key,
    required this.breakWidth,
    required this.infoContent,
    required this.mockJsonContent,
    required this.modelContent,
  });

  final Widget infoContent;

  final Widget mockJsonContent;

  final Widget modelContent;

  final double breakWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ct, constrain) {
        if (constrain.maxWidth > breakWidth) {
          return _buildSplitView(context);
        } else {
          return _buildSingleView(context);
        }
      },
    );
  }

  Widget _buildSplitView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 500, child: SingleChildScrollView(child: infoContent)),
        const SizedBox(width: 10),
        Expanded(child: SingleChildScrollView(child: mockJsonContent)),
        const SizedBox(width: 10),
        Expanded(child: SingleChildScrollView(child: modelContent)),
      ],
    );
  }

  Widget _buildSingleView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [infoContent, mockJsonContent, modelContent],
      ),
    );
  }
}
