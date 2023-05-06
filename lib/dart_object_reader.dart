import 'dart:mirrors';

class ObjectReader {
  final dynamic _model;

  const ObjectReader._(this._model);

  factory ObjectReader.of(dynamic model) => ObjectReader._(model);

  ClassMirror get _mirror => reflect(_model).type;

  List<String> get fields {
    List<String> list = [];
    for (var v in _mirror.declarations.values) {
      if (v is VariableMirror) {
        list.add(MirrorSystem.getName(v.simpleName));
      }
    }
    return list;
  }

  List<String> get methods {
    List<String> list = [];
    for (var v in _mirror.declarations.values) {
      if (v is MethodMirror) {
        list.add(MirrorSystem.getName(v.simpleName));
      }
    }
    return list;
  }
}
