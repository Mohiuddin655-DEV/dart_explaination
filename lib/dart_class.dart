class Tester {
  // This is a simple method
  void sayHello() {
    print("Hello world!");
  }

  // This is a parameterized method
  void sayHelloWith(String message) {
    print("This is a parameterized method with message : $message");
  }

  // This is a return type method
  String getMessage() {
    return "This is a return type method!";
  }
  
  // This is a mappable parameter type method
  void sayHelloCustom({
    required String title, // Required type
    String message = "Hello world!", // Predefined optional type
    String? message2, // Optional type
  }) {
    print("$title : $message");
    print("$title : $message2");
  }
}
