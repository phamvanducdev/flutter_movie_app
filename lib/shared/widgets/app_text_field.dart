import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? textLabel;
  final String? textDescription;
  final String? textHint;
  final String? textError;
  final Color? colorBackground;
  final Color? colorText;
  final Color? colorHint;
  final Color? colorError;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;

  const AppTextField({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.textLabel,
    this.textDescription,
    this.textHint,
    this.textError,
    this.colorBackground,
    this.colorText,
    this.colorHint,
    this.colorError,
    this.textInputType,
    this.textInputAction,
    this.maxLines,
    this.maxLength,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  var _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.textInputType == TextInputType.visiblePassword;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.colorText ?? Colors.black;
    final hintColor = widget.colorHint ?? Colors.grey;
    final errorColor = widget.colorError ?? Colors.red;
    final backgroundColor = widget.colorBackground ?? Colors.transparent;

    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.textLabel != null
                ? Text(
                    '${widget.textLabel}',
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                  )
                : Container(),
            widget.textDescription != null
                ? Text(
                    '${widget.textDescription}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                  )
                : Container(),
            TextField(
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: const TextStyle(fontSize: 16.0).copyWith(color: textColor),
              cursorColor: hintColor,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
                hintText: widget.textHint,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0).copyWith(color: hintColor),
                errorText: widget.textError,
                errorStyle: const TextStyle(color: Colors.grey, fontSize: 16.0).copyWith(color: errorColor),
                filled: true,
                fillColor: backgroundColor,
                suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
                suffixIcon: widget.textInputType == TextInputType.visiblePassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: textColor,
                        ),
                      )
                    : null,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: hintColor, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor, width: 1.2),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: errorColor, width: 1.0),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: errorColor, width: 1.2),
                ),
              ),
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
            ),
          ],
        ),
      ),
    );
  }
}
