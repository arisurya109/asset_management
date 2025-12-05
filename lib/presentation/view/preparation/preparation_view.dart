import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/preparation/create_preparation_view.dart';
import 'package:asset_management/presentation/view/preparation/preparation_detail_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationView extends StatefulWidget {
  const PreparationView({super.key});

  @override
  State<PreparationView> createState() => _PreparationViewState();
}

class _PreparationViewState extends State<PreparationView> {
  List<String> statusList = [
    'ASSIGNED',
    'PICKING',
    'READY',
    'APPROVED',
    'COMPLETED',
    'CANCELLED',
  ];
  String selectedStatus = 'ASSIGNED';

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePreparation(context),
      mobileMScaffold: _mobilePreparation(context, isLarge: false),
    );
  }

  Widget _mobilePreparation(BuildContext context, {bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permissions = state.user?.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Preparation'),
            actions: permissions?.contains('preparation_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreatePreparationView()),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: Column(
            children: [
              AppSpace.vertical(8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(statusList.length, (index) {
                    final status = statusList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 12 : 0,
                        right: 12,
                      ),
                      child: InkWell(
                        onTap: () => setState(() {
                          selectedStatus = status;
                        }),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedStatus == status
                                ? AppColors.kBase
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: selectedStatus == status
                                  ? AppColors.kBase
                                  : AppColors.kGrey,
                            ),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: isLarge ? 14 : 12,
                              color: selectedStatus == status
                                  ? AppColors.kWhite
                                  : AppColors.kBlack,
                              fontWeight: selectedStatus == status
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              AppSpace.vertical(8),
              Expanded(
                child: BlocBuilder<PreparationBloc, PreparationState>(
                  builder: (context, state) {
                    if (state.status == StatusPreparation.loading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kBase,
                        ),
                      );
                    }

                    if (state.preparations == null ||
                        state.preparations!.isEmpty) {
                      return Center(child: Text('Preparation is empty'));
                    }

                    List<Preparation> preparations;

                    preparations = state.preparations!.where((element) {
                      return selectedStatus == element.status;
                    }).toList();

                    if (preparations.isEmpty) {
                      return Center(
                        child: Text(
                          'Not Found',
                          style: TextStyle(
                            fontSize: isLarge ? 14 : 12,
                            color: AppColors.kGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: preparations.length,
                      itemBuilder: (context, index) {
                        final preparationFiltered = preparations[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: index == 0 ? 16 : 0,
                            bottom: preparations.length - 1 == index ? 20 : 4,
                          ),
                          child: AppCardItem(
                            fontSize: isLarge ? 14 : 12,
                            title: preparationFiltered.preparationCode,
                            leading: preparationFiltered.status,
                            subtitle: preparationFiltered.destination,
                            noDescription: true,
                            onTap: () {
                              context.read<PreparationBloc>().add(
                                OnFindPreparationById(preparationFiltered.id!),
                              );
                              context.push(PreparationDetailView());
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
