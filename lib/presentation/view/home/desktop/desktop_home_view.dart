import 'package:asset_management/presentation/components/app_drawer_desktop.dart';
import 'package:asset_management/presentation/view/home/desktop/desktop_assets_view.dart';
import 'package:asset_management/presentation/view/home/desktop/desktop_master_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class DesktopHomeView extends StatefulWidget {
  const DesktopHomeView({super.key});

  @override
  State<DesktopHomeView> createState() => _DesktopHomeViewState();
}

class _DesktopHomeViewState extends State<DesktopHomeView> {
  int selected = 0;
  List drawer = [
    {'title': 'Assets', 'view': DesktopAssetsView()},
    {'title': 'Master', 'view': DesktopMasterView()},
    {'title': 'Dashboard', 'view': Column()},
    {'title': 'User Management', 'view': Scaffold()},
    {'title': 'Purchase Order', 'view': Scaffold()},
    {'title': 'Printer', 'view': Scaffold()},
    {'title': 'Logout', 'view': Scaffold()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF0F0F0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.kWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      AppSpace.vertical(24),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'Asset',
                            style: TextStyle(
                              color: AppColors.kBase,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Management',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      AppSpace.vertical(30),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: List.generate(drawer.length, (index) {
                              final item = drawer[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: AppDrawerDesktop(
                                  title: item['title'],
                                  isSelected: selected == index,
                                  onTap: () => setState(() {
                                    selected = index;
                                  }),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppSpace.horizontal(16),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      width: context.deviceWidth,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        drawer[selected]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  AppSpace.vertical(16),
                  drawer[selected]['view'],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBodyDesktop() {
    return Expanded(
      flex: 14,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                AppSpace.horizontal(16),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                AppSpace.horizontal(16),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                AppSpace.horizontal(16),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpace.vertical(16),
          Expanded(
            flex: 11,
            child: Container(
              decoration: BoxDecoration(color: AppColors.kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
