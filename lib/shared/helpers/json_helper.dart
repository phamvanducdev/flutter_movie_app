class JsonHelper {
  static double parseToDouble(dynamic json) {
    switch (json.runtimeType) {
      case String:
        return double.tryParse(json) ?? 0.0;
      case int:
        return json.toDouble();
      case double:
        return json;
      default:
        return 0.0;
    }
  }
}
