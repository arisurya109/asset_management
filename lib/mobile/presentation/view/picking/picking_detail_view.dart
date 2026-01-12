import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_item.dart';
import 'package:asset_management/mobile/presentation/bloc/picking_detail/picking_detail_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/view/picking/picking_detail_item.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingDetailView extends StatelessWidget {
  const PickingDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePickingDetail(),
      mobileMScaffold: _mobilePickingDetail(isLarge: false),
    );
  }

  Widget _mobilePickingDetail({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Picking Detail')),
      body: BlocBuilder<PickingDetailBloc, PickingDetailState>(
        builder: (context, state) {
          if (state.status == StatusPickingDetail.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }

          final allItems =
              state.response?.pickingDetail
                  ?.expand(
                    (detail) => detail.allocatedItems ?? <PickingDetailItem>[],
                  )
                  .where((item) => item.status != 'PICKED')
                  .toList() ??
              [];

          allItems.sort(
            (a, b) => (a.location ?? '').compareTo(b.location ?? ''),
          );

          return ListView.builder(
            itemCount: allItems.length,
            padding: EdgeInsets.fromLTRB(16, 5, 16, 8),
            itemBuilder: (context, index) {
              final item = allItems[index];
              return AppCardItem(
                title: item.assetCode,
                leading: item.status,
                subtitle: item.location,
                onTap: () =>
                    context.pushExt(PickingDetailItemView(params: item)),
                noDescription: true,
              );
            },
          );
        },
      ),
    );
  }
}
