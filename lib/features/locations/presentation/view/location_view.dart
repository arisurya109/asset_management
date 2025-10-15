import 'package:asset_management/features/locations/presentation/view/create_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../bloc/bloc/location_bloc.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final TextEditingController _searchC = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET MODEL'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateLocationView()),
            ),
            icon: Icon(Icons.add),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            AppTextField(
              noTitle: true,
              controller: _searchC,
              hintText: 'Search by name, code or category',
              onChanged: (value) => setState(() {
                searchQuery = value.toUpperCase();
              }),
            ),
            AppSpace.vertical(16),
            Expanded(
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  if (state.status == StatusLocation.loading) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColors.kBase),
                    );
                  }

                  if (state.locations == null || state.locations == []) {
                    return Center(
                      child: Text(
                        state.message ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.kGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  // 🔍 Filter list berdasarkan searchQuery
                  final filteredList = state.locations!.where((asset) {
                    final name = asset.name?.toUpperCase() ?? '';
                    final code = asset.code?.toUpperCase() ?? '';
                    final init = asset.init?.toUpperCase() ?? '';
                    return name.contains(searchQuery) ||
                        code.contains(searchQuery) ||
                        init.contains(searchQuery);
                  }).toList();

                  if (filteredList.isEmpty) {
                    return const Center(
                      child: Text(
                        'Location is empty, please insert first',
                        style: TextStyle(color: AppColors.kGrey),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final location = filteredList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Material(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(8),
                          clipBehavior: Clip.antiAlias,
                          elevation: 3,
                          shadowColor: Colors.black.withOpacity(0.7),
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  AppSpace.horizontal(12),
                                  Expanded(
                                    child: Text(
                                      location.name ?? '',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    location.locationType ?? '',
                                    style: TextStyle(
                                      color: AppColors.kBase,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
