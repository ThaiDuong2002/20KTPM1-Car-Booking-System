import 'package:flutter/material.dart';

class RatingOption {
  final String label;
  final int value;

  RatingOption({required this.label, required this.value});
}

class RatingWidgets extends StatefulWidget {
  final List<RatingOption> ratingOptions;

  RatingWidgets({required this.ratingOptions});

  @override
  _RatingWidgetsState createState() => _RatingWidgetsState();
}

class _RatingWidgetsState extends State<RatingWidgets> {
  int? selectedRating;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.ratingOptions.length,
      itemBuilder: (context, index) {
        final option = widget.ratingOptions[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ChoiceChip(
            label: Text(option.label),
            selected: selectedRating == option.value,
            onSelected: (isSelected) {
              setState(() {
                if (isSelected) {
                  selectedRating = option.value;
                } else if (selectedRating == option.value) {
                  selectedRating = null;
                }
              });
            },
          ),
        );
      },
    );
  }
}
