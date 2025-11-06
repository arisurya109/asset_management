import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopAssetType extends StatelessWidget {
  const DesktopAssetType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterBloc, MasterState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
