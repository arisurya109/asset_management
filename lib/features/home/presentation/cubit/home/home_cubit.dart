import 'package:asset_management/core/utils/assets.dart';
import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<List<Map<String, dynamic>>> {
  HomeCubit() : super([]);

  final List<Map<String, dynamic>> _items = [
    {'value': 0, 'icons': Assets.iAssetMaster, 'name': 'Asset Master'},
    {'value': 1, 'icons': Assets.iPreparation, 'name': 'Asset Preparation'},
    {'value': 2, 'icons': Assets.iCount, 'name': 'Asset Count'},
    {'value': 3, 'icons': Assets.iReprint, 'name': 'Reprint Asset'},
    {'value': 4, 'icons': Assets.iReprint, 'name': 'Reprint Location'},
    {'value': 5, 'icons': Assets.iPrinter, 'name': 'Printer'},
  ];

  void loadItems() {
    emit(_items);
  }
}
