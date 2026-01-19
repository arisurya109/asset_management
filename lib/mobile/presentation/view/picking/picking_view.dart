import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking_detail/picking_detail_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/view/picking/picking_detail_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingView extends StatelessWidget {
  const PickingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePicking(),
      mobileMScaffold: _mobilePicking(isLarge: false),
    );
  }

  Widget _mobilePicking({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Picking')),
      body: BlocBuilder<PickingBloc, PickingState>(
        builder: (context, state) {
          if (state.picking == null || state.picking!.isEmpty) {
            return Center(
              child: Text(
                'There is no task to picking assets',
                style: TextStyle(
                  fontSize: isLarge ? 14 : 12,
                  color: AppColors.kGrey,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.picking?.length,
            padding: EdgeInsets.fromLTRB(16, 5, 16, 8),
            itemBuilder: (context, index) {
              final picking = state.picking?[index];

              return BlocListener<PickingBloc, PickingState>(
                listener: (context, state) {
                  if (state.status == StatusPicking.loading) {
                    context.dialogLoading();
                  }
                  if (state.status == StatusPicking.failure) {
                    context.popExt();
                    context.showSnackbar(state.message!);
                  }
                  if (state.status == StatusPicking.updateSuccess) {
                    context.popExt();
                    context.showSnackbar(state.message!);
                  }
                },
                child: AppCardItem(
                  title: picking?.code,
                  leading: picking?.status,
                  subtitle: picking?.destination,
                  noDescription: true,
                  fontSize: isLarge ? 14 : 12,
                  onTap: picking?.status == 'ASSIGNED'
                      ? () => _updateStatusConfirm(
                          context,
                          isLarge: isLarge,
                          params: picking!,
                        )
                      : () {
                          context.read<PickingDetailBloc>().add(
                            OnGetPickingDetailEvent(picking!.id!),
                          );
                          context.pushExt(PickingDetailView());
                        },
                ),
              );
            },
          );
        },
      ),
    );
  }

  _updateStatusConfirm(
    BuildContext context, {
    bool isLarge = true,
    required Picking params,
  }) {
    context.showDialogConfirm(
      title: 'Picking ${params.code}',
      fontSize: isLarge ? 14 : 12,
      content: 'Are your sure start picking ?',
      onCancel: () => context.popExt(),
      onConfirm: () {
        context.read<PickingBloc>().add(
          OnUpdateStatusPickingEvent(
            params: PickingRequest(preparationId: params.id, status: 'PICKING'),
          ),
        );
        context.popExt();
      },
    );
  }
}
