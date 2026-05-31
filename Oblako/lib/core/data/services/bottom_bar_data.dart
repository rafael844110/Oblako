import 'package:cullinarium/features/chef/presentation/pages/chefs_page.dart';
import 'package:cullinarium/features/home/presentation/pages/home_page.dart';
import 'package:cullinarium/features/profile/presentation/pages/profile_page.dart';
import 'package:cullinarium/features/recipe/presentation/pages/recipe_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget> bottomBarData = {
  'assets/icons/home.png': const HomePage(),
  'assets/icons/hat.png': const ChefsPage(),
  'assets/icons/book.png': const RecipePage(),
  'assets/icons/person.png': const ProfilePage(),
};
