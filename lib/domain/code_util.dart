import 'dart:convert';

import 'package:code_builder/code_builder.dart';
import 'package:yapi_model/domain/interface_info.dart';

class CodeUtil {
  static List<Class> gen(String bodyJsonString) {
    final body = Body.fromJson(jsonDecode(bodyJsonString));
    return genFormBody(body);
  }

  static List<Class> genFormBody(Body body, {String? className}) {
    final result = List<Class>.empty(growable: true);

    if (body.type == DataType.object) {
      final name = className ?? "RootClass";

      List containsBody = List<Body>.empty(growable: true);

      final properties = body.properties
          ?.map((propertyName, propertyBody) {
            switch (propertyBody.type) {
              case DataType.string:
              case DataType.number:
              case DataType.boolean:
              case DataType.integer:
                return MapEntry(propertyName, propertyBody.type.name);
              case DataType.array:
                final isObject = propertyBody.items!.type == DataType.object;
                final elementType =
                    isObject ? propertyName : propertyBody.items!.type.name;
                if (isObject) {
                  result.addAll(genFormBody(propertyBody.items!,
                      className: propertyName));
                }
                return MapEntry(propertyName, "List<$elementType>");
              case DataType.object:
                containsBody.add(propertyBody);
                for (var body in containsBody) {
                  result.addAll(
                      genFormBody(body, className: "$name$propertyName"));
                }
                return MapEntry(propertyName, "$name$propertyName");
            }
          })
          .entries
          .toList();

      final fields = properties?.map((property) => Field((f) => f
            ..type = Reference(property.value)
            ..name = property.key)) ??
          [];

      final classInfo = Class(
        (b) => b
          ..name = name
          ..mixins.add(refer("_\$$name"))
          ..fields.addAll(fields),
      );
      result.insert(0, classInfo);
      return result;
    } else {
      return [];
    }
  }
}
