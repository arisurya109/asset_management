// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/main_export.dart';

import '../../bloc/user/user_bloc.dart';

class UserDetailView extends StatefulWidget {
  final User params;

  const UserDetailView({super.key, required this.params});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  _resetPassword() {
    context.showDialogConfirm(
      title: 'Reset Password',
      content: 'Are you sure reset password user ${widget.params.name}?',
      onCancel: () => context.pop(),
      onCancelText: 'No',
      onConfirmText: 'Yes',
      onConfirm: () {
        context.read<UserBloc>().add(OnUpdateUserEvent(widget.params));
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail')),
      bottomNavigationBar: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == StatusUser.failed) {
            context.showSnackbar(
              state.message ?? '',
              backgroundColor: AppColors.kRed,
            );
          }
          if (state.status == StatusUser.success) {
            context.showSnackbar('Successfully Reset Password');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(24),
            child: AppButton(
              title: state.status == StatusUser.loading
                  ? 'Loading...'
                  : 'Reset Password',
              onPressed: state.status == StatusUser.loading
                  ? null
                  : _resetPassword,
            ),
          );
        },
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          AppSpace.vertical(16),
          _description('Username', widget.params.username ?? ''),
          AppSpace.vertical(16),
          _description('Name', widget.params.name ?? ''),
          AppSpace.vertical(16),
          _description(
            'Status',
            widget.params.isActive == 1 ? 'Active' : 'Inactive',
          ),
        ],
      ),
    );
  }

  Widget _description(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        AppSpace.vertical(3),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
