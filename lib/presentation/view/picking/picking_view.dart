import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation_detail/preparation_detail_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/picking/picking_list_detail_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingView extends StatelessWidget {
  const PickingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePicking(context),
      mobileMScaffold: _mobilePicking(context, isLarge: false),
    );
  }

  Widget _mobilePicking(BuildContext context, {bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Picking')),
      body: BlocBuilder<PreparationBloc, PreparationState>(
        builder: (context, state) {
          final userId = context.read<AuthenticationBloc>().state.user!.id;
          if (state.status == StatusPreparation.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }
          if (state.preparations == null || state.preparations!.isEmpty) {
            return Center(child: Text('No task picking'));
          }
          List<Preparation> preparations;

          preparations = state.preparations!.where((element) {
            return element.assignedId == userId &&
                (element.status == 'ASSIGNED' || element.status == 'PICKING');
          }).toList();

          if (preparations.isEmpty) {
            return Center(child: Text('No task picking'));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: preparations.length,
            itemBuilder: (context, index) {
              final preparation = preparations[index];
              return AppCardItem(
                title: preparation.preparationCode,
                leading: preparation.status,
                subtitle: preparation.destination,
                noDescription: true,
                fontSize: isLarge ? 14 : 12,
                onTap: preparation.status == 'ASSIGNED'
                    ? () {
                        context.showDialogConfirm(
                          title: 'Start Picking',
                          content: 'Are you sure start picking ?',
                          onCancelText: 'No',
                          onConfirmText: 'Yes',
                          fontSize: isLarge ? 14 : 12,
                          onCancel: () => context.pop(),
                          onConfirm: () {
                            context.read<PreparationBloc>().add(
                              OnUpdatePreparationEvent(
                                preparation.copyWith(status: 'PICKING'),
                              ),
                            );
                            context.read<PreparationBloc>().add(
                              OnFindPreparationByIdEvent(preparation.id!),
                            );
                            context.pop();
                            context.read<PreparationDetailBloc>().add(
                              OnFindAllPreparationDetailByPreparationId(
                                preparation.id!,
                              ),
                            );
                            context.push(PickingListDetailView());
                          },
                        );
                      }
                    : () {
                        context.read<PreparationBloc>().add(
                          OnFindPreparationByIdEvent(preparation.id!),
                        );
                        context.read<PreparationDetailBloc>().add(
                          OnFindAllPreparationDetailByPreparationId(
                            preparation.id!,
                          ),
                        );
                        context.push(PickingListDetailView());
                      },
              );
            },
          );
        },
      ),
    );
  }
}
