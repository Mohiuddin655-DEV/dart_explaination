import 'dart:mirrors';

class TodoAnnotation {
  final String name;
  final String description;

  const TodoAnnotation([this.name = "", this.description = ""]);
}

@TodoAnnotation('This is an annotation class')
class SimpleClass {
  @TodoAnnotation('This is an annotation field')
  int? value;

  @TodoAnnotation('This is an annotation method')
  void call() {}

  @TodoAnnotation('This is an annotation constructor')
  SimpleClass();
}

extension AnnotationFinder on dynamic {
  ClassMirror get _mirror => reflect(this).type;

  T getAnnotation<T>() {
    try {
      return _annotations["$T"];
    } catch (_) {
      return _mirror.newInstance(Symbol(""), []).reflectee;
    }
  }

  T getAnnotationFromField<T>(String field) {
    try {
      return _annotationsFromFields[field]?["$T"];
    } catch (_) {
      return _mirror.newInstance(Symbol(""), []).reflectee;
    }
  }

  T getAnnotationFromMethod<T>(String field) {
    try {
      return _annotationsFromMethods[field]?["$T"];
    } catch (_) {
      return _mirror.newInstance(Symbol(""), []).reflectee;
    }
  }

  Map<String, dynamic> get _annotations {
    Map<String, dynamic> map = {};
    for (var e in _mirror.metadata) {
      final value = e.reflectee;
      final key = e.reflectee.runtimeType.toString();
      map[key] = value;
    }
    return map;
  }

  Map<String, Map<String, dynamic>> get _annotationsFromFields {
    Map<String, Map<String, dynamic>> parentMap = {};
    for (var parent in _mirror.declarations.values) {
      if (parent is VariableMirror) {
        final parentKey = MirrorSystem.getName(parent.simpleName);
        Map<String, dynamic> childMap = {};
        for (var child in parent.metadata) {
          final childValue = child.reflectee;
          final childKey = child.reflectee.runtimeType.toString();
          childMap[childKey] = childValue;
        }
        parentMap[parentKey] = childMap;
      }
    }
    return parentMap;
  }

  Map<String, Map<String, dynamic>> get _annotationsFromMethods {
    Map<String, Map<String, dynamic>> parentMap = {};
    for (var parent in _mirror.declarations.values) {
      if (parent is MethodMirror) {
        final parentKey = MirrorSystem.getName(parent.simpleName);
        Map<String, dynamic> childMap = {};
        for (var child in parent.metadata) {
          final childValue = child.reflectee;
          final childKey = child.reflectee.runtimeType.toString();
          childMap[childKey] = childValue;
        }
        parentMap[parentKey] = childMap;
      }
    }
    return parentMap;
  }
}

enum AnnotationType {
  cls,
  field,
  method,
}
