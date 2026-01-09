import 'package:asset_management/desktop/presentation/bloc/asset_desktop/asset_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/location_desktop/location_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_detail_desktop/preparation_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/user_management/user_management_bloc.dart';
import 'package:asset_management/desktop/presentation/view/asset/asset_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/asset/asset_detail_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/home/home_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/location/add_location_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/location/location_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/login/login_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation/add_new_preparation_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation/preparation_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation/preparation_detail_desktop_view.dart';
import 'package:asset_management/desktop/presentation/view/preparation_update/preparation_update_view.dart';
import 'package:asset_management/desktop/presentation/view/return/return_desktop_view.dart';
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
            path: '/asset',
            routes: [
              GoRoute(
                path: 'detail',
                pageBuilder: (context, state) {
                  return _buildDesktopTransition(
                    state: state,
                    child: AssetDetailDesktopView(),
                  );
                },
              ),
            ],
            pageBuilder: (context, state) {
              context.read<AssetDesktopBloc>().add(
                OnFindAssetPagination(limit: 10, page: 1),
              );
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
            path: '/return',
            pageBuilder: (context, state) {
              return _buildDesktopTransition(
                state: state,
                child: ReturnDesktopView(),
              );
            },
          ),
          GoRoute(
            path: '/location',
            pageBuilder: (context, state) {
              context.read<LocationDesktopBloc>().add(
                OnFindLocationPagination(limit: 10, page: 1),
              );
              return _buildDesktopTransition(
                state: state,
                child: LocationDesktopView(),
              );
            },
            routes: [
              GoRoute(
                path: 'add',
                pageBuilder: (context, state) {
                  return _buildDesktopTransition(
                    state: state,
                    child: AddLocationDesktopView(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/preparation',
            pageBuilder: (context, state) {
              context.read<PreparationDesktopBloc>().add(
                OnFindPreparationPaginationEvent(limit: 10, page: 1),
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
              GoRoute(
                path: 'detail/:id',
                pageBuilder: (context, state) {
                  final id = state.pathParameters['id'];
                  context.read<PreparationDetailDesktopBloc>().add(
                    OnGetPreparationDetails(int.parse(id!)),
                  );
                  return _buildDesktopTransition(
                    state: state,
                    child: PreparationDetailDesktopView(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/user-management',
            pageBuilder: (context, state) {
              context.read<UserManagementBloc>().add(OnFindAllUsers());
              return _buildDesktopTransition(
                state: state,
                child: UserManagementDesktopView(),
              );
            },
            routes: [
              GoRoute(
                path: 'add',
                pageBuilder: (context, state) {
                  context.read<UserManagementBloc>().add(
                    OnFindAllPermissions(),
                  );
                  return _buildDesktopTransition(
                    state: state,
                    child: AddNewUserDesktopView(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
