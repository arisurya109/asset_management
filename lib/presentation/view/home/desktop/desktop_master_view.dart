import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/view/home/desktop/components/desktop_asset_type.dart';
import 'package:flutter/material.dart';

class DesktopMasterView extends StatefulWidget {
  const DesktopMasterView({super.key});

  @override
  State<DesktopMasterView> createState() => _DesktopMasterViewState();
}

class _DesktopMasterViewState extends State<DesktopMasterView> {
  int selected = 0;
  List master = [
    {'title': 'Asset Type', 'view': DesktopAssetType()},
    {'title': 'Asset Category', 'view': Text('Asset Category')},
    {'title': 'Asset Brand', 'view': Text('Asset Brand')},
    {'title': 'Asset Model', 'view': Text('Asset Model')},
    {'title': 'Location', 'view': Text('Location')},
    {'title': 'Vendor', 'view': Text('Vendor')},
    {'title': 'Preparation Set', 'view': Text('Preparation Set')},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpace.vertical(16),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.kGrey, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(master.length, (index) {
              return InkWell(
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                onTap: () => setState(() {
                  selected = index;
                }),
                child: Container(
                  padding: EdgeInsets.only(bottom: 10, right: 16, left: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.5,
                        color: selected == index
                            ? AppColors.kBase
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    master[index]['title'],
                    style: TextStyle(
                      fontWeight: selected == index
                          ? FontWeight.w500
                          : FontWeight.w400,
                      color: selected == index
                          ? AppColors.kBase
                          : AppColors.kGrey,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        AppSpace.vertical(24),
        Expanded(
          child: Container(
            width: context.deviceWidth,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: master[selected]['view'],
          ),
        ),
      ],
    );
  }
}
