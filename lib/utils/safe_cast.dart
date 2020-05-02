T safeCast<T>(dynamic object, {T onFailure}) {
  try {
    return object as T;
  }
  // ignore: avoid_catching_errors
  on CastError catch (e) {
    print('CastError: $e');
  }
  // ignore: avoid_catches_without_on_clauses
  catch (_) {}
  return onFailure;
}
