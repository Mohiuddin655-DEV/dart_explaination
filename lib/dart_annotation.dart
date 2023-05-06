import 'dart:mirrors';

class DartAnnotation {
  void run() {
    final example = SimpleClass();
    final todo =
        example.getAnnotation<TodoAnnotation>("TodoAnnotation", AnnotationType.cls);
    if (todo != null) {
      print(todo.name);
      print(todo.description);
    }
  }
}

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

  T? getAnnotation<T>(String name, [AnnotationType type = AnnotationType.cls]) {
    switch (type) {
      case AnnotationType.cls:
        return _annotations[name];
      case AnnotationType.field:
        return _annotationsFromFields[name];
      case AnnotationType.method:
        return _annotationsFromMethods[name];
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

  Map<String, dynamic> get _annotationsFromFields {
    Map<String, dynamic> map = {};
    for (var v in _mirror.declarations.values) {
      if (v is VariableMirror) {
        final key = MirrorSystem.getName(v.simpleName);
        final data = v.metadata.last.reflectee;
        map[key] = data;
      }
    }
    return map;
  }

  Map<String, dynamic> get _annotationsFromMethods {
    Map<String, dynamic> map = {};
    for (var v in _mirror.declarations.values) {
      if (v is MethodMirror) {
        final key = MirrorSystem.getName(v.simpleName);
        final data = v.metadata.last.reflectee;
        map[key] = data;
      }
    }
    return map;
  }
}

enum AnnotationType {
  cls,
  field,
  method,
}
