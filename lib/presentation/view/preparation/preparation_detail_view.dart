import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation_detail/preparation_detail_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationDetailView extends StatefulWidget {
  const PreparationDetailView({super.key});

  @override
  State<PreparationDetailView> createState() => _PreparationDetailViewState();
}

class _PreparationDetailViewState extends State<PreparationDetailView> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePreparationDetail(context),
      mobileMScaffold: _mobilePreparationDetail(context, isLarge: false),
    );
  }

  Widget _mobilePreparationDetail(BuildContext context, {bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Preparation Detail')),
      floatingActionButton: BlocConsumer<PreparationBloc, PreparationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == StatusPreparation.success) {
            context.pop();
            context.showSnackbar(
              'Successfully assigned user',
              fontSize: isLarge ? 14 : 12,
            );
          }
          if (state.status == StatusPreparation.failed) {
            context.showSnackbar(
              'Failed assigned user, please try again',
              backgroundColor: AppColors.kRed,
              fontSize: isLarge ? 14 : 12,
            );
          }
        },
        builder: (context, state) {
          if (state.preparation?.status == 'DRAFT') {
            return AppButton(
              width: context.deviceWidth - 32,
              title: 'Assigned',
              onPressed: () {
                context.read<PreparationBloc>().add(
                  OnUpdatePreparationEvent(
                    state.preparation!.copyWith(status: 'ASSIGNED'),
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
      body: BlocBuilder<PreparationDetailBloc, PreparationDetailState>(
        builder: (context, state) {
          if (state.status == StatusPreparationDetail.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }
          final preparationDetails = state.preparationDetails;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _descriptionPreparationDetail(isLarge),
                AppSpace.vertical(16),
                Expanded(
                  child: ListView.builder(
                    itemCount: preparationDetails!.length,
                    itemBuilder: (context, index) {
                      final preparatioDetail = preparationDetails[index];
                      return AppCardItem(
                        fontSize: isLarge ? 14 : 12,
                        title: preparatioDetail.assetModel,
                        leading: preparatioDetail.status,
                        subtitle:
                            '${preparatioDetail.assetCategory} - ${preparatioDetail.assetType}',
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
  }

  Widget _descriptionPreparationDetail(bool isLarge) {
    return BlocSelector<PreparationBloc, PreparationState, Preparation>(
      selector: (state) {
        return state.preparation!;
      },
      builder: (context, state) {
        final preparation = state;
        return SizedBox(
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
                      'Code',
                      preparation.preparationCode!,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Destination',
                      preparation.destination!,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem('Notes', preparation.notes, isLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem('Status', preparation.status!, isLarge),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Created',
                      preparation.createdBy!,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Assigned',
                      preparation.assigned!,
                      isLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
