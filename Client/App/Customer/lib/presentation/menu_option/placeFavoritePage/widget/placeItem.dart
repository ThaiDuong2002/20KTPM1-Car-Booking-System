import 'package:flutter/material.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/widget/custom_text.dart';

class ExpandableContainer extends StatefulWidget {
  final Map place;

  const ExpandableContainer({super.key, required this.place});

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // color: Colors.green,
      duration: const Duration(milliseconds: 200),
      height: isExpanded ? 140 : 110, // Adjust heights according to your needs
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.bookmark),
                            const SizedBox(width: 10),
                            // Use your TextCustom
                            // widget here

                            TextCustom(
                                text: widget.place['name'],
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w700)
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Use your TextCustom widget here
                        TextCustom(
                            text: widget.place['address'],
                            color: COLOR_TEXT_MAIN,
                            fontSize: FONT_SIZE_NORMAL,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: const Icon(Icons.arrow_circle_down_rounded,
                          color: Colors.black)),
                ],
              ),
            ),
            if (isExpanded)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR_BLUE_MAIN,
                      ),
                      onPressed: () {
                        // Perform your 'Edit' action here
                      },
                      child: const TextCustom(
                          text: "Chỉnh sửa",
                          color: Colors.white,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR_BLUE_MAIN,
                      ),
                      onPressed: () {
                        // Perform your 'Delete' action here
                      },
                      child: const TextCustom(
                          text: "Xoá",
                          color: Colors.white,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
