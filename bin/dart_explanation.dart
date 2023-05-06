import 'package:dart_explanation/dart_class.dart';

void main(List<String> arguments) {

  var tester = Tester(); // Create a new tester class

  tester.sayHello(); // Simple method call

  tester.sayHelloWith("Hello world!"); // Parameterized method call

  var message = tester.getMessage(); // Return type method call
  print(message); // print returnable data
}
