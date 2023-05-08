import 'package:dart_explanation/dart_annotation.dart';
import 'package:dart_explanation/pair.dart';

void main(List<String> arguments) {
  final example = SimpleClass();
  final a = Pair.builder<String>("4");
  final b = a.child("data1");

  b.elements;
  print(b.elements);
}
