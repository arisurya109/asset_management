import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationTemplateDetailView extends StatelessWidget {
  final PreparationTemplate params;

  const PreparationTemplateDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preparation Set Detail')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<MasterBloc, MasterState>(
          builder: (context, state) {
            if (state.preparationTemplateItems == null ||
                state.preparationTemplateItems == []) {
              return Center(child: Text('Asset is empty'));
            }

            if (state.preparationTemplateItems != null ||
                state.preparationTemplateItems != []) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name : ${params.name}'),
                            AppSpace.vertical(5),
                            Text('Description : ${params.description}'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Code : ${params.templateCode}'),
                            AppSpace.vertical(5),
                            Text('Created By : ${params.createdBy}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSpace.vertical(5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.preparationTemplateItems?.length,
                      itemBuilder: (context, index) {
                        final item = state.preparationTemplateItems?[index];
                        return AppCardItem(
                          title: item?.assetModel,
                          subtitle: item?.assetCategory,
                          leading: 'Quantity : ${item?.quantity}',
                          noDescription: true,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
