import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/permissions/permissions_bloc.dart';
import 'package:asset_management/mobile/presentation/view/user_management/create_user_view.dart';
import 'package:asset_management/mobile/presentation/view/user_management/user_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/user/user_bloc.dart';

class UserManagementView extends StatelessWidget {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user?.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('User Management'),
            actions: permission?.contains('user_add') == true
                ? [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          context.read<PermissionsBloc>().add(
                            OnFindAllPermissionsEvent(),
                          );
                          context.pushExt(CreateUserView());
                        },
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.status == StatusUser.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                );
              }

              if (state.status == StatusUser.success) {
                if (state.users == null) {
                  return Center(child: Text('Users is empty'));
                }

                if (state.users != null) {
                  final users = state.users;
                  return ListView.builder(
                    itemCount: users?.length,
                    itemBuilder: (context, index) {
                      final user = users?[index];
                      return ListTile(
                        onTap: () {
                          context.pushExt(UserDetailView(params: user!));
                        },
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.kBase,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: AppColors.kWhite),
                          ),
                        ),
                        title: Text(
                          user?.name ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  );
                }
              }

              return Container();
            },
          ),
        );
      },
    );
  }
}
