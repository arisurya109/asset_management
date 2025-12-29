import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/user_management/user_management_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';

class AddNewUserDesktopView extends StatefulWidget {
  const AddNewUserDesktopView({super.key});

  @override
  State<AddNewUserDesktopView> createState() => _AddNewUserDesktopViewState();
}

class _AddNewUserDesktopViewState extends State<AddNewUserDesktopView> {
  final List<Map<String, dynamic>> selectedPermissions = [];

  late TextEditingController nameController;
  late TextEditingController usernameController;

  late FocusNode nameFocus;
  late FocusNode usernameFocus;

  @override
  void initState() {
    nameController = TextEditingController();
    usernameController = TextEditingController();
    nameFocus = FocusNode();
    usernameFocus = FocusNode();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    nameFocus.dispose();
    usernameFocus.dispose();
    super.dispose();
  }

  void _onPermissionToggle(int id, String name, String module) {
    setState(() {
      final index = selectedPermissions.indexWhere(
        (element) => element['id'] == id,
      );

      if (index != -1) {
        selectedPermissions.removeAt(index);
      } else {
        selectedPermissions.add({'id': id, 'name': name, 'module': module});
        selectedPermissions.sort(
          (a, b) => (a['id'] as int).compareTo(b['id'] as int),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeaderDesktop(title: 'Add User', withBackButton: true),
        AppBodyDesktop(
          body: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFormCard(
                  title: "User",
                  width: 400,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: nameController,
                        title: 'Full Name',
                        focusNode: nameFocus,
                        hintText: 'e.g. John Doe',
                        fontSize: 12,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => context.requestFocus(usernameFocus),
                      ),
                      AppSpace.vertical(20),
                      AppTextField(
                        controller: usernameController,
                        focusNode: usernameFocus,
                        title: 'Username',
                        hintText: 'johndoe123',
                        fontSize: 12,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (_) => _addNewUser(),
                      ),
                      AppSpace.vertical(32),
                      BlocConsumer<UserManagementBloc, UserManagementState>(
                        listener: (context, state) {
                          if (state.status == StatusUserManagement.loading) {
                            context.dialogLoadingDesktop();
                          }

                          if (state.status == StatusUserManagement.failure) {
                            context.pop();
                            AppToast.show(
                              context: context,
                              type: ToastType.error,
                              message: state.message!,
                            );
                          }

                          if (state.status == StatusUserManagement.successAdd) {
                            context.pop();
                            nameController.clear();
                            usernameController.clear();
                            selectedPermissions.clear();
                            AppToast.show(
                              context: context,
                              type: ToastType.success,
                              message: state.message!,
                            );
                          }
                        },
                        builder: (context, state) {
                          return AppButton(
                            title: 'Add User Account',
                            fontSize: 12,
                            onPressed: () => _addNewUser(),
                            width: context.deviceWidth,
                            height: 40,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                AppSpace.horizontal(24),
                Expanded(
                  child: _buildFormCard(
                    title: "User Permissions",
                    child: _buildPermissionGrid(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _addNewUser() {
    final name = nameController.value.text;
    final username = usernameController.value.text;
    final modules = selectedPermissions;

    if (!name.isFilled()) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Name cannot be empty',
      );
    } else if (!username.isFilled()) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Username cannot be empty',
      );
    } else if (modules.isEmpty) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Permissions cannot be empty',
      );
    } else {
      context.showDialogConfirm(
        title: 'Add New User ?',
        content: 'Name : $name\nUsername : $username',
        fontSize: 12,
        onCancel: () => context.pop(),
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onConfirm: () {
          context.read<UserManagementBloc>().add(
            OnCreateUser(
              User(name: name, username: username, modules: modules),
            ),
          );
          context.pop();
        },
      );
    }
  }

  Widget _buildFormCard({
    required String title,
    required Widget child,
    double? width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32, thickness: 0.5),
          child,
        ],
      ),
    );
  }

  Widget _buildPermissionGrid() {
    return BlocBuilder<UserManagementBloc, UserManagementState>(
      builder: (context, state) {
        if (state.permissions == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.permissions!.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final module = state.permissions![index];
            final String moduleName = module.module ?? "";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  moduleName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kBase,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  children: module.permissions!.map((item) {
                    return _buildCheckboxItem(
                      label: item.name!.toCapitalize(),
                      id: item.id!,
                      module: moduleName,
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCheckboxItem({
    required String label,
    required int id,
    required String module,
  }) {
    final bool isSelected = selectedPermissions.any(
      (element) => element['id'] == id,
    );

    return InkWell(
      onTap: () => _onPermissionToggle(id, label, module),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kBase.withOpacity(0.05)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? AppColors.kBase : Colors.grey[200]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 18,
              width: 18,
              child: Checkbox(
                value: isSelected,
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                activeColor: AppColors.kBase,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) => _onPermissionToggle(id, label, module),
              ),
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
