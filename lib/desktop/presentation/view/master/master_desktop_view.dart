import 'package:asset_management/core/core.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:flutter/material.dart';

class MasterDesktopView extends StatelessWidget {
  const MasterDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderDesktop(title: 'Master'),
        DefaultTabController(
          length: 6,
          initialIndex: 0,
          child: AppBodyDesktop(
            body: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppColors.kBase,
                  indicatorWeight: 0.5,
                  padding: EdgeInsets.zero,
                  dividerHeight: 2,
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  unselectedLabelColor: AppColors.kGrey,
                  labelColor: AppColors.kBase,
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  tabs: [
                    Tab(text: "Types"),
                    Tab(text: "Brands"),
                    Tab(text: "Categories"),
                    Tab(text: "Models"),
                    Tab(text: "Locations"),
                    Tab(text: "Preparation Set"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: Text('Types View')),
                      Center(child: Text('Brands View')),
                      Center(child: Text('Categories View')),
                      Center(child: Text('Models View')),
                      Center(child: Text('Locations View')),
                      Center(child: Text('Preparation Set View')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
