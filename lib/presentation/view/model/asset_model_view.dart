// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/presentation/view/model/create_asset_model_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';

class AssetModelView extends StatefulWidget {
  const AssetModelView({super.key});

  @override
  State<AssetModelView> createState() => _AssetModelViewState();
}

class _AssetModelViewState extends State<AssetModelView> {
  String query = '';

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
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Model'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreateAssetModelView()),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<MasterBloc, MasterState>(
            builder: (context, state) {
              if (state.status == StatusMaster.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                );
              } else if (state.status == StatusMaster.failed) {
                return Center(
                  child: Text(
                    state.message ?? '',
                    style: TextStyle(fontSize: isLarge ? 14 : 12),
                  ),
                );
              } else if (state.models != null || state.models != []) {
                final models = state.models
                  ?..sort((a, b) => a.name!.compareTo(b.name!));
                List<AssetModel> filteredModels = [];

                if (query.isNotEmpty || query != '') {
                  filteredModels = models!.where((element) {
                    final name = element.name?.toLowerCase() ?? '';
                    final typeName = element.typeName?.toLowerCase() ?? '';
                    final brandName = element.brandName?.toLowerCase() ?? '';
                    final categoryName =
                        element.categoryName?.toLowerCase() ?? '';
                    return name.contains(query.toLowerCase()) ||
                        typeName.contains(query.toLowerCase()) ||
                        brandName.contains(query.toLowerCase()) ||
                        categoryName.contains(query.toLowerCase());
                  }).toList();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      AppSpace.vertical(16),
                      AppTextField(
                        noTitle: true,
                        hintText: 'Search...',
                        fontSize: isLarge ? 14 : 12,
                        onChanged: (value) => setState(() {
                          query = value;
                        }),
                      ),
                      AppSpace.vertical(16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredModels.isEmpty
                              ? models?.length
                              : filteredModels.length,
                          itemBuilder: (context, index) {
                            final type = filteredModels.isNotEmpty
                                ? filteredModels[index]
                                : models?[index];
                            return AppCardItem(
                              title: type?.name,
                              fontSize: isLarge ? 14 : 12,
                              leading: type?.typeName,
                              subtitle: type?.categoryName,
                              descriptionLeft: type?.unit == 1 ? 'Unit' : 'Pcs',
                              descriptionRight: type?.isConsumable == 1
                                  ? 'Consumable'
                                  : 'Non Consumable',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
