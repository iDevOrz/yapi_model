import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/presentation/home_controller.dart';

class ProjectAddBottomSheet extends StatefulWidget {
  const ProjectAddBottomSheet({super.key});

  @override
  State<ProjectAddBottomSheet> createState() => _ProjectAddBottomSheetState();
}

class _ProjectAddBottomSheetState extends State<ProjectAddBottomSheet> {
  final _baseUrlController = TextEditingController();
  final _tokenController = TextEditingController();

  @override
  void initState() {
    _baseUrlController.text = const String.fromEnvironment("baseUrl");
    _tokenController.text = const String.fromEnvironment("token");
    super.initState();
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add Yapi Project",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            _builderInput(
              context,
              controller: _baseUrlController,
              label: 'Project BaseUrl',
            ),
            const SizedBox(height: 4),
            _builderInput(
              context,
              controller: _tokenController,
              label: 'Token',
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                    onPressed: () {
                      ref.read(homeControllerProvider.notifier).add(
                            baseUrl: _baseUrlController.text,
                            token: _tokenController.text,
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _builderInput(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
