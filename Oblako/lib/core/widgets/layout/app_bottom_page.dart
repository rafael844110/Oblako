import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/data/services/bottom_bar_data.dart';
import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppBottomPage extends StatefulWidget {
  const AppBottomPage({super.key, this.pageIndex = 0});

  final int pageIndex;

  @override
  State<AppBottomPage> createState() => _AppBottomBarSmPage();
}

class _AppBottomBarSmPage extends State<AppBottomPage> {
  late int _selectedIndex;
  late final List<String> _iconPaths;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;

    _iconPaths = bottomBarData.keys.toList();
    _pages = bottomBarData.values.toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColors,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            color: Colors.white,
            child: BottomNavigationBar(
              items: List.generate(_iconPaths.length, (index) {
                final iconPath = _iconPaths[index];
                final isSelected = _selectedIndex == index;
                return BottomNavigationBarItem(
                  icon: Image.asset(
                    iconPath,
                    width: 30,
                    height: 30,
                    color: isSelected ? AppColors.primary : Colors.grey,
                  ),
                  label: '',
                );
              }),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
