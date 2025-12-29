// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../core/core.dart';

class AppCardItem extends StatelessWidget {
  String? title;
  String? leading;
  Color? backgroundColorLeading;
  Color? colorTextLeading;
  String? subtitle;
  String? descriptionRight;
  String? descriptionLeft;
  IconData? iconLeft;
  IconData? iconRight;
  bool? noDescription;
  void Function()? onTap;
  double? fontSize;

  AppCardItem({
    super.key,
    this.title,
    this.leading,
    this.backgroundColorLeading,
    this.colorTextLeading,
    this.subtitle,
    this.descriptionRight,
    this.descriptionLeft,
    this.iconLeft,
    this.iconRight,
    this.noDescription = false,
    this.onTap,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: AppColors.kBase),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? 'Title',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kBlack,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: backgroundColorLeading,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        leading ?? 'Leading',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: colorTextLeading,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpace.vertical(8),
                Text(
                  subtitle ?? 'Subtitle',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpace.vertical(8),
                noDescription == false
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kBackground,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                iconLeft != null
                                    ? Icon(
                                        iconLeft,
                                        size: fontSize,
                                        color: AppColors.kGrey,
                                      )
                                    : SizedBox(),
                                AppSpace.horizontal(5),
                                Text(
                                  descriptionLeft ?? 'Desc Left',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppColors.kBlack,
                                  ),
                                ),
                              ],
                            ),
                            Text('|'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                iconRight != null
                                    ? Icon(
                                        iconRight,
                                        size: fontSize,
                                        color: AppColors.kGrey,
                                      )
                                    : SizedBox(),
                                AppSpace.horizontal(5),
                                Text(
                                  descriptionRight ?? 'Desc Right',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppColors.kBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
