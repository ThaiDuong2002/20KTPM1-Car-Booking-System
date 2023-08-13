import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/constant/color.dart';
import '../../../app/constant/size.dart';
import '../../widget/custom_text.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  ImageProvider? _avatarImage;
  bool _isImageAdded = false; // biến trạng thái mới
  @override
  void initState() {
    super.initState();
    _avatarImage = const AssetImage("assets/images/icons/icon_avatar.png");
  }

  Future<void> _updateAvatarImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _avatarImage = FileImage(File(image.path));
        _isImageAdded = true; // cập nhật trạng thái
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              alignment: const Alignment(-0.2, 1), // move icon a bit to the left
            );
          },
        ),
        backgroundColor: Colors.white,
        title: const TextCustom(
          text: "Chỉnh sửa hồ sơ",
          color: COLOR_TEXT_BLACK,
          fontSize: FONT_SIZE_LARGE,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextCustom(
              text: "Ảnh đại diện",
              color: COLOR_TEXT_BLACK,
              fontSize: FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: _avatarImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: _updateAvatarImage,
                      child: TextCustom(
                        text: _isImageAdded ? "Thay ảnh" : "Thêm ảnh",
                        color: COLOR_TEXT_BLACK,
                        fontSize: FONT_SIZE_NORMAL,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const TextCustom(
                      text:
                          "Hãy chọn ảnh đẹp nhất vì mọi người có thể sẽ thấy ảnh này",
                      color: COLOR_TEXT_BLACK,
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Wrap(children: [
                TextCustom(
                  text: "Tên",
                  color: COLOR_TEXT_BLACK,
                  fontSize: FONT_SIZE_NORMAL,
                  fontWeight: FontWeight.w600,
                ),
                TextCustom(
                  text: " *",
                  color: Colors.red,
                  fontSize: FONT_SIZE_NORMAL,
                  fontWeight: FontWeight.w600,
                ),
              ]),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: COLOR_TEXT_BLACK, width: 1),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập tên của bạn",
                    hintStyle: TextStyle(
                      color: COLOR_TEXT_BLACK.withOpacity(0.5),
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Wrap(children: [
                TextCustom(
                  text: "Số điện thoại",
                  color: COLOR_TEXT_BLACK,
                  fontSize: FONT_SIZE_NORMAL,
                  fontWeight: FontWeight.w600,
                ),
                TextCustom(
                  text: " *",
                  color: Colors.red,
                  fontSize: FONT_SIZE_NORMAL,
                  fontWeight: FontWeight.w600,
                ),
              ]),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: COLOR_TEXT_BLACK, width: 1),
                ),
                child: Row(children: [
                  TextCustom(
                    text: "+84",
                    color: COLOR_TEXT_BLACK.withOpacity(0.5),
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập số điện thoại của bạn",
                        hintStyle: TextStyle(
                          color: COLOR_TEXT_BLACK.withOpacity(0.5),
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              const Wrap(
                children: [
                  TextCustom(
                    text: "Email",
                    color: COLOR_TEXT_BLACK,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600,
                  ),
                  TextCustom(
                    text: " *",
                    color: Colors.red,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: COLOR_TEXT_BLACK, width: 1),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập email của bạn",
                    hintStyle: TextStyle(
                      color: COLOR_TEXT_BLACK.withOpacity(0.5),
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
