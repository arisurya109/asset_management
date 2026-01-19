// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetailRequest extends Equatable {
  int? id;
  int? preparationId;
  int? assetModelId;
  String? purchaseOrder;
  int? quantity;
  int? isConsumbale;

  PreparationDetailRequest({
    this.id,
    this.preparationId,
    this.assetModelId,
    this.purchaseOrder,
    this.quantity,
    this.isConsumbale,
  });

  Map<String, dynamic> toJsonCreate() {
    return {
      'model_id': assetModelId,
      'is_consumable': isConsumbale,
      'purchase_order': purchaseOrder,
      'quantity': quantity,
    };
  }

  String? validateCreateRequest() {
    if (preparationId == null) {
      return 'Preparation Id Cannot empty';
    } else if (assetModelId == null) {
      return 'Asset Cannot Empty';
    } else if (quantity == null) {
      return 'Quantity Cannot Empty';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      assetModelId,
      purchaseOrder,
      quantity,
      isConsumbale,
    ];
  }
}
