import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'package:yapi_model/domain/interface_info.dart';

class CodeUtil {
  static const _typeMap = {
    DataType.string: "String",
    DataType.number: "num",
    DataType.boolean: "bool",
    DataType.integer: "int"
  };

  static List<Class> gen(String bodyJsonString) {
    final body = Body.fromJson(jsonDecode(bodyJsonString));
    return genFormBody(body);
  }

  static List<Class> genFormBody(Body body,
      {String? className, String? title, String? description}) {
    final result = List<Class>.empty(growable: true);

    if (body.type == DataType.object) {
      final name = className ?? "RootClass";
      final classInfo = Class(
        (dartClass) {
          dartClass
            ..docs.addDoc([title, description])
            ..annotations.add(refer("freezed"))
            ..name = name
            ..mixins.add(refer("_\$$name"))
            ..constructors.add(Constructor((constructorBuilder) {
              constructorBuilder
                ..factory = true
                ..constant = true
                ..redirect = refer("_$name");

              if (body.properties != null) {
                for (final propertyMap in body.properties!.entries) {
                  final propertyName = propertyMap.key;
                  final propertyInfo = propertyMap.value;
                  switch (propertyInfo.type) {
                    case DataType.string:
                    case DataType.number:
                    case DataType.boolean:
                    case DataType.integer:
                      constructorBuilder.addParameter(
                        name: propertyName,
                        type: _typeMap[propertyInfo.type]!,
                        required:
                            body.required?.contains(propertyName) ?? false,
                        title: propertyInfo.title,
                        description: propertyInfo.description,
                      );
                    case DataType.array:
                      final isObject =
                          propertyInfo.items!.type == DataType.object;
                      final elementType = isObject
                          ? propertyName.toCapitalize()
                          : propertyInfo.items!.type.name;
                      if (isObject) {
                        result.addAll(genFormBody(propertyInfo.items!,
                            className: propertyName.toCapitalize(),
                            title: propertyInfo.title,
                            description: propertyInfo.description));
                      }

                      constructorBuilder.addParameter(
                        name: propertyName.toCapitalize(),
                        type: "List<$elementType>",
                        required:
                            body.required?.contains(propertyName) ?? false,
                        title: propertyInfo.title,
                        description: propertyInfo.description,
                      );

                    // dartClass.fields.add(Field((f) => f
                    //   ..type = Reference("List<$elementType>")
                    //   ..name = propertyName.toCapitalize()
                    //   ..docs.add("///${propertyInfo.title}")
                    //   ..docs.add("///${propertyInfo.description}")));
                    case DataType.object:
                      final className =
                          "${name.toCapitalize()}${propertyName.toCapitalize()}";
                      result.addAll(genFormBody(
                        propertyInfo,
                        className: className,
                        title: propertyInfo.title,
                        description: propertyInfo.description,
                      ));

                      constructorBuilder.addParameter(
                        name: propertyName,
                        type: className,
                        required:
                            body.required?.contains(propertyName) ?? false,
                        title: propertyInfo.title,
                        description: propertyInfo.description,
                      );

                    // dartClass.fields.add(Field((f) => f
                    //   ..type = Reference(className)
                    //   ..name = propertyName
                    //   ..docs.add("///${propertyInfo.title}")
                    //   ..docs.add("///${propertyInfo.description}")));
                  }
                }
              }
            }));

          // if (body.properties != null) {
          //   for (final propertyMap in body.properties!.entries) {
          //     final propertyName = propertyMap.key;
          //     final propertyInfo = propertyMap.value;
          //     switch (propertyInfo.type) {
          //       case DataType.string:
          //       case DataType.number:
          //       case DataType.boolean:
          //       case DataType.integer:
          //         dartClass.fields.add(Field((f) => f
          //           ..type = Reference(_typeMap[propertyInfo.type])
          //           ..name = propertyName
          //           ..docs.add("///${propertyInfo.title}")
          //           ..docs.add("///${propertyInfo.description}")));
          //       case DataType.array:
          //         final isObject = propertyInfo.items!.type == DataType.object;
          //         final elementType = isObject
          //             ? propertyName.toCapitalize()
          //             : propertyInfo.items!.type.name;
          //         if (isObject) {
          //           result.addAll(genFormBody(propertyInfo.items!,
          //               className: propertyName.toCapitalize()));
          //         }
          //         dartClass.fields.add(Field((f) => f
          //           ..type = Reference("List<$elementType>")
          //           ..name = propertyName.toCapitalize()
          //           ..docs.add("///${propertyInfo.title}")
          //           ..docs.add("///${propertyInfo.description}")));
          //       case DataType.object:
          //         final className =
          //             "${name.toCapitalize()}${propertyName.toCapitalize()}";
          //         result
          //             .addAll(genFormBody(propertyInfo, className: className));
          //         dartClass.fields.add(Field((f) => f
          //           ..type = Reference(className)
          //           ..name = propertyName
          //           ..docs.add("///${propertyInfo.title}")
          //           ..docs.add("///${propertyInfo.description}")));
          //     }
          //   }
          // }
        },
      );
      result.insert(0, classInfo);
      return result;
    } else {
      return [];
    }
  }
}

extension StringExtension on String {
  String toCapitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension ConstructorBuilderAdd on ConstructorBuilder {
  void addParameter(
      {required String name,
      required String type,
      bool required = false,
      String? title,
      String? description}) {
    final parameter = Parameter(
      (parameterBuilder) {
        parameterBuilder
          ..docs.addDoc([title, description])
          ..name = name
          ..named = true
          ..required = required
          ..type = refer(type);
      },
    );
    optionalParameters.add(parameter);
  }
}

extension DocAdd on ListBuilder<String> {
  void addDoc(List<String?> docs) {
    addAll(docs
        .whereType<String>()
        .where((e) => e.isNotEmpty)
        .map((e) => "/// $e"));
  }
}
