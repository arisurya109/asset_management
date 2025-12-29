import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/cubit/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';

class HomeDesktopView extends StatelessWidget {
  final Widget child;

  const HomeDesktopView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _appNavigationSideBar(),

          // Main content
          Expanded(child: child),
        ],
      ),
    );
  }

  BlocBuilder<HomeCubit, int> _appNavigationSideBar() {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, selected) {
        final homeCubit = context.read<HomeCubit>();
        final navbar = homeCubit.navbar;
        return Container(
          width: 200,
          color: AppColors.kWhite,
          child: Column(
            children: [
              AppSpace.vertical(16),
              Text(
                'Asset Management',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kBase,
                ),
              ),
              AppSpace.vertical(24),

              ...navbar.map((navItem) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                      child: Text(
                        navItem['name'].toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    ...(navItem['items'] as List).map((item) {
                      final bool isSelected = selected == item['value'];

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                        child: Material(
                          borderRadius: BorderRadius.circular(5),
                          color: isSelected
                              ? AppColors.kBase
                              : AppColors.kWhite,
                          child: InkWell(
                            onTap: () {
                              homeCubit.changeMenu(item['value']);
                              if (item.containsKey('path')) {
                                context.go(item['path']);
                              }
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              width: context.deviceWidth,
                              child: Row(
                                children: [
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: isSelected
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? AppColors.kWhite
                                          : AppColors.kGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),

              const Spacer(),

              BlocListener<
                AuthenticationDesktopBloc,
                AuthenticationDesktopState
              >(
                listener: (context, state) {
                  if (state.status == StatusAuthenticationDesktop.success &&
                      state.user == null) {
                    homeCubit.resetState();
                    context.read<AuthenticationDesktopBloc>().add(
                      OnResetStateEvent(),
                    );
                    context.pushReplacement('/login');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                  child: Material(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors.kWhite,
                    child: InkWell(
                      onTap: () {
                        context.read<AuthenticationDesktopBloc>().add(
                          OnLogoutEvent(),
                        );
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        width: context.deviceWidth,
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.kGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpace.vertical(12),
            ],
          ),
        );
      },
    );
  }
}
