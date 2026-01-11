// import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
// import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
// import 'package:asset_management/desktop/presentation/components/app_data_table.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../bloc/user_management/user_management_bloc.dart';
// import '../../components/app_header_desktop.dart';

// class UserManagementDesktopView extends StatelessWidget {
//   const UserManagementDesktopView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hasPermission =
//         context.read<AuthenticationDesktopBloc>().state.user?.modules?.any((e) {
//           return e.containsValue('user_add');
//         }) ??
//         false;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AppHeaderDesktop(
//           title: 'User Management',
//           hasPermission: hasPermission,
//           onTapButton: () => context.push('/user-management/add'),
//           titleButton: 'Add New User',
//         ),
//         AppBodyDesktop(
//           body: BlocBuilder<UserManagementBloc, UserManagementState>(
//             builder: (context, state) {
//               final data =
//                   state.users?.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     var e = entry.value;
//                     return {
//                       'no': (index + 1).toString(),
//                       'name': e.name ?? '-',
//                       'username': e.username ?? '-',
//                       'status': e.isActive == 1 ? 'Active' : 'Inactive',
//                     };
//                   }).toList() ??
//                   [];
//               return AppDataTable(
//                 columns: [
//                   DataTableColumn(label: "NO", key: "no", width: 60),
//                   DataTableColumn(label: "NAME", key: "name", width: 200),
//                   DataTableColumn(
//                     label: "USERNAME",
//                     key: "username",
//                     width: 250,
//                   ),
//                   DataTableColumn(
//                     label: "STATUS",
//                     key: "status",
//                     width: 100,
//                     badgeConfig: {
//                       'active': Colors.green,
//                       'inactive': Colors.red,
//                     },
//                   ),
//                 ],
//                 data: data,
//                 isLoading: state.status == StatusUserManagement.loading,
//                 onSearchSubmit: (String query) {},
//                 onClear: () {},
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
