// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/presentation/view/location/create_location_view.dart';
import 'package:asset_management/presentation/view/location/location_detail_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';

import '../../components/app_list_tile_custom.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => LocationViewState();
}

class LocationViewState extends State<LocationView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileLocation(),
      mobileMScaffold: _mobileLocation(isLarge: false),
    );
  }

  Widget _mobileLocation({bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Location'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreateLocationView()),
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
              } else if (state.locations != null || state.locations != []) {
                final locations = state.locations
                  ?..sort((a, b) => a.name!.compareTo(b.name!));
                List<Location> filteredLocations = [];

                if (query.isNotEmpty || query != '') {
                  filteredLocations = locations!.where((element) {
                    final name = element.name?.toLowerCase() ?? '';
                    final init = element.init?.toLowerCase() ?? '';
                    final type = element.locationType?.toLowerCase() ?? '';
                    return name.contains(query.toLowerCase()) ||
                        init.contains(query.toLowerCase()) ||
                        type.contains(query.toLowerCase());
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
                        fontSize: isLarge ? 14 : 12,
                        onChanged: (value) => setState(() {
                          query = value;
                        }),
                      ),
                      AppSpace.vertical(16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredLocations.isEmpty
                              ? locations?.length
                              : filteredLocations.length,
                          itemBuilder: (context, index) {
                            final location = filteredLocations.isNotEmpty
                                ? filteredLocations[index]
                                : locations?[index];
                            return AppListTileCustom(
                              title: location?.name,
                              fontSize: isLarge ? 14 : 12,
                              trailing: location?.locationType,
                              onTap: () => context.push(
                                LocationDetailView(params: location!),
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
