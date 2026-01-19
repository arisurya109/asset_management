// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

class PickingRequest extends Equatable {
  int? preparationId;
  String? status;
  int? preparationDetailId;
  int? locationId;
  int? assetId;
  int? quantity;
  int? userId;
  int? locationReadydId;
  int? totalBox;

  PickingRequest({
    this.preparationId,
    this.preparationDetailId,
    this.status,
    this.locationId,
    this.assetId,
    this.quantity,
    this.userId,
    this.locationReadydId,
    this.totalBox,
  });

  Map<String, dynamic> toJsonAdd() {
    return {
      'asset_id': assetId,
      'location_id': locationId,
      'quantity': quantity,
    };
  }

  String? validateJsonAdd() {
    if (preparationDetailId == null) {
      return 'Picking item cannot empty';
    } else if (assetId == null) {
      return 'Asset cannot empty';
    } else if (locationId == null) {
      return 'Location cannot empty';
    } else if (quantity == null) {
      return 'Quantity cannot empty';
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJsonStatusReady() {
    return {
      'location_ready_id': locationReadydId,
      'status': status,
      'total_box': totalBox,
    };
  }

  String? validateJsonStatusReady() {
    if (preparationId == null) {
      return 'Picking Id cannot empty';
    } else if (locationReadydId == null) {
      return 'Location cannot empty';
    } else if (status == null) {
      return 'Status cannot empty';
    } else if (totalBox == null) {
      return 'Total Box cannot empty';
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJsonStatusPicking() {
    return {'status': status};
  }

  String? validateJsonStatusPicking() {
    if (preparationId == null) {
      return 'Picking Id cannot empty';
    } else if (status == null) {
      return 'Status cannot empty';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props {
    return [
      preparationId,
      preparationDetailId,
      status,
      locationId,
      assetId,
      quantity,
      userId,
      locationReadydId,
      totalBox,
    ];
  }
}
