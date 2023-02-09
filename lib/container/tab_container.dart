import 'package:flutter/material.dart';

class TabContainer extends StatefulWidget {
  final List<Widget> screens;

  final List<BottomNavigationBarItem> barItems;

  const TabContainer({
    super.key,
    required this.screens,
    required this.barItems,
  });

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: widget.barItems,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
