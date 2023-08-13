import 'package:flutter/material.dart';

class PasswordLoginInput extends StatelessWidget {
  const PasswordLoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: inputBoxDecorationShaddow(),
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: inputDecoration(
          context,
          lableText: 'Password',
          hintText: 'Enter your password',
        ),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(
    BuildContext context, {
    required String lableText,
    required String hintText,
  }) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 5),
        )
      ],
    );
  }
}
