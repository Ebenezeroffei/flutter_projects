import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './extend_widgets.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.widget, required this.onPressed})
      : super(key: key);

  final Widget widget;
  final Function onPressed;

  factory Button.progress() {
    return Button(
        widget: const CircularProgressIndicator(color: Colors.white),
        onPressed: () {});
  }

  factory Button.text(String text, Function onPressed) {
    return Button(widget: Text(text), onPressed: () => onPressed());
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            elevation: 1,
            fixedSize: const Size(250, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
          child: widget,
        ),
      );
}

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool inputRequired;
  final bool isTextArea;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String helperText;

  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.helperText,
      this.inputRequired = true,
      this.isTextArea = false,
      this.inputFormatters,
      this.validator})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hasText = false;

  void _textEntered(String value) {
    setState(() {
      if (value.isNotEmpty) {
        _hasText = true;
      } else {
        _hasText = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget label = widget.inputRequired
        ? RichText(
            text: TextSpan(
              text: widget.labelText,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black87),
              children: <TextSpan>[
                TextSpan(
                  text: "*",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.red),
                ),
              ],
            ),
          ).leftAlign()
        : Text(
            widget.labelText,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.black87),
          ).leftAlign();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          label,
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: widget.controller,
            onChanged: (value) => _textEntered(value),
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            cursorColor: Colors.black54,
            cursorWidth: 1.0,
            minLines: widget.isTextArea ? 3 : 1,
            maxLines: widget.isTextArea ? 5 : 1,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              suffixIcon: _hasText && !widget.isTextArea
                  ? IconButton(
                      onPressed: () {
                        widget.controller.clear();
                        setState(() {
                          _hasText = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      splashRadius: 15,
                    )
                  : null,
              helperText: widget.helperText,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black54),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(0),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
