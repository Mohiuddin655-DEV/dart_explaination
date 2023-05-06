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
  ClassMirror get mirror => reflect(this).type;

  T? getAnnotation<T>(String name, [AnnotationType type = AnnotationType.cls]) {
    switch (type) {
      case AnnotationType.cls:
        return annotations[name];
      case AnnotationType.field:
        return annotationsFromFields["Symbol(\"$name\")"];
      case AnnotationType.method:
        return annotationsFromMethods["Symbol(\"$name\")"];
    }
  }

  Map<String, dynamic> get annotations {
    Map<String, dynamic> map = {};
    for (var e in mirror.metadata) {
      final value = e.reflectee;
      final key = e.reflectee.runtimeType.toString();
      map[key] = value;
    }
    return map;
  }

  Map<String, dynamic> get annotationsFromFields {
    Map<String, dynamic> map = {};
    for (var v in mirror.declarations.values) {
      if (v is VariableMirror) {
        final key = v.simpleName;
        final data = v.metadata.last.reflectee;
        map["$key"] = data;
      }
    }
    return map;
  }

  Map<String, dynamic> get annotationsFromMethods {
    Map<String, dynamic> map = {};
    for (var v in mirror.declarations.values) {
      if (v is MethodMirror) {
        final key = v.simpleName;
        final data = v.metadata.last.reflectee;
        map["$key"] = data;
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
