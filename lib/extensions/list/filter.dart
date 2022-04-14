// Function that filter a list of things with a specific condition:
// We will use it to filter the Notes from a specific user on our database.
// "We have a Streams containing a List of things, now we want
// a Stream of the list of the same things as long as it passes this test"

extension Filter<T> on Stream<List<T>> {
  Stream<List<T>> filter(bool Function(T) where) {
    return map((items) => items.where(where).toList());
  }
}
