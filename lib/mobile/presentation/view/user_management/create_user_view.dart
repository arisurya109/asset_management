import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/permissions/permissions_bloc.dart';
import '../../bloc/user/user_bloc.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({super.key});

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  late TextEditingController nameC;
  late TextEditingController usernameC;

  final List<int> selectedPermissionIds = [];

  @override
  void initState() {
    nameC = TextEditingController();
    usernameC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    usernameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileCreateUser(context, isLarge: true),
      mobileMScaffold: _mobileCreateUser(context, isLarge: false),
    );
  }

  Widget _mobileCreateUser(BuildContext context, {bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Create User')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          AppSpace.vertical(12),
          AppTextField(
            controller: usernameC,
            hintText: 'Username',
            title: 'Username',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            fontSize: isLarge ? 16 : 14,
          ),
          AppSpace.vertical(12),
          AppTextField(
            controller: nameC,
            hintText: 'Name',
            title: 'Name',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            fontSize: isLarge ? 16 : 14,
          ),
          AppSpace.vertical(24),
          Text(
            'Permissions',
            style: TextStyle(
              fontSize: isLarge ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          BlocBuilder<PermissionsBloc, PermissionsState>(
            builder: (context, state) {
              if (state.permissions == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final Map<String, List<dynamic>> grouped = {};
              for (final perm in state.permissions!) {
                final parts = perm.module!.split('_');
                final module = parts.first; // user, asset, report
                grouped.putIfAbsent(module, () => []);
                grouped[module]!.add(perm);
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: grouped.entries.map((entry) {
                  final moduleName = entry.key;
                  final modulePermissions = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                        child: Text(
                          moduleName.toUpperCase(),
                          style: TextStyle(
                            fontSize: isLarge ? 16 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 24,
                          children: modulePermissions.map((perm) {
                            final id = perm.id;
                            final name = perm.module?.split('_').last ?? '';
                            final isSelected = selectedPermissionIds.contains(
                              id,
                            );

                            return FilterChip(
                              showCheckmark: false,

                              label: Text(
                                (name as String).toUpperCase(),
                                style: TextStyle(fontSize: isLarge ? 16 : 14),
                              ),
                              backgroundColor: AppColors.kBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                  color: isSelected
                                      ? AppColors.kBase
                                      : AppColors.kGrey,
                                  width: 1,
                                ),
                              ),
                              selected: isSelected,
                              selectedColor: AppColors.kGreenLight,
                              onSelected: (value) {
                                setState(() {
                                  if (value) {
                                    selectedPermissionIds.add(id);
                                  } else {
                                    selectedPermissionIds.remove(id);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
          AppSpace.vertical(48),
          BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              selectedPermissionIds.clear();
              usernameC.clear();
              nameC.clear();
              if (state.status == StatusUser.failed) {
                context.showSnackbar(
                  state.message ?? '',
                  backgroundColor: AppColors.kRed,
                );
              }
              if (state.status == StatusUser.success) {
                context.showSnackbar('Successfully create new user');
              }
            },
            builder: (context, state) {
              return AppButton(
                title: state.status == StatusUser.loading
                    ? 'Loading...'
                    : 'Create',
                onPressed: state.status == StatusUser.loading
                    ? null
                    : () => _create(isLarge),
                fontSize: isLarge ? 16 : 14,
              );
            },
          ),
        ],
      ),
    );
  }

  _create(bool isLarge) {
    final name = nameC.value.text.trim();
    final username = usernameC.value.text.trim();
    final permission = selectedPermissionIds;

    if (!name.isFilled()) {
      context.showSnackbar('Name is empty', backgroundColor: AppColors.kRed);
    } else if (!username.isFilled()) {
      context.showSnackbar(
        'Username is empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (permission.isEmpty) {
      context.showSnackbar(
        'Permission is empty',
        backgroundColor: AppColors.kRed,
      );
    } else {
      // context.showDialogConfirm(
      //   title: 'Create New User',
      //   content:
      //       'Are you sure create new user ? \nName : $name\nUsername : $username',
      //   onCancel: () => context.pop(),
      //   onCancelText: 'No',
      //   fontSize: isLarge ? 16 : 14,
      //   onConfirm: () {
      //     context.read<UserBloc>().add(
      //       OnCreateUserEvent(
      //         User(
      //           name: name,
      //           username: username,
      //           isActive: 1,
      //           modules: permission,
      //         ),
      //       ),
      //     );
      //     context.pop();
      //   },
      //   onConfirmText: 'Yes',
      // );
    }
  }
}
