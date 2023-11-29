import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/computer_detail_riverpod.dart';
import 'all_computer.dart';
import 'firstfloor_view.dart';
import 'secondfloor_view.dart';
import 'thirdfloor_view.dart';
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
  Widget build(BuildContext context) {
    final menuItems = [
      SideMenuItem(
        title: 'All Computer',
        onTap: (index, _) {
          setState(() {
            _currentIndex = index;
            sideMenu.changePage(index);
          });
        },
        icon: const Icon(Icons.desktop_windows),
      ),
      SideMenuItem(
        title: '1st Floor',
        onTap: (index, _) {
          setState(() {
            _currentIndex = index;
            sideMenu.changePage(index);
          });
        },
        icon: const Icon(Icons.desktop_windows_outlined),
      ),
      SideMenuItem(
        title: '2nd Floor',
        onTap: (index, _) {
          setState(() {
            _currentIndex = index;
            sideMenu.changePage(index);
          });
        },
        icon: const Icon(Icons.desktop_windows_rounded),
      ),
      SideMenuItem(
        title: '3rd Floor',
        onTap: (index, _) {
          setState(() {
            _currentIndex = index;
            sideMenu.changePage(index);
          });
        },
        icon: const Icon(Icons.desktop_windows_sharp),
      ),
      SideMenuItem(
        title: 'Update',
        onTap: (index, _) {
          setState(() {
            _currentIndex = index;
            sideMenu.changePage(index);
          });
        },
        icon: const Icon(Icons.update),
      ),
    ];

    final menuPages = <Widget>[
      const AllComputerView(),
      const FirstFloorView(),
      const SecondFloorView(),
      const ThirdFloorView(),
      const UpdateView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Detail'),
        actions: [
          InkWell(
            onTap: () {
              // instance.exportExcel();
              final allComputer = ref.read(allComputerProvider.notifier);
              allComputer.downloadExcel();
            },
            child: Ink(
              height: 50.0,
              width: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.orange[300],
              ),
              padding: const EdgeInsets.all(5.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                  Text(
                    'Export excel',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            // onDisplayModeChanged: (mode) {},
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
