extension StringExt on String? {
  bool isFilled() {
    return this != null && this!.trim().isNotEmpty && this != '';
  }

  bool isNumber() {
    return this != null && RegExp(r'^\d+$').hasMatch(this!.trim());
  }

  String toCapitalize() {
    if (this == null || this!.trim().isEmpty) return '';

    // Hilangkan spasi di awal/akhir, ambil karakter pertama dan kapitalisasi,
    // lalu gabungkan dengan sisa stringnya.
    final trimmed = this!.trim();
    return "${trimmed[0].toUpperCase()}${trimmed.substring(1).toLowerCase()}";
  }
}
