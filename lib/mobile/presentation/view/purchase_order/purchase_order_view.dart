import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/purchase_order/purchase_order_bloc.dart';
import 'package:asset_management/mobile/presentation/view/purchase_order/create_purchase_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseOrderView extends StatelessWidget {
  const PurchaseOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user?.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Purchase Order'),
            actions: permission?.contains('purchase_add') == true
                ? [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          context.pushExt(CreatePurchaseOrderView());
                        },
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<PurchaseOrderBloc, PurchaseOrderState>(
            builder: (context, state) {
              if (state.status == StatusPurchaseOrder.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                );
              }

              if (state.purchaseOrders == null || state.purchaseOrders == []) {
                return Center(child: Text('Purchase Order are still empty.'));
              }

              if (state.purchaseOrders != null ||
                  state.purchaseOrders!.isNotEmpty) {
                return Container();
              }

              return SizedBox();
            },
          ),
        );
      },
    );
  }
}
