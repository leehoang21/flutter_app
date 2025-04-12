import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldConstants {
  static const double contentPaddingHorizontal = 18;
  static const double contentPaddingVertical = 9;
}

class TextFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? initValue;
  final Color? color;
  final double? height;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validate;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign? textAlign;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? readOnly;
  final bool? enabled;
  final int? maxLines;
  final Widget? counter;

  const TextFieldWidget({
    super.key,
    this.enabled,
    this.labelText,
    this.hintText,
    this.initValue,
    this.color,
    this.height,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.validate,
    this.onSaved,
    this.onEditingComplete,
    this.onTap,
    this.autovalidateMode,
    this.inputFormatter,
    this.textAlign,
    this.textCapitalization,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.readOnly,
    this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      readOnly: readOnly ?? false,
      enabled: enabled,
      controller: controller,
      initialValue: initValue,
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      textAlign: textAlign ?? TextAlign.start,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      obscureText: obscureText ?? false,
      style: textStyle?.copyWith(
        color: enabled == false
            ? textStyle?.color?.withOpacity(0.5)
            : textStyle?.color,
      ),
      onSaved: onSaved,
      validator: validate,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatter,
      keyboardType: keyboardType,
      scrollPadding: const EdgeInsets.symmetric(vertical: 9),
      decoration: InputDecoration(
        counter: counter,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TextFieldConstants.contentPaddingHorizontal,
          vertical: TextFieldConstants.contentPaddingVertical,
        ),
        labelText: labelText,
        labelStyle: textStyle,
        hintText: hintText,
        hintStyle: textStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}

class SecurityTextFieldWidget extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initValue;
  final Color? color;
  final double? height;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validate;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign? textAlign;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool? enabled;

  const SecurityTextFieldWidget({
    super.key,
    this.enabled,
    this.labelText,
    this.hintText,
    this.initValue,
    this.color,
    this.height,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.validate,
    this.onSaved,
    this.onEditingComplete,
    this.onTap,
    this.autovalidateMode,
    this.inputFormatter,
    this.textAlign,
    this.textCapitalization,
    this.keyboardType,
    this.readOnly,
  });

  @override
  State<SecurityTextFieldWidget> createState() =>
      _SecurityTextFieldWidgetState();
}

class _SecurityTextFieldWidgetState extends State<SecurityTextFieldWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      enabled: widget.enabled,
      controller: widget.controller,
      initialValue: widget.initValue,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      textAlign: widget.textAlign ?? TextAlign.start,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      obscureText: obscureText,
      style: widget.textStyle,
      onSaved: widget.onSaved,
      validator: widget.validate,
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: widget.inputFormatter,
      keyboardType: widget.keyboardType,
      scrollPadding: const EdgeInsets.symmetric(vertical: 9),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TextFieldConstants.contentPaddingHorizontal,
          vertical: TextFieldConstants.contentPaddingVertical,
        ),
        labelText: widget.labelText,
        labelStyle: widget.textStyle,
        hintText: widget.hintText,
        hintStyle: widget.textStyle,
        prefixIcon: widget.prefixIcon,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              widget.suffixIcon ?? const SizedBox(),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
        filled: true,
        errorMaxLines: 4,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
