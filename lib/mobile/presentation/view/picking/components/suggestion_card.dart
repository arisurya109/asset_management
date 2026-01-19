import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking_suggestion.dart';
import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  final PickingSuggestion? suggestion;
  final bool isLarge;
  final bool isConsumable;
  const SuggestionCard({
    super.key,
    required this.suggestion,
    required this.isLarge,
    required this.isConsumable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.kBase),
        color: AppColors.kWhite,
      ),
      child: isConsumable ? _consumable() : _nonConsumable(),
    );
  }

  Widget _consumable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          suggestion?.locationDetail ?? '',
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpace.vertical(10),
        Text(
          suggestion?.locationParent ?? '',
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _nonConsumable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          suggestion?.assetCode ?? '',
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpace.vertical(10),
        Text(
          suggestion?.locationDetail ?? '',
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
