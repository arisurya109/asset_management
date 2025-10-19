import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'create_preparation_view.dart';

class PreparationView extends StatelessWidget {
  const PreparationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preparation'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(CreatePreparationView()),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
