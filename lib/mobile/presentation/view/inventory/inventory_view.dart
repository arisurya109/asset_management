import 'package:asset_management/mobile/presentation/bloc/inventory/inventory_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:asset_management/mobile/presentation/view/inventory/inventory_detail_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';

import '../../../../core/core.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  late TextEditingController _searchC;
  late FocusNode _searchFn;
  bool _isSearchActive = false;

  @override
  void initState() {
    _searchC = TextEditingController();
    _searchFn = FocusNode();
    _searchFn.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _searchC.dispose();
    _searchFn.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileInventory(),
      mobileMScaffold: _mobileInventory(isLarge: false),
    );
  }

  Widget _mobileInventory({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory')),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          final boxs = state.inventory?.boxs;
          final totalBox = state.inventory?.totalBox;
          final assets = state.assets;

          final totalQuantity = assets?.fold<int>(
            0,
            (previousValue, asset) => previousValue + (asset.quantity ?? 0),
          );

          return Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: [
                TextField(
                  controller: _searchC,
                  focusNode: _searchFn,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    if (value.isFilled()) {
                      setState(() => _isSearchActive = true);
                      context.read<InventoryBloc>().add(OnFindInventory(value));
                    }
                  },
                  onChanged: (value) {
                    if (!value.isFilled() && _isSearchActive) {
                      setState(() => _isSearchActive = false);
                      context.read<InventoryBloc>().add(OnClearAll());
                    }
                  },
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: AppColors.kGrey),
                    ),
                    isDense: true,
                    hintText: 'Search by rack or box',
                    hintStyle: TextStyle(fontSize: 13),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: _isSearchActive
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchC.clear();
                                _isSearchActive = false;
                              });
                              context.read<InventoryBloc>().add(OnClearAll());
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: AppColors.kBase,
                        width: 1,
                      ),
                    ),
                  ),
                ),

                AppSpace.vertical(12),
                if (!_searchC.value.text.isFilled())
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        'Please input location rack or box',
                        style: TextStyle(
                          color: AppColors.kGrey,
                          fontSize: isLarge ? 14 : 12,
                        ),
                      ),
                    ),
                  ),

                if (_searchC.value.text.isFilled() &&
                    boxs == null &&
                    assets == null)
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        'Location not found',
                        style: TextStyle(
                          color: AppColors.kGrey,
                          fontSize: isLarge ? 14 : 12,
                        ),
                      ),
                    ),
                  ),

                Expanded(
                  child: ListView(
                    children: [
                      if (_searchC.value.text.isFilled() && totalBox != null)
                        Text(
                          ' Total Box : ${state.inventory!.totalBox}',
                          style: TextStyle(
                            fontSize: isLarge ? 14 : 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      AppSpace.vertical(10),
                      if (_searchC.value.text.isFilled() && boxs != null)
                        ...boxs.map((e) {
                          return AppCardItem(
                            title: e.name,
                            leading: e.boxType,
                            noDescription: true,
                            fontSize: isLarge ? 14 : 12,
                            onTap: () {},
                            subtitle: 'Quantity : ${e.quantityAsset}',
                          );
                        }),
                      if (_searchC.value.text.isFilled() && assets != null)
                        Text(
                          ' Total Quantity : $totalQuantity',
                          style: TextStyle(
                            fontSize: isLarge ? 14 : 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      AppSpace.vertical(10),
                      if (_searchC.value.text.isFilled() && assets != null)
                        ...assets.map((e) {
                          if (!e.status.isFilled() &&
                              !e.conditions.isFilled()) {
                            return AppCardItem(
                              title: e.model,
                              leading: e.locationDetail,
                              noDescription: true,
                              subtitle: '${e.quantity} Pcs',
                              fontSize: isLarge ? 14 : 12,
                              onTap: () => context.pushExt(
                                InventoryDetailView(params: e),
                              ),
                            );
                          }
                          return AppCardItem(
                            title: e.assetCode ?? e.model,
                            leading: e.locationDetail,
                            noDescription: false,
                            fontSize: isLarge ? 14 : 12,
                            onTap: () =>
                                context.pushExt(InventoryDetailView(params: e)),
                            subtitle: e.serialNumber ?? '${e.quantity} Unit',
                            descriptionLeft: e.status ?? '',
                            descriptionRight: e.conditions ?? '',
                          );
                        }),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
