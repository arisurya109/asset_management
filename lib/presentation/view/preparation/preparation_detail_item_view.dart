import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/preparation_detail/preparation_detail_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation_item/preparation_item_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationDetailItemView extends StatelessWidget {
  const PreparationDetailItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePreparationDetailItem(),
      mobileMScaffold: _mobilePreparationDetailItem(),
    );
  }

  Widget _mobilePreparationDetailItem({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Preparation Item')),
      body: BlocBuilder<PreparationItemBloc, PreparationItemState>(
        builder: (context, state) {
          final items = state.preparationItem;
          final preparationDetail = context
              .read<PreparationDetailBloc>()
              .state
              .preparationDetail;
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                SizedBox(
                  width: context.deviceWidth,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.deviceWidth / 1.25 - 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _descriptionItem(
                              'Type',
                              preparationDetail?.assetType,
                              isLarge,
                            ),
                            AppSpace.vertical(12),
                            _descriptionItem(
                              'Category',
                              preparationDetail?.assetCategory,
                              isLarge,
                            ),
                            AppSpace.vertical(12),
                            _descriptionItem(
                              'Brand',
                              preparationDetail?.assetBrand,
                              isLarge,
                            ),
                            AppSpace.vertical(12),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _descriptionItem(
                              'Model',
                              preparationDetail?.assetModel,
                              isLarge,
                            ),
                            AppSpace.vertical(12),
                            _descriptionItem(
                              'Quantity',
                              '${preparationDetail?.quantityPicked} / ${preparationDetail?.quantityTarget}',
                              isLarge,
                            ),
                            AppSpace.vertical(12),
                            _descriptionItem(
                              'Status',
                              preparationDetail?.status,
                              isLarge,
                            ),
                            AppSpace.vertical(12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items?.length,
                    itemBuilder: (context, index) {
                      final item = items?[index];
                      return AppCardItem(
                        title: item?.assetCode,
                        subtitle: item?.assetCategory,
                        leading: item?.assetType,
                        descriptionLeft: 'Quantity : ${item?.quantity}',
                        descriptionRight: item!.purchaseOrder!.isEmpty
                            ? 'PO : -'
                            : 'PO : ${item.purchaseOrder}',
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

  Widget _descriptionItem(String title, String? value, bool isLarge) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpace.vertical(3),
        Text(
          value == null
              ? '-'
              : value.isEmpty
              ? '-'
              : value,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
