class TypeAssets {
  static const pos = 'POS';
  static const backoffice = 'BACKOFFICE';

  static const List<String> types = [pos, backoffice];
}

class TypePreparations {
  static const newstore = 'NEWSTORE';
  static const relocation = 'RELOCATION';
  static const add = 'ADD';

  static const List<String> types = [newstore, relocation, add];
}

class PreparationStatus {
  static const created = 'CREATED';
  static const inprogress = 'INPROGRESS';
  static const completed = 'COMPLETED';
}
