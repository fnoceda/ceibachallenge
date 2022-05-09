const EMPTY = '';
const ZERO = 0;

extension NonNullString on String? {
  String orEmpty() {
    // return this ?? '';
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    // return this ?? '';
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}
