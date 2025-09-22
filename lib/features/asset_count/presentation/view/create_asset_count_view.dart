import '../../../../core/widgets/app_space.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../core/extension/string_ext.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/asset_count.dart';
import '../bloc/asset_count/asset_count_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAssetCountView extends StatefulWidget {
  const CreateAssetCountView({super.key});

  @override
  State<CreateAssetCountView> createState() => _CreateAssetCountViewState();
}

class _CreateAssetCountViewState extends State<CreateAssetCountView> {
  late TextEditingController titleC;
  late TextEditingController descriptionC;

  @override
  void dispose() {
    _clearController();
    titleC.dispose();
    descriptionC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController();
    descriptionC = TextEditingController();
  }

  _clearController() {
    titleC.clear();
    descriptionC.clear();
  }

  _onSubmit() {
    if (!titleC.value.text.trim().isFilled()) {
      context.showSnackbar(
        'The title cannot be empty.',
        backgroundColor: Colors.red,
      );
    } else {
      context.read<AssetCountBloc>().add(
        OnCreateAssetCount(
          AssetCount(
            title: titleC.value.text.trim(),
            description: descriptionC.value.text.trim(),
            status: StatusCount.CREATED,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE ASSET COUNT'),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                controller: titleC,
                hintText: 'Title',
                title: 'Title',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: descriptionC,
                hintText: 'Description',
                title: 'Description',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<AssetCountBloc, AssetCountState>(
                listener: (context, state) {
                  if (state.status == StatusAssetCount.failed) {
                    _clearController();
                    context.showSnackbar(
                      backgroundColor: Colors.red,
                      state.message ?? 'Failed to create asset count',
                    );
                  }

                  if (state.status == StatusAssetCount.created) {
                    _clearController();
                    Navigator.pop(context);
                    context.showSnackbar(
                      state.message ?? 'Successfully Created Asset Count',
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusAssetCount.loading
                        ? 'Loading...'
                        : 'Submit',
                    onPressed: state.status == StatusAssetCount.loading
                        ? null
                        : _onSubmit,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
