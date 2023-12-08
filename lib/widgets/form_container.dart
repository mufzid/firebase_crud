import 'package:flutter/material.dart';

class FromCondainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldkey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labeltext;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FromCondainerWidget(
      {this.controller,
      this.fieldkey,
      this.isPasswordField,
      this.hintText,
      this.labeltext,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType});

  @override
  State<FromCondainerWidget> createState() => _FromCondainerWidgetState();
}

class _FromCondainerWidgetState extends State<FromCondainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(context) {
    return Container(
      // height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.40),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldkey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.black45),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.isPasswordField == true
                  ? Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText == false ? Colors.blue : Colors.grey,
                    )
                  : const Text(' '),
            )),
      ),
    );
  }
}
