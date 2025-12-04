import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/bloc/user/user_bloc.dart';
import 'package:asset_management/presentation/components/app_header_drawer.dart';
import 'package:asset_management/presentation/components/app_item_drawer.dart';
import 'package:asset_management/presentation/view/assets/asset_view.dart';
import 'package:asset_management/presentation/view/authentication/login_view.dart';
import 'package:asset_management/presentation/view/brand/brand_view.dart';
import 'package:asset_management/presentation/view/category/asset_category_view.dart';
import 'package:asset_management/presentation/view/change_password/change_password_view.dart';
import 'package:asset_management/presentation/view/location/location_view.dart';
import 'package:asset_management/presentation/view/model/asset_model_view.dart';
import 'package:asset_management/presentation/view/preparation/preparation_view.dart';
import 'package:asset_management/presentation/view/preparation_set/preparation_template_view.dart';
import 'package:asset_management/presentation/view/printer/printer_view.dart';
import 'package:asset_management/presentation/view/purchase_order/purchase_order_view.dart';
import 'package:asset_management/presentation/view/type/asset_type_view.dart';
import 'package:asset_management/presentation/view/user_management/user_management_view.dart';
import 'package:asset_management/presentation/view/vendor/vendor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  final bool isLarge;
  const AppDrawer({super.key, required this.isLarge});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.deviceWidth / 2 + 50,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final user = state.user;
          final permission = state.user?.modules;
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).viewPadding.top,
                color: AppColors.kBase,
              ),
              AppHeaderDrawer(user: user, isLarge: widget.isLarge),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppItemDrawer(
                        title: 'Change Password',
                        fontSize: widget.isLarge ? 14 : 12,
                        onTap: () {
                          context.pop();
                          context.push(ChangePasswordView());
                        },
                      ),
                      if (permission?.contains('master_view') == true)
                        BlocBuilder<MasterBloc, MasterState>(
                          builder: (context, state) {
                            return ExpansionTile(
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded = value;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              title: Text(
                                'Master',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: widget.isLarge ? 14 : 12,
                                ),
                              ),
                              trailing: Icon(
                                isExpanded == true
                                    ? Icons.keyboard_arrow_down_rounded
                                    : Icons.keyboard_arrow_right_outlined,
                                size: widget.isLarge ? 22 : 20,
                              ),
                              childrenPadding: EdgeInsets.only(left: 24),
                              children: [
                                AppItemDrawer(
                                  title: 'Asset Brand',
                                  fontSize: widget.isLarge ? 14 : 12,
                                  onTap: () {
                                    isExpanded = false;
                                    context.pop();
                                    context.push(AssetBrandView());
                                  },
                                ),
                                AppItemDrawer(
                                  title: 'Asset Category',
                                  fontSize: widget.isLarge ? 14 : 12,
                                  onTap: () {
                                    isExpanded = false;
                                    context.pop();
                                    context.push(AssetCategoryView());
                                  },
                                ),
                                AppItemDrawer(
                                  title: 'Asset Model',
                                  fontSize: widget.isLarge ? 14 : 12,
                                  onTap: () {
                                    isExpanded = false;
                                    context.pop();
                                    context.push(AssetModelView());
                                  },
                                ),
                                AppItemDrawer(
                                  title: 'Asset Type',
                                  fontSize: widget.isLarge ? 14 : 12,
                                  onTap: () {
                                    isExpanded = false;
                                    context.pop();
                                    context.push(AssetTypeView());
                                  },
                                ),
                                AppItemDrawer(
                                  title: 'Location',
                                  fontSize: widget.isLarge ? 14 : 12,
                                  onTap: () {
                                    isExpanded = false;
                                    context.pop();
                                    context.push(LocationView());
                                  },
                                ),
                                AppItemDrawer(
                                  title: 'Vendor',
                                  fontSize: widget.isLarge ? 14 : 12,
                                  onTap: () {
                                    isExpanded = false;
                                    context.pop();
                                    context.push(VendorView());
                                  },
                                ),
                                AppItemDrawer(
                                  title: 'Preparation Set',
                                  fontSize: widget.isLarge ? 14 : 12,
                                  onTap: () {
                                    isExpanded = false;
                                    context.pop();
                                    context.push(PreparationTemplateView());
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      if (permission?.contains('assets_view') == true)
                        AppItemDrawer(
                          title: 'Assets',
                          fontSize: widget.isLarge ? 14 : 12,
                          onTap: () {
                            context.pop();
                            context.push(AssetView());
                          },
                        ),
                      if (permission?.contains('preparation_view') == true)
                        AppItemDrawer(
                          title: 'Preparation',
                          fontSize: widget.isLarge ? 14 : 12,
                          onTap: () {
                            context.pop();
                            context.read<PreparationBloc>().add(
                              OnFindAllPreparation(),
                            );
                            context.push(PreparationView());
                          },
                        ),

                      if (permission?.contains('user_view') == true)
                        AppItemDrawer(
                          title: 'User Management',
                          fontSize: widget.isLarge ? 14 : 12,
                          onTap: () {
                            context.pop();
                            context.read<UserBloc>().add(OnFindAllUserEvent());
                            context.push(UserManagementView());
                          },
                        ),

                      if (permission?.contains('purchase_view') == true)
                        AppItemDrawer(
                          title: 'Purchase Order',
                          fontSize: widget.isLarge ? 14 : 12,
                          onTap: () {
                            context.pop();
                            context.push(PurchaseOrderView());
                          },
                        ),
                      AppItemDrawer(
                        title: 'Printer',
                        fontSize: widget.isLarge ? 14 : 12,
                        onTap: () {
                          context.pop();
                          context.push(PrinterView());
                        },
                      ),
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state.status == StatusAuthentication.success &&
                              state.user == null) {
                            context.pushReplacment(LoginView());
                          }
                        },
                        child: AppItemDrawer(
                          title: 'Logout',
                          fontSize: widget.isLarge ? 14 : 12,
                          onTap: () => context.read<AuthenticationBloc>().add(
                            OnLogoutEvent(),
                          ),
                        ),
                      ),
                      AppSpace.vertical(16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
