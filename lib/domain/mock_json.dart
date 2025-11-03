import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/model/interface_info.dart';
import 'package:yapi_model/data/model/mock_path.dart';

part 'mock_json.g.dart';

@riverpod
class MockJson extends _$MockJson {
  @override
  FutureOr<String> build(InterfaceInfo interface) async {
    final mockPath = ref.watch(mockPathProvider(interface: interface));
    final dio = Dio(
      BaseOptions(method: mockPath.method, baseUrl: mockPath.baseUrl),
    );
    final result = await dio
        .request(mockPath.path)
        .then((response) => response.data);
    return const JsonEncoder.withIndent("  ").convert(result);
  }
}
