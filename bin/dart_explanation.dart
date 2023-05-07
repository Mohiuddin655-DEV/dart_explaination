import 'package:dart_explanation/dart_annotation.dart';
import 'package:dart_explanation/dart_variable.dart';

void main(List<String> arguments) {
  final example = SimpleClass();
  VariableTester todo = example.getAnnotationFromField("value");
  print(todo);
}
