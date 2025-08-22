import 'package:asset_management/core/widgets/app_asset_img.dart';
import 'package:asset_management/features/home/presentation/cubit/home_cubit.dart';
import 'package:asset_management/features/reprint/presentation/view/reprint_asset_id_view.dart';
import 'package:asset_management/features/reprint/presentation/view/reprint_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../printer/presentation/view/printer_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List appFeatures = [
    {'title': 'Reprint Asset', 'value': 0, 'view': ReprintAssetIdView()},
    {'title': 'Reprint Location', 'value': 1, 'view': ReprintLocationView()},

    {'title': 'Printer', 'value': 2, 'view': PrinterView()},
  ];

  _selectedDrawerItem(int value) {
    context.read<HomeCubit>().onSelectedDrawer(value);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<HomeCubit, int, int>(
          selector: (state) {
            return state;
          },
          builder: (context, state) => Text(appFeatures[state]['title']),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                height:
                    MediaQuery.of(context).viewPadding.top +
                    AppBar().preferredSize.height,
                color: Colors.teal,
                child: const Text(
                  'Asset Management',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ExpansionTile(
                shape: Border(),
                leading: AppAssetImg('assets/icons/icons_reprint.png'),
                title: Text('Reprint'),
                children: [
                  ListTile(
                    title: Text('Asset'),
                    onTap: () => _selectedDrawerItem(0),
                  ),
                  ListTile(
                    title: Text('Location'),
                    onTap: () => _selectedDrawerItem(1),
                  ),
                ],
              ),
              ListTile(
                title: Text('Printer'),
                leading: AppAssetImg('assets/icons/icons_printer.png'),
                onTap: () => _selectedDrawerItem(2),
              ),
            ],
          ),
        ),
      ),
      body: BlocSelector<HomeCubit, int, int>(
        selector: (state) {
          return state;
        },
        builder: (context, state) => appFeatures[state]['view'],
      ),
    );
  }
}
