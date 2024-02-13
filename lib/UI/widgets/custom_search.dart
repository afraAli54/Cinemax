import 'package:cinemax/style_guide/app_colors.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search a title',
          labelStyle: TextStyle(color: AppColors.textDarkGrey),
          filled: true,
          fillColor: AppColors.primarySoft,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          prefixIcon: Icon(Icons.search, color: AppColors.textDarkGrey),
          prefixIconConstraints: BoxConstraints(minWidth: 48, minHeight: 48),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 1,
                height: 24,
                color: AppColors.textGrey,
              ),
              IconButton(
                icon: Icon(Icons.more_horiz, color: AppColors.textWhite),
                onPressed: () {},
              ),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
