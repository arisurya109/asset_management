import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/user/user.dart';
import '../../components/app_header_desktop.dart';

class AddNewPreparationDesktopView extends StatefulWidget {
  const AddNewPreparationDesktopView({super.key});

  @override
  State<AddNewPreparationDesktopView> createState() =>
      _AddNewPreparationDesktopViewState();
}

class _AddNewPreparationDesktopViewState
    extends State<AddNewPreparationDesktopView> {
  final String _selectedPreparationTypes = 'INTERNAL';
  Location? _selectedDestination;
  User? _selectedApproved;
  User? _selectedWorker;
  late TextEditingController _notesC;

  @override
  void initState() {
    _notesC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeaderDesktop(
          title: 'Create Preparation',
          hasPermission: false,
          withBackButton: true,
        ),
        AppBodyDesktop(
          body: BlocBuilder<DatasDesktopCubit, void>(
            builder: (context, state) {
              return Container(
                width: 350,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppDropDownSearch<Location>(
                      title: 'Destination',
                      hintText: 'Selected Destination',
                      onFind: (String filter) async => await context
                          .read<DatasDesktopCubit>()
                          .findLocationPreparationByTypes(
                            _selectedPreparationTypes,
                          ),
                      borderRadius: 4,
                      compareFn: (value, value1) => value.name == value1.name,
                      itemAsString: (value) => value.name!,
                      fontSize: 11,
                      enabled: true,
                      onChanged: (value) => setState(() {
                        _selectedDestination = value;
                      }),
                      showSearchBox: true,
                      selectedItem: _selectedDestination,
                    ),
                    AppSpace.vertical(12),
                    AppDropDownSearch<User>(
                      title: 'Approved',
                      hintText: 'Selected Approved',
                      onFind: (String filter) async => await context
                          .read<DatasDesktopCubit>()
                          .findAllUser(null),
                      borderRadius: 4,
                      compareFn: (value, value1) => value.name == value1.name,
                      itemAsString: (value) => value.name!,
                      fontSize: 11,
                      enabled: true,
                      onChanged: (value) {
                        if (_selectedApproved != value) {
                          setState(() {
                            _selectedApproved = value;
                            _selectedWorker = null;
                          });
                        }
                      },
                      showSearchBox: true,
                      selectedItem: _selectedApproved,
                    ),
                    AppSpace.vertical(12),
                    AppDropDownSearch<User>(
                      title: 'Worker',
                      hintText: 'Selected Worker',
                      onFind: _selectedApproved == null
                          ? null
                          : (String filter) async => await context
                                .read<DatasDesktopCubit>()
                                .findAllUser(_selectedApproved?.username),
                      borderRadius: 4,
                      compareFn: (value, value1) => value.name == value1.name,
                      itemAsString: (value) => value.name!,
                      fontSize: 11,
                      enabled: true,
                      onChanged: (value) => setState(() {
                        _selectedWorker = value;
                      }),
                      showSearchBox: true,
                      selectedItem: _selectedWorker,
                    ),
                    AppSpace.vertical(12),
                    AppTextFieldDesktop(
                      controller: _notesC,
                      title: 'Notes',
                      fontSize: 11,
                      onSubmitted: (_) => _addPreparation(),
                      hintText: 'Example : New Store / Request By',
                    ),
                    AppSpace.vertical(24),
                    BlocConsumer<
                      PreparationDesktopBloc,
                      PreparationDesktopState
                    >(
                      listener: (context, state) {
                        if (state.status == StatusPreparationDesktop.failure) {
                          context.pop();
                          AppToast.show(
                            context: context,
                            type: ToastType.error,
                            message: state.message!,
                          );
                        }

                        if (state.status ==
                            StatusPreparationDesktop.addSuccess) {
                          context.pop();
                          AppToast.show(
                            context: context,
                            type: ToastType.success,
                            message: state.message!,
                          );
                          context.read<PreparationDesktopBloc>().add(
                            OnFindPreparationPaginationEvent(
                              page: 1,
                              limit: 10,
                            ),
                          );
                          context.pop();
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          title: 'Create',
                          height: 35,
                          width: context.deviceWidth,
                          onPressed:
                              state.status == StatusPreparationDesktop.loading
                              ? null
                              : () => _addPreparation(),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _addPreparation() {
    final type = _selectedPreparationTypes;
    final destination = _selectedDestination;
    final approved = _selectedApproved;
    final worker = _selectedWorker;
    final desc = _notesC.value.text;

    if (destination == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Destination cannot be empty',
      );
    } else if (approved == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Approved cannot be empty',
      );
    } else if (worker == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Worker cannot be empty',
      );
    } else {
      context.showDialogConfirm(
        title: 'Add Preparation ?',
        content:
            'Type : $type\nDestination : ${destination.name}\nApproved : ${approved.name}\nWorker : ${worker.name}\nNotes : $desc',
        onCancel: () => context.pop(),
        fontSize: 12,
        onCancelText: 'No',
        onConfirmText: 'Add',
        onConfirm: () {
          context.read<PreparationDesktopBloc>().add(
            OnCreatePreparationEvent(
              params: Preparation(
                type: type,
                destinationId: destination.id,
                approvedId: approved.id,
                workerId: worker.id,
                notes: desc,
              ),
            ),
          );
          context.pop();
          context.dialogLoadingDesktop();
        },
      );
    }
  }
}
