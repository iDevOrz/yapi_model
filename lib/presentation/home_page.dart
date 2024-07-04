import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/data/yapi_repository.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _resultController = ValueNotifier<Future?>(null);

  YapiRepository get _repository => ref.read(yapiRepositoryProvider);

  @override
  void dispose() {
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: _resultController,
                builder: (ct, future, child) {
                  return FutureBuilder(
                    future: future,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Icon(Icons.stop_circle);
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return const CircularProgressIndicator();
                        case ConnectionState.done:
                          debugPrintStack(
                            label: "error = ${snapshot.error.toString()}",
                            stackTrace: snapshot.stackTrace,
                          );
                          return Text(snapshot.error != null
                              ? snapshot.error.toString()
                              : snapshot.data.toString());
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    final future = _repository.getProject();
                    _resultController.value = future;
                  },
                  child: const Text("获取项目信息")),
              TextButton(
                onPressed: () {
                  final future = _repository.getListMenu(projectId: 440163);
                  _resultController.value = future;
                },
                child: const Text("获取接口列表数据"),
              ),
              TextButton(
                onPressed: () {
                  final future = _repository.getInterfaceInfo(id: 11528431);
                  _resultController.value = future;
                },
                child: const Text("获取接口详细信息"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
