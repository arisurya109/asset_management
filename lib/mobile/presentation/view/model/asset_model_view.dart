// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/mobile/presentation/bloc/model/model_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_search.dart';
import 'package:asset_management/mobile/presentation/view/model/create_asset_model_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';

class AssetModelView extends StatefulWidget {
  const AssetModelView({super.key});

  @override
  State<AssetModelView> createState() => _AssetModelViewState();
}

class _AssetModelViewState extends State<AssetModelView> {
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
      mobileLScaffold: _mobileModel(),
      mobileMScaffold: _mobileModel(isLarge: false),
    );
  }

  Widget _mobileModel({bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission =
            state.user!.modules?.map((p) => p['name'] as String).toList() ?? [];
        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Model'),
            actions: permission.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.pushExt(CreateAssetModelView());
                      },
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<ModelBloc, ModelState>(
            builder: (context, state) {
              if (state.status == StatusModel.loading) {
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
                          context.read<ModelBloc>().add(
                            OnFindModelByQuery(value),
                          );
                        }
                      },
                      onChanged: (value) {
                        if (!value.isFilled() && _isSearchActive) {
                          setState(() => _isSearchActive = false);
                          context.read<ModelBloc>().add(OnClearAll());
                        }
                      },
                      onClear: () {
                        setState(() {
                          _searchC.clear();
                          _isSearchActive = false;
                        });
                        context.read<ModelBloc>().add(OnClearAll());
                      },
                    ),
                    AppSpace.vertical(16),
                    if (!_searchC.value.text.isFilled())
                      Expanded(
                        child: Center(
                          child: Text(
                            'Please input model name, type, category or brand',
                            style: TextStyle(
                              color: AppColors.kGrey,
                              fontSize: isLarge ? 14 : 12,
                            ),
                          ),
                        ),
                      ),

                    if (_searchC.value.text.isFilled() && state.models == null)
                      Expanded(
                        child: Center(
                          child: Text(
                            'Model not found',
                            style: TextStyle(
                              color: AppColors.kGrey,
                              fontSize: isLarge ? 14 : 12,
                            ),
                          ),
                        ),
                      ),
                    if (_searchC.value.text.isFilled() && state.models != null)
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.models?.length,
                          itemBuilder: (context, index) {
                            final model = state.models?[index];
                            return AppCardItem(
                              title: model?.name,
                              leading: model?.typeName,
                              subtitle:
                                  '${model?.categoryName} | ${model?.brandName}',
                              noDescription: true,
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
