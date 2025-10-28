import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/preparation_set/create_preparation_template_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationTemplateView extends StatelessWidget {
  const PreparationTemplateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user!.modules;

        return Scaffold(
          appBar: AppBar(
            title: Text('Preparation Template'),

            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () =>
                          context.push(CreatePreparationTemplateView()),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppSpace.vertical(16),
                Expanded(
                  child: BlocBuilder<MasterBloc, MasterState>(
                    builder: (context, state) {
                      if (state.preparationTemplates == null ||
                          state.preparationTemplates == []) {
                        return Center(child: Text('Template is empty'));
                      }

                      if (state.preparationTemplateItems != null ||
                          state.preparationTemplates != []) {
                        return ListView.builder(
                          itemCount: state.preparationTemplates?.length,
                          itemBuilder: (context, index) {
                            final templates =
                                state.preparationTemplates?[index];
                            return AppCardItem(
                              title: templates?.name ?? '',
                              subtitle: templates?.templateCode,
                            );
                          },
                        );
                      }

                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
