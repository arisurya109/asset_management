import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_detail_desktop/preparation_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_button_header_table.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_table_fixed.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/export_document_preparation/export_document_preparation_cubit.dart';
import 'package:asset_management/desktop/presentation/view/preparation/preparation_detail_content_assigned_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation/preparation_detail_content_draft_desktop_view.dart';
import 'package:asset_management/domain/entities/preparation/preparation_request.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';

class PreparationDetailDesktopView extends StatefulWidget {
  const PreparationDetailDesktopView({super.key});

  @override
  State<PreparationDetailDesktopView> createState() =>
      _PreparationDetailDesktopViewState();
}

class _PreparationDetailDesktopViewState
    extends State<PreparationDetailDesktopView> {
  late TextEditingController _codeC;
  late TextEditingController _destinationC;
  late TextEditingController _statusC;
  late TextEditingController _notesC;
  late TextEditingController _locationC;
  late TextEditingController _totalBoxC;
  late TextEditingController _workerC;
  late TextEditingController _typeC;

  @override
  void initState() {
    _codeC = TextEditingController();
    _destinationC = TextEditingController();
    _statusC = TextEditingController();
    _notesC = TextEditingController();
    _locationC = TextEditingController();
    _totalBoxC = TextEditingController();
    _workerC = TextEditingController();
    _typeC = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _codeC.dispose();
    _destinationC.dispose();
    _statusC.dispose();
    _notesC.dispose();
    _locationC.dispose();
    _totalBoxC.dispose();
    _workerC.dispose();
    _typeC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationDesktopBloc>().state.user;
    return Column(
      children: [
        AppHeaderDesktop(
          title: 'Preparation Detail',
          hasPermission: false,
          withBackButton: true,
        ),
        AppBodyDesktop(
          body: MultiBlocListener(
            listeners: [
              BlocListener<PreparationDesktopBloc, PreparationDesktopState>(
                listener: (context, state) {
                  if (state.status == StatusPreparationDesktop.failure) {
                    context.pop();
                    AppToast.show(
                      context: context,
                      type: ToastType.error,
                      message: state.message!,
                    );
                  }

                  if (state.status == StatusPreparationDesktop.updateSuccess) {
                    context.pop();
                    context.pop();
                    AppToast.show(
                      context: context,
                      type: ToastType.success,
                      message: state.message!,
                    );
                  }
                },
              ),
              BlocListener<
                PreparationDetailDesktopBloc,
                PreparationDetailDesktopState
              >(
                listener: (context, state) {
                  if (state.status == StatusPreparationDetailDesktop.failure) {
                    context.pop();
                    AppToast.show(
                      context: context,
                      type: ToastType.error,
                      message: state.message!,
                    );
                  }

                  if (state.status ==
                      StatusPreparationDetailDesktop.deleteSuccess) {
                    context.pop();
                    AppToast.show(
                      context: context,
                      type: ToastType.success,
                      message: state.message ?? '',
                    );
                  }

                  if (state.status ==
                      StatusPreparationDetailDesktop.addSuccess) {
                    context.pop();
                    AppToast.show(
                      context: context,
                      type: ToastType.success,
                      message: state.message ?? '',
                    );
                  }
                },
              ),

              BlocListener<
                ExportDocumentPreparationCubit,
                ExportDocumentPreparationState
              >(
                listener: (context, state) async {
                  if (state.status == StatusExport.loading) {
                    context.dialogLoadingDesktop();
                  }

                  if (state.status == StatusExport.failure) {
                    context.pop();
                    AppToast.show(
                      context: context,
                      type: ToastType.error,
                      message: state.message ?? '',
                    );
                    context
                        .read<ExportDocumentPreparationCubit>()
                        .setInitialState();
                  }

                  if (state.status == StatusExport.success) {
                    context.pop();
                    AppToast.show(
                      context: context,
                      type: ToastType.success,
                      message:
                          "Documents successfully exported: ${state.path!.split('\\').last}",
                    );
                    context
                        .read<ExportDocumentPreparationCubit>()
                        .setInitialState();
                    await OpenFile.open(state.path);
                  }
                },
              ),
            ],
            child: BlocBuilder<PreparationDetailDesktopBloc, PreparationDetailDesktopState>(
              builder: (context, state) {
                final preparation = state.preparationDetails?.preparation;
                final preparationDetails =
                    state.preparationDetails?.preparationDetail;
                _codeC = TextEditingController(text: preparation?.code);
                _destinationC = TextEditingController(
                  text: preparation?.destination,
                );
                _statusC = TextEditingController(text: preparation?.status);
                _notesC = TextEditingController(text: preparation?.notes);
                _locationC = TextEditingController(
                  text: preparation?.location ?? '-',
                );
                _totalBoxC = TextEditingController(
                  text: preparation?.totalBox?.toString() ?? '-',
                );
                _workerC = TextEditingController(text: preparation?.worker);
                _typeC = TextEditingController(text: preparation?.type);

                final datasTable =
                    state.preparationDetails?.preparationDetail
                        ?.asMap()
                        .entries
                        .map((entry) {
                          int index = entry.key;
                          var e = entry.value;

                          return {
                            'id': e.id.toString(),
                            'no': (index + 1).toString(),
                            'type': e.type ?? '',
                            'category': e.category ?? '',
                            'model': e.model ?? '',
                            'quantity': e.quantity.toString(),
                            'status': e.status ?? '',
                            'purchase_order': e.purchaseOrder ?? '',
                          };
                        })
                        .toList() ??
                    [];
                final details =
                    state.preparationDetails?.preparationDetail ?? [];

                details.sort((a, b) {
                  int cmp = (a.isConsumable ?? 0).compareTo(
                    b.isConsumable ?? 0,
                  );
                  if (cmp != 0) return cmp;

                  cmp = (a.category ?? '').compareTo(b.category ?? '');
                  if (cmp != 0) return cmp;

                  return (a.type ?? '').compareTo(b.type ?? '');
                });

                int counter = 0;

                final List<Map<String, String>> datasTableReady = details
                    .expand((item) {
                      final allocated = item.allocatedItems ?? [];

                      return allocated.map((e) {
                        counter++;
                        return {
                          'id': e.id.toString(),
                          'no': counter.toString(),
                          'asset_code': e.assetCode ?? '',
                          'category': item.category ?? '',
                          'model': item.model ?? '',
                          'status': item.status ?? '',
                          'conditions': e.conditions ?? '',
                          'purchase_order': e.purchaseOrder ?? '',
                          'quantity': e.quantity.toString(),
                        };
                      });
                    })
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _headerPreparationDetail(context),
                    AppSpace.vertical(12),
                    if (preparation?.status == 'DRAFT')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButtonHeaderTable(
                            title: 'Cancelled',
                            icons: Icons.cancel_outlined,
                            onPressed: () {
                              context.showDialogConfirm(
                                title: 'Cancelled Preparation',
                                content:
                                    'Are your sure cancelled preparation ?\nCode : ${preparation?.code}\nDestination : ${preparation?.destination}',
                                onCancelText: 'Cancel',
                                onConfirmText: 'Ya',
                                fontSize: 12,
                                onCancel: () => context.pop(),
                                onConfirm: () {
                                  context.read<PreparationDesktopBloc>().add(
                                    OnUpdatePreparationStatus(
                                      params: PreparationRequest(
                                        id: preparation?.id,
                                        status: 'CANCELLED',
                                      ),
                                    ),
                                  );
                                  context.pop();
                                  context.dialogLoadingDesktop();
                                },
                              );
                            },
                            borderColor: AppColors.kRed,
                            iconColors: AppColors.kRed,
                            titleColor: AppColors.kRed,
                          ),
                        ],
                      ),
                    if (preparation?.status == 'DRAFT') AppSpace.vertical(8),
                    if (preparation?.status == 'DRAFT')
                      PreparationDetailContentDraftDesktopView(
                        preparation: preparation,
                        preparationDetails: preparationDetails,
                      ),
                    if (preparation?.status == 'READY TO DELIVERY' &&
                        preparation?.createdId == user?.id)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButtonHeaderTable(
                            title: 'Document',
                            icons: Icons.file_download,
                            onPressed: () => context
                                .read<ExportDocumentPreparationCubit>()
                                .exportDocument(preparation!.id!),
                            borderColor: AppColors.kBase,
                            iconColors: AppColors.kBase,
                            titleColor: AppColors.kBase,
                          ),
                          AppSpace.horizontal(16),
                          AppButtonHeaderTable(
                            title: 'Completed',
                            icons: Icons.done,
                            onPressed: () {
                              context.showDialogConfirm(
                                title: 'Completed',
                                content:
                                    'Are your sure completed ${preparation?.code}\nTo ${preparation?.destination} ?',
                                onCancel: () => context.pop(),
                                onConfirm: () {
                                  context.read<PreparationDesktopBloc>().add(
                                    OnUpdatePreparationStatus(
                                      params: PreparationRequest(
                                        id: preparation?.id,
                                        status: 'COMPLETED',
                                      ),
                                    ),
                                  );
                                  context.pop();
                                  context.dialogLoadingDesktop();
                                },
                              );
                            },
                            borderColor: AppColors.kBase,
                            iconColors: AppColors.kBase,
                            titleColor: AppColors.kBase,
                          ),
                        ],
                      ),
                    if (preparation?.status == 'READY' &&
                        preparation?.approvedId == user?.id)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButtonHeaderTable(
                            title: 'Approved',
                            icons: Icons.approval_outlined,
                            onPressed: () {
                              context.showDialogConfirm(
                                title: 'Approved',
                                content:
                                    'Are your sure approved ${preparation?.code}\nTo ${preparation?.destination} ?',
                                onCancel: () => context.pop(),
                                onConfirm: () {
                                  context.read<PreparationDesktopBloc>().add(
                                    OnUpdatePreparationStatus(
                                      params: PreparationRequest(
                                        id: preparation?.id,
                                        status: 'READY TO DELIVERY',
                                      ),
                                    ),
                                  );
                                  context.pop();
                                  context.dialogLoadingDesktop();
                                },
                              );
                            },
                            iconColors: AppColors.kBase,
                            borderColor: AppColors.kBase,
                            titleColor: AppColors.kBase,
                          ),
                          AppSpace.horizontal(16),
                          AppButtonHeaderTable(
                            title: 'Reject',
                            icons: Icons.cancel_outlined,
                            onPressed: () {
                              context.showDialogConfirm(
                                title: 'Reject',
                                content:
                                    'Are your sure reject ${preparation?.code}\nTo ${preparation?.destination} ?',
                                onCancel: () => context.pop(),
                                onConfirm: () {
                                  context.read<PreparationDesktopBloc>().add(
                                    OnUpdatePreparationStatus(
                                      params: PreparationRequest(
                                        id: preparation?.id,
                                        status: 'REJECTED',
                                      ),
                                    ),
                                  );
                                  context.pop();
                                  context.dialogLoadingDesktop();
                                },
                              );
                            },
                            iconColors: AppColors.kRed,
                            borderColor: AppColors.kRed,
                            titleColor: AppColors.kRed,
                          ),
                        ],
                      ),
                    if (preparation?.status == 'ASSIGNED' ||
                        preparation?.status == 'PICKING' ||
                        preparation?.status == 'COMPLETED')
                      PreparationDetailContentAssignedDesktopView(
                        datasTable: datasTable,
                      ),
                    if (preparation?.status == 'READY' ||
                        preparation?.status == 'READY TO DELIVERY')
                      Expanded(
                        child: AppTableFixed(
                          datas: datasTableReady,
                          columns: [
                            AppDataTableColumn(
                              label: 'NO',
                              key: 'no',
                              width: 50,
                            ),
                            AppDataTableColumn(
                              label: 'ASSET CODE',
                              key: 'asset_code',
                              width: 180,
                            ),
                            AppDataTableColumn(
                              label: 'CATEGORY',
                              key: 'category',
                            ),
                            AppDataTableColumn(label: 'MODEL', key: 'model'),
                            AppDataTableColumn(label: 'STATUS', key: 'status'),
                            AppDataTableColumn(
                              label: 'CONDITION',
                              key: 'conditions',
                            ),
                            AppDataTableColumn(
                              label: 'PURCHASE ORDER',
                              key: 'purchase_order',
                            ),
                            AppDataTableColumn(label: 'QTY', key: 'quantity'),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerPreparationDetail(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: context.deviceWidth,
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Code',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 5,
                    controller: _codeC,
                    enabled: false,
                  ),
                ],
              ),
              AppSpace.horizontal(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destination',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 4.5,
                    controller: _destinationC,
                    enabled: false,
                  ),
                ],
              ),
              AppSpace.horizontal(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TYPE',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 5,
                    controller: _typeC,
                    enabled: false,
                  ),
                ],
              ),
              AppSpace.horizontal(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STATUS',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 3,
                    controller: _statusC,
                    enabled: false,
                  ),
                ],
              ),
            ],
          ),
          AppSpace.vertical(16),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 5,
                    controller: _locationC,
                    enabled: false,
                  ),
                ],
              ),
              AppSpace.horizontal(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Box',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 4.5,
                    controller: _totalBoxC,
                    enabled: false,
                  ),
                ],
              ),
              AppSpace.horizontal(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Worker',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 5,
                    controller: _workerC,
                    enabled: false,
                  ),
                ],
              ),
              AppSpace.horizontal(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notes',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppSpace.vertical(5),
                  AppTextFieldSearchDesktop(
                    width: (context.deviceWidth - 272) / 3,
                    controller: _notesC,
                    enabled: false,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
