// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/core/widgets/app_space.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextFieldDesktop extends StatefulWidget {
  String title;
  String hintText;
  bool noTitle;
  TextEditingController? controller;
  void Function(String)? onSubmitted;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  bool? obscureText;
  void Function(String)? onChanged;
  double? fontSize;
  FocusNode? focusNode;

  AppTextFieldDesktop({
    super.key,
    this.title = 'Title',
    this.hintText = 'Hint Text',
    this.noTitle = false,
    this.controller,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText,
    this.onChanged,
    this.fontSize = 12,
    this.focusNode,
  });

  @override
  State<AppTextFieldDesktop> createState() => _AppTextFieldDesktopState();
}

class _AppTextFieldDesktopState extends State<AppTextFieldDesktop> {
  @override
  Widget build(BuildContext context) {
    return widget.noTitle == true
        ? TextField(
            obscureText: widget.obscureText ?? false,
            onChanged: widget.onChanged,
            controller: widget.controller,
            onSubmitted: widget.onSubmitted,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: widget.fontSize!,
            ),
            decoration: InputDecoration(
              suffixIcon: widget.obscureText != null
                  ? GestureDetector(
                      onTap: () => setState(() {
                        widget.obscureText = !widget.obscureText!;
                      }),
                      child: Icon(
                        widget.obscureText == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : null,
              hintText: widget.hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: widget.fontSize!,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.fontSize!,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSpace.vertical(5),
              TextField(
                obscureText: widget.obscureText ?? false,
                onChanged: widget.onChanged,
                controller: widget.controller,
                focusNode: widget.focusNode,
                onSubmitted: widget.onSubmitted,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,

                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: widget.fontSize!,
                ),
                decoration: InputDecoration(
                  suffixIcon: widget.obscureText != null
                      ? GestureDetector(
                          onTap: () => setState(() {
                            widget.obscureText = !widget.obscureText!;
                          }),
                          child: Icon(
                            widget.obscureText == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        )
                      : null,
                  hintText: widget.hintText,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: widget.fontSize! - 1,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          );
  }
}
