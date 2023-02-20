import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/list/list_screen.dart';

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
      if (_selectedIndex == index) {
        final screen = widget.screens[index] as ListScreen;
        screen.scrollToTop();
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.barItems,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
