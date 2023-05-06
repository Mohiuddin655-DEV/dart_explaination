import 'dart:mirrors';

class DartAnnotation {
  void run() {
    MyClass myClass = MyClass();
    InstanceMirror im = reflect(myClass);
    ClassMirror classMirror = im.type;

    classifiedAnnotationData(classMirror);
    declarationsAnnotationData(classMirror);
  }

  void classifiedAnnotationData(ClassMirror classMirror) {
    for (var metadata in classMirror.metadata) {
      final data = metadata.reflectee;
      final annotation = data.runtimeType;

      if (data is Todo) {
        final name = data.name;
        final description = data.description;
        print(
            "This is class annotation data \t\t\t: $annotation {$name, $description}");
      }
    }
  }

  void declarationsAnnotationData(ClassMirror classMirror) {
    for (var v in classMirror.declarations.values) {
      if (v.metadata.isNotEmpty) {
        final data = v.metadata.first.reflectee;
        final annotation = data.runtimeType;

        if (data is Todo) {
          final name = data.name;
          final description = data.description;
          print(
              "This is declarations annotation data \t: $annotation {$name, $description}");
        }
      }
    }
  }
}

class Todo {
  final String name;
  final String description;

  const Todo(this.name, this.description);
}

@Todo('Chiba', 'Rename class')
class MyClass {
  @Todo('Waisted', 'Change field type')
  int? value;

  @Todo('Anyone', 'Change format')
  void printValue() {
    print('value: $value');
  }

  @Todo('Anyone', 'Remove this')
  MyClass();
}
