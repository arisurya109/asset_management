import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  /// Daftar menu lengkap
  static final List<Map<String, dynamic>> _navbar = [
    {
      'name': 'Menu',
      'items': [
        {'value': 0, 'title': 'Dashboard', 'path': '/'},
        {
          'value': 1,
          'title': 'Assets',
          'path': '/asset',
          'permission': 'assets_view',
        },
        {
          'value': 2,
          'title': 'Preparation',
          'path': '/preparation',
          'permission': 'preparation_view',
        },
        // {
        //   'value': 3,
        //   'title': 'User Management',
        //   'path': '/user-management',
        //   'permission': 'user_view',
        // },
        {
          'value': 4,
          'title': 'Preparation Update',
          'path': '/preparation-update',
        },
        {'value': 5, 'title': 'Return', 'path': '/return'},
      ],
    },
    {
      'name': 'Master',
      'items': [
        {
          'value': 6,
          'title': 'Asset Type',
          'path': '/types',
          'permission': 'master_view',
        },
        {
          'value': 7,
          'title': 'Asset Brand',
          'path': '/master',
          'permission': 'master_view',
        },
        {
          'value': 8,
          'title': 'Asset Category',
          'path': '/master',
          'permission': 'master_view',
        },
        {
          'value': 9,
          'title': 'Asset Model',
          'path': '/master',
          'permission': 'master_view',
        },
        {
          'value': 10,
          'title': 'Location',
          'path': '/location',
          'permission': 'master_view',
        },
        {
          'value': 11,
          'title': 'Set Preparation',
          'path': '/master',
          'permission': 'master_view',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> navbar = List.from(_navbar);

  void changeMenu(int value) => emit(value);

  void resetState() => emit(0);

  void setUserPermissions(List<String> userPermissions) {
    final filteredCategories = _navbar
        .map((category) {
          final List<Map<String, dynamic>> originalItems = List.from(
            category['items'],
          );

          // Filter item berdasarkan izin
          final filteredItems = originalItems.where((item) {
            if (!item.containsKey('permission')) return true;
            return userPermissions.contains(item['permission']);
          }).toList();

          return {'name': category['name'], 'items': filteredItems};
        })
        .where((category) {
          return (category['items'] as List).isNotEmpty;
        })
        .toList();

    navbar = filteredCategories;

    emit(state);
  }
}
