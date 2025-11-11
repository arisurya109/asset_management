import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/preparation_detail/preparation_detail_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/picking/picking_item_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingListDetailView extends StatelessWidget {
  const PickingListDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePickingDetailList(),
      mobileMScaffold: _mobilePickingDetailList(isLarge: false),
    );
  }

  Widget _mobilePickingDetailList({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick List')),
      body: BlocBuilder<PreparationDetailBloc, PreparationDetailState>(
        builder: (context, state) {
          if (state.status == StatusPreparationDetail.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }

          final preparationDetails = state.preparationDetails;

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: preparationDetails?.length,
            itemBuilder: (context, index) {
              final preparationDetail = preparationDetails![index];
              return AppCardItem(
                onTap: () {
                  context.read<PreparationDetailBloc>().add(
                    OnFindPreparationDetailById(
                      preparationDetail.id!,
                      preparationDetail.preparationId!,
                    ),
                  );
                  context.push(PickingItemView());
                },
                fontSize: isLarge ? 14 : 12,
                title: preparationDetail.assetModel,
                leading: preparationDetail.status,
                subtitle:
                    '${preparationDetail.assetCategory} - ${preparationDetail.assetType}',
                descriptionLeft: 'Picked : ${preparationDetail.quantityPicked}',
                descriptionRight:
                    'Target : ${preparationDetail.quantityTarget}',
              );
            },
          );
        },
      ),
    );
  }
}
