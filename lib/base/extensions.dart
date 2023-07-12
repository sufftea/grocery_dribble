extension ListX<T> on List<T> {
  List<T> added(T value) {
    return [...this, value];
  }
}
