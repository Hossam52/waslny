import 'package:flutter/material.dart';
import 'package:user_app/utils/color_manager.dart';

class GenderCheckBox extends StatelessWidget {
  bool isMale;
  bool isFemale;
  void Function(bool?)? onMaleChanged;
  void Function(bool?)? onFemaleChanged;

  GenderCheckBox({
    required this.isFemale,
    required this.isMale,
    required this.onFemaleChanged,
    required this.onMaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _gender(
            title: 'Male',
            icon: Icons.male,
            isSelected: isMale,
            onChanged: onMaleChanged),
        _gender(
            title: 'Female',
            icon: Icons.female,
            isSelected: isFemale,
            onChanged: onFemaleChanged),
      ],
    );
  }

  Widget _gender(
      {required IconData icon,
      required String title,
      required bool isSelected,
      required void Function(bool? val)? onChanged}) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          onChanged?.call(!isSelected);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : null,
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Row(
            children: [
              Icon(icon),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: Row(
                    children: [
                      Text(title),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        value: isSelected,
                        shape: CircleBorder(),
                        onChanged: onChanged,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
