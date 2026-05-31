import 'package:flutter/material.dart';
import '../../config/theme.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.015,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: AppColors.backgroundDark,
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 16.0),
              hintText: 'Search anime, manga, movies...',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
