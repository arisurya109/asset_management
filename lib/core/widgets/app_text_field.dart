// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'app_space.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
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

  AppTextField({
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
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
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
              fontSize: widget.fontSize! + 1,
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: widget.fontSize! + 1,
                fontWeight: FontWeight.w400,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.fontSize! + 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSpace.vertical(8),
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
                  fontSize: widget.fontSize! + 1,
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: widget.fontSize! + 1,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          );
  }
}
