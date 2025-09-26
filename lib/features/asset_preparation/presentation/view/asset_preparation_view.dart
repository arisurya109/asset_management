// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/app_card_item.dart';
import '../../../../core/core.dart';
import '../../asset_preparation.dart';

class AssetPreparationView extends StatefulWidget {
  const AssetPreparationView({super.key});

  @override
  State<AssetPreparationView> createState() => _AssetPreparationViewState();
}

class _AssetPreparationViewState extends State<AssetPreparationView> {
  @override
  void initState() {
    context.read<AssetPreparationBloc>().add(OnFindAllPreparation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET PREPARATION'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAssetPreparationView(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: BlocBuilder<AssetPreparationBloc, AssetPreparationState>(
          builder: (context, state) {
            if (state.status == StatusPreparation.loading) {
              return AppLoadingWidget();
            }

            if (state.preparations == null || state.preparations!.isEmpty) {
              return AppErrorWidget('Preparations is still empty');
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.preparations?.length,
              itemBuilder: (context, index) {
                final preparation = state.preparations![index];
                return AppCardItem(
                  title: preparation.storeName,
                  subtitle:
                      '${preparation.storeInitial} - ${preparation.storeCode}',
                  leading: preparation.status == PreparationStatus.created
                      ? 'CREATED'
                      : preparation.status == PreparationStatus.inprogress
                      ? 'INPROGRESS'
                      : 'COMPLETED',
                  colorTextLeading:
                      preparation.status == PreparationStatus.created
                      ? AppColors.kBlack
                      : preparation.status == PreparationStatus.inprogress
                      ? AppColors.kOrangeDark
                      : AppColors.kGreenDark,
                  backgroundColorLeading:
                      preparation.status == PreparationStatus.created
                      ? Color(0XFFDFE3E8)
                      : preparation.status == PreparationStatus.inprogress
                      ? AppColors.kOrangeLight
                      : AppColors.kGreenLight,
                  descriptionLeft: preparation.preparationCode,
                  descriptionRight: preparation.type,
                  iconRight: Icons.store_outlined,
                  onTap: () => _onTap(preparation),
                );
              },
            );
          },
        ),
      ),
    );
  }

  _onTap(AssetPreparation preparation) {
    if (preparation.status == PreparationStatus.created) {
      context.showDialogConfirm(
        title: 'Start Preparation',
        content: 'Do you want to start preparing your assets?',
        onCancelText: 'No',
        onCancel: () => Navigator.pop(context),
        onConfirmText: 'Ya',
        onConfirm: () {
          context.read<AssetPreparationBloc>().add(
            OnUpdateStatusPreparaion(
              AssetPreparation(
                id: preparation.id,
                status: PreparationStatus.inprogress,
              ),
            ),
          );
          context.read<AssetPreparationBloc>().add(
            OnFindPreparationById(preparation.id!),
          );
          Navigator.pop(context);
          context.read<AssetPreparationDetailBloc>().add(
            OnFindAllPreparationDetails(preparation.id!),
          );
          Future.delayed(Duration(seconds: 9));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddAssetPreparationDetailView()),
          );
        },
      );
    } else {
      context.read<AssetPreparationDetailBloc>().add(
        OnFindAllPreparationDetails(preparation.id!),
      );
      context.read<AssetPreparationBloc>().add(
        OnFindPreparationById(preparation.id!),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddAssetPreparationDetailView()),
      );
    }
  }
}
