import 'package:flutter/material.dart';
import 'package:user/presentation/editProfile/views/editProfile_view.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EditProfileView(),
    );
  }
}
