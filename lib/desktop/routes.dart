import 'package:asset_management/desktop/presentation/bloc/asset_desktop/asset_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/user_management/user_management_bloc.dart';
import 'package:asset_management/desktop/presentation/view/asset/asset_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/home/home_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/login/login_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/master/master_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation/add_new_preparation_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation/preparation_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation_update/preparation_update_view.dart';
import 'package:asset_management/desktop/presentation/view/user_management/add_new_user_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/user_management/user_management_desktop_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'presentation/view/dashboard/dashboard_desktop_view.dart';

class Routes {
  static CustomTransitionPage _buildDesktopTransition({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
        );
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
    );
  }

  static final GoRouter config = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginDesktopView(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return HomeDesktopView(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return _buildDesktopTransition(
                state: state,
                child: DashboardDesktopView(),
              );
            },
          ),
          GoRoute(
            path: '/master',
            pageBuilder: (context, state) {
              return _buildDesktopTransition(
                state: state,
                child: MasterDesktopView(),
              );
            },
          ),
          GoRoute(
            path: '/asset',
            pageBuilder: (context, state) {
              context.read<AssetDesktopBloc>().add(OnFindAllAssets());
              return _buildDesktopTransition(
                state: state,
                child: AssetDesktopView(),
              );
            },
          ),
          GoRoute(
            path: '/preparation-update',
            pageBuilder: (context, state) {
              return _buildDesktopTransition(
                state: state,
                child: PreparationUpdateView(),
              );
            },
          ),
          GoRoute(
            path: '/preparation',
            pageBuilder: (context, state) {
              context.read<PreparationDesktopBloc>().add(
                OnFindAllPreparation(),
              );
              return _buildDesktopTransition(
                state: state,
                child: PreparationDesktopView(),
              );
            },
            routes: [
              GoRoute(
                path: 'add',
                pageBuilder: (context, state) {
                  return _buildDesktopTransition(
                    state: state,
                    child: AddNewPreparationDesktopView(),
                  );
                },
              ),
            ],
          ),

          // GoRoute(
          //   path: '/user-management',
          //   routes: [
          //     GoRoute(
          //       path: 'add',
          //       pageBuilder: (context, state) {
          //         context.read<UserManagementBloc>().add(
          //           OnFindAllPermissions(),
          //         );
          //         return _buildDesktopTransition(
          //           state: state,
          //           child: AddNewUserDesktopView(),
          //         );
          //       },
          //     ),
          //   ],
          //   pageBuilder: (context, state) {
          //     context.read<UserManagementBloc>().add(OnFindAllUsers());
          //     return _buildDesktopTransition(
          //       state: state,
          //       child: UserManagementDesktopView(),
          //     );
          //   },
          // ),
        ],
      ),
    ],
  );
}
