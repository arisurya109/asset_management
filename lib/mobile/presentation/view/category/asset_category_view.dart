// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/mobile/presentation/bloc/category/category_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_search.dart';
import 'package:asset_management/mobile/presentation/view/category/create_asset_category_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';

class AssetCategoryView extends StatefulWidget {
  const AssetCategoryView({super.key});

  @override
  State<AssetCategoryView> createState() => _AssetCategoryViewState();
}

class _AssetCategoryViewState extends State<AssetCategoryView> {
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
      mobileLScaffold: _mobileCategory(),
      mobileMScaffold: _mobileCategory(isLarge: false),
    );
  }

  Widget _mobileCategory({bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission =
            state.user!.modules?.map((p) => p['name'] as String).toList() ?? [];

        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Category'),
            actions: permission.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.pushExt(CreateAssetCategoryView());
                      },
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.status == StatusCategory.loading) {
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
                          context.read<CategoryBloc>().add(
                            OnFindCategoryByQuery(value),
                          );
                        }
                      },
                      onChanged: (value) {
                        if (!value.isFilled() && _isSearchActive) {
                          setState(() => _isSearchActive = false);
                          context.read<CategoryBloc>().add(OnClearAll());
                        }
                      },
                      onClear: () {
                        setState(() {
                          _searchC.clear();
                          _isSearchActive = false;
                        });
                        context.read<CategoryBloc>().add(OnClearAll());
                      },
                    ),
                    AppSpace.vertical(16),
                    if (!_searchC.value.text.isFilled())
                      Expanded(
                        child: Center(
                          child: Text(
                            'Please input category name or init',
                            style: TextStyle(
                              color: AppColors.kGrey,
                              fontSize: isLarge ? 14 : 12,
                            ),
                          ),
                        ),
                      ),

                    if (_searchC.value.text.isFilled() &&
                        state.categories == null)
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
                    if (_searchC.value.text.isFilled() &&
                        state.categories != null)
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.categories?.length,
                          itemBuilder: (context, index) {
                            final category = state.categories?[index];
                            return AppCardItem(
                              noDescription: true,
                              noSubtitle: true,
                              title: category?.name,
                              leading: category?.init,
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
