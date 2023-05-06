import 'dart:mirrors';

class Generic {
  static T instance<T>(
    Type type, [
    Symbol constructor = const Symbol(""),
    List arguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  ]) {
    var mirror = reflectType(type);
    if (mirror is ClassMirror) {
      return mirror.newInstance(constructor, arguments, namedArguments)
          .reflectee;
    } else {
      throw ArgumentError("Cannot create the instance of the type '$type'.");
    }
  }
}
