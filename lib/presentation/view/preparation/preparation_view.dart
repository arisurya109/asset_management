import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/preparation/create_preparation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationView extends StatelessWidget {
  const PreparationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Preparation'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreatePreparationView()),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: BlocBuilder<PreparationBloc, PreparationState>(
              builder: (context, state) {
                if (state.status == StatusPreparation.loading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.kBase),
                  );
                }
                if (state.preparations == null || state.preparations == []) {
                  return Center(child: Text('Preparation still empty'));
                }
                if (state.preparations != null || state.preparations != []) {
                  return ListView.builder(
                    itemCount: state.preparations?.length,
                    itemBuilder: (context, index) {
                      final preparations = state.preparations?[index];
                      return AppCardItem(
                        title: preparations?.preparationCode ?? '',
                        leading: preparations?.status,
                        subtitle: preparations?.destination,
                        noDescription: true,
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}
