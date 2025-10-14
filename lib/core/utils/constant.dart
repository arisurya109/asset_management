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

class AssetsHelper {
  static List<String> status = ['READY', 'USE', 'REPAIR', 'DISPOSAL'];
  static List<String> conditions = [
    'NEW',
    'GOOD',
    'OLD',
    'BAD',
    'NEED TO CHECK',
  ];
  static List<String> colors = ['BLACK', 'WHITE', 'GREY', 'RED', 'BLUE'];
}
