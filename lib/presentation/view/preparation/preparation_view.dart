import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/preparation/create_preparation_view.dart';
import 'package:asset_management/presentation/view/preparation/preparation_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationView extends StatefulWidget {
  const PreparationView({super.key});

  @override
  State<PreparationView> createState() => _PreparationViewState();
}

class _PreparationViewState extends State<PreparationView> {
  List<String> _statusPreparation = [
    'ALL',
    'DRAFT',
    'ASSIGNED',
    'PICKING',
    'PARTIAL READY',
    'READY',
    'DISPATCHED',
    'COMPLETED',
  ];

  String _selectedStatus = 'ALL';

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
                  final preparations = state.preparations?.where((element) {
                    final status = element.status;

                    return _selectedStatus == 'ALL' ||
                        _selectedStatus == status;
                  }).toList();

                  return Column(
                    children: [
                      AppDropDownSearch<String>(
                        title: '',
                        selectedItem: _selectedStatus,
                        itemAsString: (value) => value,
                        onChanged: (value) => setState(() {
                          _selectedStatus = value!;
                        }),
                        compareFn: (value, value1) => value == value1,
                        items: _statusPreparation,
                        hintText: 'Selected Status',
                      ),
                      AppSpace.vertical(16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: preparations?.length,
                          itemBuilder: (context, index) {
                            final preparation = state.preparations?[index];
                            return AppCardItem(
                              title: preparation?.preparationCode ?? '',
                              leading: preparation?.status,
                              subtitle: preparation?.destination,
                              noDescription: true,
                              onTap: () {
                                context
                                        .read<PreparationBloc>()
                                        .state
                                        .preparation =
                                    preparation;
                                context.read<PreparationBloc>().add(
                                  OnFindAllPrepartionDetailByPreparationId(
                                    preparation!.id!,
                                  ),
                                );
                                context.push(PreparationDetailView());
                              },
                            );
                          },
                        ),
                      ),
                    ],
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
