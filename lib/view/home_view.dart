import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'all_computer.dart';
import 'firstfloor_view.dart';
import 'secondfloor_view.dart';
import 'update_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  SideMenuController sideMenu = SideMenuController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      SideMenuItem(
        title: 'All Computer',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        icon: const Icon(Icons.desktop_windows),
      ),
      SideMenuItem(
        title: '1st Floor',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        icon: const Icon(Icons.desktop_windows_outlined),
      ),
      SideMenuItem(
        title: '2nd Floor',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        icon: const Icon(Icons.desktop_windows_outlined),
      ),
      SideMenuItem(
        title: 'Update',
        onTap: (index, _) async {
          sideMenu.changePage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        icon: const Icon(Icons.update),
      ),
    ];

    final menuPages = <Widget>[
      const AllComputerView(),
      const FirstFloorView(),
      const SecondFloorView(),
      const UpdateView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Detail'),
      ),
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            onDisplayModeChanged: (mode) {},
            items: menuItems,
            style: SideMenuStyle(
              backgroundColor: Colors.grey[300],
              itemInnerSpacing: 16.0,
              iconSize: 16.0,
              itemOuterPadding: EdgeInsets.zero,
              openSideMenuWidth: 160.0,
            ),
          ),
          Expanded(
            child: menuPages.elementAt(_currentIndex),
          ),
        ],
      ),
    );
  }
}
