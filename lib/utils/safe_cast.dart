T safeCast<T>(dynamic object, {T onFailure}) {
  try {
    return object as T;
  }
  // ignore: avoid_catching_errors
  on TypeError catch (e) {
    print('TypeError: $e');
  }
  // ignore: avoid_catches_without_on_clauses
  catch (_) {}
  return onFailure;
}
