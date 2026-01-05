// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/mobile/presentation/bloc/location/location_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_search.dart';
import 'package:asset_management/mobile/presentation/view/location/create_location_view.dart';
import 'package:asset_management/mobile/presentation/view/location/location_detail_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => LocationViewState();
}

class LocationViewState extends State<LocationView> {
  late TextEditingController _searchC;
  late FocusNode _searchFn;
  bool _isSearchActive = false;

  @override
  void initState() {
    _searchC = TextEditingController();
    _searchFn = FocusNode();
    _searchFn.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _searchC.dispose();
    _searchFn.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

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
        final permission =
            state.user!.modules?.map((p) => p['name'] as String).toList() ?? [];
        return Scaffold(
          appBar: AppBar(
            title: Text('Location'),
            actions: permission.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.pushExt(CreateLocationView()),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state.status == StatusLocation.loading) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
                child: Column(
                  children: [
                    AppTextFieldSearch(
                      controller: _searchC,
                      focusNode: _searchFn,
                      isSearchActive: _isSearchActive,
                      hintText: 'Search',
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) {
                        if (value.isFilled()) {
                          setState(() => _isSearchActive = true);
                          context.read<LocationBloc>().add(
                            OnFindLocationByQuery(value),
                          );
                        }
                      },
                      onChanged: (value) {
                        if (!value.isFilled() && _isSearchActive) {
                          setState(() => _isSearchActive = false);
                          context.read<LocationBloc>().add(OnClearAll());
                        }
                      },
                      onClear: () {
                        setState(() {
                          _searchC.clear();
                          _isSearchActive = false;
                        });
                        context.read<LocationBloc>().add(OnClearAll());
                      },
                    ),
                    AppSpace.vertical(16),
                    if (!_searchC.value.text.isFilled())
                      Expanded(
                        child: Center(
                          child: Text(
                            'Please input location name or init',
                            style: TextStyle(
                              color: AppColors.kGrey,
                              fontSize: isLarge ? 14 : 12,
                            ),
                          ),
                        ),
                      ),

                    if (_searchC.value.text.isFilled() &&
                        state.locations == null)
                      Expanded(
                        child: Center(
                          child: Text(
                            'Asset not found',
                            style: TextStyle(
                              color: AppColors.kGrey,
                              fontSize: isLarge ? 14 : 12,
                            ),
                          ),
                        ),
                      ),
                    if (_searchC.value.text.isFilled() &&
                        state.locations != null)
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.locations?.length,
                          itemBuilder: (context, index) {
                            final location = state.locations?[index];
                            final isSubtitle =
                                location?.init != null &&
                                location?.code != null;
                            return AppCardItem(
                              onTap: () => context.pushExt(
                                LocationDetailView(params: location!),
                              ),
                              title: location?.name,
                              leading: location?.locationType,
                              subtitle: isSubtitle
                                  ? '${location?.init} | ${location?.code}'
                                  : location?.init != null
                                  ? location!.init
                                  : location?.boxType != null
                                  ? location!.boxType
                                  : location?.parentName != null
                                  ? location!.parentName
                                  : '',
                              noDescription: true,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
