import 'package:flutter/material.dart';
import 'package:asset_management/core/utils/colors.dart';

class AppSegmentedDesktop<T> extends StatelessWidget {
  final List<T> options;
  final T selected;
  final Function(T) onSelected;
  final String Function(T)? labelBuilder;

  const AppSegmentedDesktop({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.kBackground,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.kBackground),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double segmentWidth = constraints.maxWidth / options.length;
          int selectedIndex = options.indexOf(selected);

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                left: selectedIndex * segmentWidth,
                top: 0,
                bottom: 0,
                width: segmentWidth,
                child: Container(
                  margin: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: AppColors.kBase,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: options.map((option) {
                  final bool isSelected = selected == option;
                  return Expanded(
                    child: InkWell(
                      onTap: () => onSelected(option),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.kWhite
                                : AppColors.kGrey,
                          ),
                          child: Text(
                            labelBuilder != null
                                ? labelBuilder!(option)
                                : option.toString(),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
