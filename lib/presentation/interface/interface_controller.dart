import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/model/interface_info.dart';
import 'package:yapi_model/data/yapi_repository.dart';

part 'interface_controller.g.dart';

@riverpod
class InterfaceController extends _$InterfaceController {
  @override
  FutureOr<InterfaceInfo> build({required int id}) async {
    return await ref
        .watch(yapiRepositoryProvider)
        .getInterfaceInfo(id: id)
        .then((result) => result.data);
  }
}
