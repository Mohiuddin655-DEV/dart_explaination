class Pair {
  const Pair._();

  static Parent<E> builder<E>(E value) => Parent<E>([value]);
}

class Parent<E> {
  var i = false;
  List<E> elements = [];

  Parent(this.elements);

  Child<E> child(E value) {
    var builder = Child<E>(elements);
    if (i) builder.elements.removeLast();
    builder.elements.add(value);
    i = true;
    return builder;
  }
}

class Child<E> {
  var i = false;
  List<E> elements = [];

  Child(this.elements);

  Parent<E> parent(E value) {
    var builder = Parent<E>(elements);
    if (i) builder.elements.removeLast();
    builder.elements.add(value);
    i = true;
    return builder;
  }
}
