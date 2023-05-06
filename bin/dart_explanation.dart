import 'package:dart_explanation/dart_annotation.dart';
import 'package:dart_explanation/dart_object_reader.dart';

void main(List<String> arguments) {
  final tester = SimpleClass();
  final data = ObjectReader.of(tester);
  print(data.fields);
}
