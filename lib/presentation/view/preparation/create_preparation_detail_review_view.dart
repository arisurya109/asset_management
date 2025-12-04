import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/main_export.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/view/home/home_view.dart';
import 'package:asset_management/responsive_layout.dart';

class CreatePreparationDetailReviewView extends StatefulWidget {
  final Preparation preparation;
  final List<PreparationDetail> preparationDetails;

  const CreatePreparationDetailReviewView({
    super.key,
    required this.preparation,
    required this.preparationDetails,
  });

  @override
  State<CreatePreparationDetailReviewView> createState() =>
      _CreatePreparationDetailReviewViewState();
}

class _CreatePreparationDetailReviewViewState
    extends State<CreatePreparationDetailReviewView> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileCreatePreparationDetailReview(context),
      mobileMScaffold: _mobileCreatePreparationDetailReview(
        context,
        isLarge: false,
      ),
    );
  }

  Widget _mobileCreatePreparationDetailReview(
    BuildContext context, {
    bool isLarge = true,
  }) {
    return Scaffold(
      appBar: AppBar(title: Text('Preparation Review')),
      bottomNavigationBar: BlocListener<PreparationBloc, PreparationState>(
        listener: (context, state) {
          if (state.status == StatusPreparation.createPreparation) {
            context.pop();
            context.pushReplacment(HomeView());
            context.showSnackbar(
              state.message ?? 'Successfully create preparation',
              fontSize: isLarge ? 14 : 12,
            );
          }

          if (state.status == StatusPreparation.failure) {
            context.pop();
            context.pushReplacment(HomeView());
            context.showSnackbar(
              state.message ?? '',
              backgroundColor: AppColors.kRed,
              fontSize: isLarge ? 14 : 12,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: AppButton(
            title: 'Create Preparation',
            width: context.deviceWidth,
            fontSize: isLarge ? 16 : 14,
            onPressed: () => _createPreparation(isLarge),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              width: context.deviceWidth - 36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _descriptionItem(
                        'Destination',
                        widget.preparation.destination,
                        isLarge,
                      ),
                      AppSpace.vertical(12),

                      _descriptionItem(
                        'Worker',
                        widget.preparation.assigned,
                        isLarge,
                      ),
                      AppSpace.vertical(12),
                      _descriptionItem(
                        'Approved',
                        widget.preparation.approvedBy,
                        isLarge,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _descriptionItem(
                        'Note',
                        widget.preparation.notes,
                        isLarge,
                      ),
                      AppSpace.vertical(12),
                      _descriptionItem(
                        'Status',
                        widget.preparation.assetStatusAfter,
                        isLarge,
                      ),
                      AppSpace.vertical(12),
                      _descriptionItem(
                        'Condition',
                        widget.preparation.assetConditionAfter,
                        isLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpace.vertical(16),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.preparationDetails.length,
                itemBuilder: (context, index) {
                  final preparationDetail = widget.preparationDetails[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.kBase),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          preparationDetail.assetModel!,
                          style: TextStyle(
                            fontSize: isLarge ? 14 : 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        AppSpace.vertical(8),
                        Text(
                          '${preparationDetail.assetCategory} - ${preparationDetail.assetType} ',
                          style: TextStyle(fontSize: isLarge ? 12 : 10),
                        ),
                        AppSpace.vertical(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppColors.kRed,
                              borderRadius: BorderRadius.circular(3),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(3),
                                onTap: () => setState(() {
                                  widget.preparationDetails.removeWhere(
                                    (element) =>
                                        element.assetModelId ==
                                        preparationDetail.assetModelId,
                                  );
                                }),
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    size: 14,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Material(
                                  color: preparationDetail.quantityTarget == 1
                                      ? AppColors.kGrey
                                      : AppColors.kBase,
                                  borderRadius: BorderRadius.circular(3),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(3),
                                    onTap: preparationDetail.quantityTarget == 1
                                        ? null
                                        : () => setState(() {
                                            preparationDetail.quantityTarget =
                                                preparationDetail
                                                    .quantityTarget! -
                                                1;
                                          }),
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        size: 14,
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      preparationDetail.quantityTarget
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: AppColors.kBase,
                                  borderRadius: BorderRadius.circular(3),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(3),
                                    onTap: () => setState(() {
                                      preparationDetail.quantityTarget =
                                          preparationDetail.quantityTarget! + 1;
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 14,
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createPreparation(bool isLarge) {
    context.showDialogConfirm(
      title: 'Create Preparation',
      content: 'Are you sure create preparation ?',
      onCancelText: 'No',
      fontSize: isLarge ? 14 : 12,
      onCancel: () => context.pop(),
      onConfirmText: 'Yes',
      onConfirm: () {
        context.pop();
        context.read<PreparationBloc>().add(
          OnCreatePreparation(widget.preparation, widget.preparationDetails),
        );
        context.dialogLoading();
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
