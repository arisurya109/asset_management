// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:asset_management/presentation/view/vendor/create_vendor_view.dart';
import 'package:asset_management/presentation/view/vendor/vendor_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';

import '../../components/app_list_tile_custom.dart';

class VendorView extends StatefulWidget {
  const VendorView({super.key});

  @override
  State<VendorView> createState() => VendorViewState();
}

class VendorViewState extends State<VendorView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Vendor'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreateVendorView()),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<MasterBloc, MasterState>(
            builder: (context, state) {
              if (state.status == StatusMaster.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                );
              } else if (state.status == StatusMaster.failed) {
                return Center(child: Text(state.message ?? ''));
              } else if (state.vendors != null || state.vendors != []) {
                final vendors = state.vendors
                  ?..sort((a, b) => a.name!.compareTo(b.name!));
                List<Vendor> filteredVendors = [];

                if (query.isNotEmpty || query != '') {
                  filteredVendors = vendors!.where((element) {
                    final name = element.name?.toLowerCase() ?? '';
                    final init = element.init?.toLowerCase() ?? '';
                    return name.contains(query.toLowerCase()) ||
                        init.contains(query.toLowerCase());
                  }).toList();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      AppSpace.vertical(16),
                      AppTextField(
                        noTitle: true,
                        hintText: 'Search...',
                        onChanged: (value) => setState(() {
                          query = value;
                        }),
                      ),
                      AppSpace.vertical(16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredVendors.isEmpty
                              ? vendors?.length
                              : filteredVendors.length,
                          itemBuilder: (context, index) {
                            final vendor = filteredVendors.isNotEmpty
                                ? filteredVendors[index]
                                : vendors?[index];
                            return AppListTileCustom(
                              title: vendor?.name,
                              trailing: vendor?.init,
                              onTap: () => context.push(
                                VendorDetailView(params: vendor!),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
