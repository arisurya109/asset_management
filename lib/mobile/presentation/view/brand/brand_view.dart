// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/mobile/presentation/bloc/brand/brand_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/mobile/presentation/view/brand/create_asset_brand_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';

class AssetBrandView extends StatefulWidget {
  const AssetBrandView({super.key});

  @override
  State<AssetBrandView> createState() => _AssetBrandViewState();
}

class _AssetBrandViewState extends State<AssetBrandView> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileBrand(),
      mobileMScaffold: _mobileBrand(isLarge: false),
    );
  }

  Widget _mobileBrand({bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission =
            state.user!.modules?.map((p) => p['name'] as String).toList() ?? [];

        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Brand'),
            actions: permission.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.pushExt(CreateAssetBrandView());
                      },
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state) {
              if (state.status == StatusBrand.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
                child: Column(
                  children: [
                    AppTextFieldSearch(
                      controller: _searchC,
                      focusNode: _searchFn,
                      isSearchActive: _isSearchActive,
                      hintText: 'Search',
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) {
                        if (value.isFilled()) {
                          setState(() => _isSearchActive = true);
                          context.read<BrandBloc>().add(
                            OnFindAssetBrandByQuery(value),
                          );
                        }
                      },
                      onChanged: (value) {
                        if (!value.isFilled() && _isSearchActive) {
                          setState(() => _isSearchActive = false);
                          context.read<BrandBloc>().add(OnClearAll());
                        }
                      },
                      onClear: () {
                        setState(() {
                          _searchC.clear();
                          _isSearchActive = false;
                        });
                        context.read<BrandBloc>().add(OnClearAll());
                      },
                    ),
                    AppSpace.vertical(16),
                    if (!_searchC.value.text.isFilled())
                      Expanded(
                        child: Center(
                          child: Text(
                            'Please input brand name or init',
                            style: TextStyle(
                              color: AppColors.kGrey,
                              fontSize: isLarge ? 14 : 12,
                            ),
                          ),
                        ),
                      ),

                    if (_searchC.value.text.isFilled() && state.brands == null)
                      Expanded(
                        child: Center(
                          child: Text(
                            'Category not found',
                            style: TextStyle(
                              color: AppColors.kGrey,
                              fontSize: isLarge ? 14 : 12,
                            ),
                          ),
                        ),
                      ),
                    if (_searchC.value.text.isFilled() && state.brands != null)
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.brands?.length,
                          itemBuilder: (context, index) {
                            final brand = state.brands?[index];
                            return AppCardItem(
                              title: brand?.name,
                              leading: brand?.init,
                              noDescription: true,
                              noSubtitle: true,
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
      },
    );
  }
}
