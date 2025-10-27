import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/view/purchase_order/selected_asset_non_consumable_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePurchaseOrderView extends StatefulWidget {
  const CreatePurchaseOrderView({super.key});

  @override
  State<CreatePurchaseOrderView> createState() =>
      _CreatePurchaseOrderViewState();
}

class _CreatePurchaseOrderViewState extends State<CreatePurchaseOrderView> {
  late TextEditingController poNumberC;
  late TextEditingController descriptionC;
  Vendor? vendor;

  @override
  void initState() {
    poNumberC = TextEditingController();
    descriptionC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    poNumberC.dispose();
    descriptionC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Purchase Order')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppSpace.vertical(16),
              BlocBuilder<MasterBloc, MasterState>(
                builder: (context, state) {
                  return AppDropDownSearch<Vendor>(
                    title: 'Vendor',
                    items: state.vendors ?? [],
                    hintText: 'Selected Vendor',
                    compareFn: (value, value1) => value.name == value1.name,
                    borderRadius: 5,
                    selectedItem: vendor,
                    itemAsString: (value) => value.name ?? '',
                    onChanged: (value) => setState(() {
                      vendor = value;
                    }),
                  );
                },
              ),
              AppSpace.vertical(16),
              AppTextField(
                hintText: 'Example : 30067235',
                title: 'Purchase Order Number',
                controller: poNumberC,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              AppSpace.vertical(16),
              AppTextField(
                hintText: 'Example : Request User A',
                title: 'Description',
                controller: descriptionC,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _selectedAsset(),
              ),
              AppSpace.vertical(32),
              AppButton(
                title: 'Selected Asset',
                onPressed: _selectedAsset,
                width: context.deviceWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectedAsset() {
    final selectedVendor = vendor;
    final poNumber = poNumberC.value.text.trim();
    final description = descriptionC.value.text.trim();

    if (selectedVendor == null) {
      context.showSnackbar(
        'Vendor not yet selected',
        backgroundColor: AppColors.kRed,
      );
    } else if (poNumber.isEmpty || poNumber == '') {
      context.showSnackbar(
        'Purchase order number cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!poNumber.isNumber()) {
      context.showSnackbar(
        'Purchase order number not valid',
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.push(
        SelectedAssetNonConsumableView(
          params: PurchaseOrder(
            purchaseOrderNumber: poNumber,
            vendorId: selectedVendor.id,
            remarks: description,
          ),
        ),
      );
    }
  }
}
