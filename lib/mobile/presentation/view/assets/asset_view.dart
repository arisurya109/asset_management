import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_search.dart';
import 'package:asset_management/mobile/presentation/view/assets/asset_detail_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetView extends StatefulWidget {
  const AssetView({super.key});

  @override
  State<AssetView> createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
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
      mobileLScaffold: _mobileAssets(),
      mobileMScaffold: _mobileAssets(isLarge: false),
    );
  }

  Widget _mobileAssets({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset')),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          if (state.status == StatusAsset.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
            child: Column(
              children: [
                AppTextFieldSearch(
                  controller: _searchC,
                  isSearchActive: _isSearchActive,
                  hintText: 'Search',
                  focusNode: _searchFn,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  onSubmitted: (value) {
                    if (value.isFilled()) {
                      setState(() => _isSearchActive = true);
                      context.read<AssetBloc>().add(OnFindAssetByQuery(value));
                    }
                  },
                  onChanged: (value) {
                    if (!value.isFilled() && _isSearchActive) {
                      setState(() => _isSearchActive = false);
                      context.read<AssetBloc>().add(OnClearAll());
                    }
                  },
                  onClear: () {
                    setState(() {
                      _searchC.clear();
                      _isSearchActive = false;
                    });
                    context.read<AssetBloc>().add(OnClearAll());
                  },
                ),
                AppSpace.vertical(16),
                if (!_searchC.value.text.isFilled())
                  Expanded(
                    child: Center(
                      child: Text(
                        'Please input asset code, serial number or location',
                        style: TextStyle(
                          color: AppColors.kGrey,
                          fontSize: isLarge ? 14 : 12,
                        ),
                      ),
                    ),
                  ),

                if (_searchC.value.text.isFilled() && state.assets == null)
                  Expanded(
                    child: Center(
                      child: Text(
                        'Asset not found',
                        style: TextStyle(
                          color: AppColors.kGrey,
                          fontSize: isLarge ? 14 : 12,
                        ),
                      ),
                    ),
                  ),
                if (_searchC.value.text.isFilled() && state.assets != null)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.assets?.length,
                      itemBuilder: (context, index) {
                        final asset = state.assets?[index];
                        final isConsumable = asset?.uom == 0;

                        return isConsumable
                            ? AppCardItem(
                                onTap: () => context.pushExt(
                                  AssetDetailView(params: asset!),
                                ),
                                title: asset?.model,
                                leading: asset?.types,
                                subtitle: asset?.category,
                                descriptionLeft: '${asset?.quantity} PCS',
                                descriptionRight: asset?.locationDetail,
                                fontSize: isLarge ? 14 : 12,
                              )
                            : AppCardItem(
                                onTap: () => context.pushExt(
                                  AssetDetailView(params: asset!),
                                ),
                                title: asset?.assetCode,
                                leading: asset?.types,
                                subtitle:
                                    asset?.serialNumber ?? asset?.category,
                                descriptionLeft: asset?.status,
                                descriptionRight: asset?.conditions,
                                fontSize: isLarge ? 14 : 12,
                              );
                      },
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
