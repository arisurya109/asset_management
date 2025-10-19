import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/printer/printer_export.dart';
import 'package:asset_management/features/user/user_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    List settings = [
      {'title': 'Printer', 'icon': Assets.iPrinter, 'view': PrinterView()},
      {'title': 'Logout', 'icon': Assets.iLogout},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppSpace.vertical(MediaQuery.of(context).viewPadding.top + 5),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: settings.length,
              itemBuilder: (context, index) {
                final setting = settings[index];
                return BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state.status == StatusUser.success &&
                        state.user == null) {
                      context.pushReplacment(LoginView());
                    }
                  },
                  child: ListTile(
                    onTap: () {
                      if (setting['title'] == 'Logout') {
                        context.read<UserBloc>().add(OnLogoutUser());
                      } else {
                        context.push(setting['view']);
                      }
                    },
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    title: Text(
                      setting['title'],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: AppAssetImg(
                        setting['icon'],
                        height: 28,
                        width: 28,
                        color: AppColors.kBlack,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
