extension StringExt on String? {
  bool isFilled() {
    return this != null && this!.trim().isNotEmpty;
  }

  bool isNumber() {
    return this != null && RegExp(r'^\d+$').hasMatch(this!.trim());
  }
}
