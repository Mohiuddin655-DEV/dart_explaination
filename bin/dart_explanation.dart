import 'package:dart_explanation/dart_annotation.dart';

void main(List<String> arguments) {
  final example = SimpleClass();
  SimpleClass todo = example.getAnnotationFromField("value");
  print(todo);
}
