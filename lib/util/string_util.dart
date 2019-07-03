/// Utils.
class StringUtil {
  /// isEmpty.
  static bool isEmpty(Object value) {
    if (value == null) return true;
    if (value is String && value.isEmpty) {
      return true;
    }
    return false;
  }
}