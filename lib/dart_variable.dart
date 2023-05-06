class VariableTester {

  String message = "This is a global variable!"; // Global variable

  void run(){

    print(message);

    String message2 = "This is a local variable!";
    print(message2);
  }
}