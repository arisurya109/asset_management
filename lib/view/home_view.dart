// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view.dart';
import '../bloc/printer/printer_bloc.dart';
import '../core/extension/context_ext.dart';
import '../core/utils/assets.dart';
import '../core/widgets/app_space.dart';
import '../components/app_drawer_item.dart';
import '../components/app_header_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _drawerSelected = 0;
  final List _drawerItem = [
    {'value': 0, 'icon': Assets.iDashboard, 'title': 'DASHBOARD'},
    {'value': 1, 'icon': Assets.iReprint, 'title': 'REPRINT ASSET ID'},
    {'value': 2, 'icon': Assets.iReprint, 'title': 'REPRINT LOCATION'},
    {'value': 3, 'icon': Assets.iPrinter, 'title': 'PRINTER'},
  ];

  final List<Widget> _body = [
    DashboardView(),
    ReprintAssetIdView(),
    ReprintLocationView(),
    PrinterView(),
  ];

  @override
  void initState() {
    super.initState();
    final ipPrinter = context.read<PrinterBloc>().state.ipPrinter;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ipPrinter == null) {
        context.showSnackbar(
          'Please set default printer first',
          backgroundColor: Colors.red,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _drawerSelected, children: _body),
      appBar: AppBar(
        title: Text(_drawerItem[_drawerSelected]['title']),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // biar flat
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1,
              color: Colors.teal, // warna garis
            ),
          ),
        ),
      ),
      drawer: Drawer(
        width: 288,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              AppHeaderDrawer(),
              AppSpace.vertical(12),
              Column(
                children: _drawerItem.map((e) {
                  return AppDrawerItem(
                    title: e['title'],
                    icon: e['icon'],
                    isSelected: _drawerSelected == e['value'],
                    onTap: () => setState(() {
                      _drawerSelected = e['value'];
                      Navigator.pop(context);
                    }),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
