import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';

class AppHeaderDesktop extends StatelessWidget {
  final String title;
  final bool? withBackButton;
  final bool? hasPermission;
  final String? titleButton;
  final void Function()? onTapButton;

  const AppHeaderDesktop({
    super.key,
    required this.title,
    this.hasPermission = false,
    this.titleButton = 'Title Button',
    this.onTapButton,
    this.withBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          withBackButton!
              ? InkWell(
                  onTap: () => context.pop(),
                  radius: 22,
                  borderRadius: BorderRadius.circular(22),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(Icons.arrow_back_rounded, size: 22),
                  ),
                )
              : SizedBox(),

          if (withBackButton!) AppSpace.horizontal(12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          // hasPermission!
          //     ? Material(
          //         borderRadius: BorderRadius.circular(3),
          //         color: AppColors.kBase,
          //         child: InkWell(
          //           onTap: onTapButton,
          //           borderRadius: BorderRadius.circular(3),
          //           child: Container(
          //             alignment: Alignment.center,
          //             margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //             child: Text(
          //               titleButton!,
          //               style: TextStyle(fontSize: 12, color: AppColors.kWhite),
          //             ),
          //           ),
          //         ),
          //       )
          //     : SizedBox.shrink(),
        ],
      ),
    );
  }
}
