import 'package:flutter/material.dart';

class WelcomeRegisterButton extends StatelessWidget {
  const WelcomeRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
      child: Container(
        decoration: _buttonBoxDecoration(context, 0xFFced4da, 0xFFFFFFFF),
        child: ElevatedButton(
          onPressed: () {},
          style: _buttonStyle(),
          child: Text(
            'Register'.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(const Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey.withOpacity(0.2);
          } else {
            return Colors.transparent;
          }
        },
      ),
    );
  }

  BoxDecoration _buttonBoxDecoration(
    BuildContext context, [
    int color1 = 0,
    int color2 = 0,
  ]) {
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).colorScheme.secondary;
    if (color1 != 0) {
      c1 = Color(color1);
    }
    if (color2 != 0) {
      c2 = Color(color2);
    }

    return BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 4),
          blurRadius: 5.0,
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.grey.shade300,
        width: 1,
      ),
    );
  }
}
