import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:real_estate_ani/ui/shared/constants/app_colors.dart';

import '../constants/textstyles.dart';

/// NOTE: There are more parameters than needed because this is an imported
/// code made to fit this usecase
class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.border,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.suffix,
    this.obscureText = false,
    this.prefix,
    this.initialValue,
    this.focusNode,
    this.readOnly = false,
    this.expands = false,
    this.hasBorder = true,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.fillColor,
    this.onTap,
    this.onEditingComplete,
    this.decoration,
    this.textAlign,
    this.textAlignVertical,
    this.bottomWidget,
    this.inputFormatters,
  }) : assert(
          initialValue == null || controller == null,
          'Cannot provide both a controller and an initial value',
        );
  final String? label;
  final String? hint;
  final String? initialValue;
  final bool obscureText;
  final InputBorder? border;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final TextAlign? textAlign;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? bottomWidget;
  final bool readOnly;
  final bool expands;
  final bool hasBorder;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final Color? fillColor;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      validator: validator,
      builder: (state) {
        return TextFormField(
          enabled: enabled,
          controller: controller,
          initialValue: initialValue,
          onChanged: (val) {
            if (state.hasError) state.reset();
            state.didChange(val);
            onChanged?.call(val);
          },
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          keyboardType: keyboardType,
          cursorWidth: 1,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          obscuringCharacter: '*',
          readOnly: readOnly,
          focusNode: focusNode,
          expands: expands,
          maxLines: maxLines,
          // validator: validator,
          minLines: minLines,
          // maxLength: maxLength,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength),
            ...inputFormatters ?? [],
          ],
          textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
          textAlign: textAlign ?? TextAlign.start,
          onEditingComplete:
              onEditingComplete ?? FocusScope.of(context).nextFocus,
          style: AppStyles.black12Normal,
          decoration: decoration ??
              InputDecoration(
                filled: true,
                isDense: true,
                fillColor: AppColors.white,
                hintText: hint,
                suffixIcon: suffix != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: suffix,
                          ),
                        ],
                      )
                    : null,
                prefixIcon: prefix != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: prefix,
                          ),
                        ],
                      )
                    : null,
                enabled: enabled,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: state.errorText != null
                      ? const BorderSide()
                      : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                alignLabelWithHint:
                    maxLines != null && keyboardType == TextInputType.multiline,
              ),
        );
      },
    );
  }
}
