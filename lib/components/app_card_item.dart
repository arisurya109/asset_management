// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../core/core.dart';

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
  void Function()? onTap;

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
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.7),
        child: InkWell(
          onTap: onTap,
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
                        fontSize: 18,
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
                          fontSize: 12,
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
                    fontSize: 16,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpace.vertical(8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                              ? Icon(iconLeft, size: 20, color: AppColors.kGrey)
                              : SizedBox(),
                          AppSpace.horizontal(5),
                          Text(
                            descriptionLeft ?? 'Desc Left',
                            style: TextStyle(
                              fontSize: 16,
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
                                  size: 20,
                                  color: AppColors.kGrey,
                                )
                              : SizedBox(),
                          AppSpace.horizontal(5),
                          Text(
                            descriptionRight ?? 'Desc Right',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.kBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
