import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/computer_detail_riverpod.dart';
import '../data/search_computer_riverpod.dart';
import 'all_computer.dart';
import 'firstfloor_view.dart';
import 'others_view.dart';
import 'search_view.dart';
import 'secondfloor_view.dart';
import 'department_view.dart';
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
  final searchController = TextEditingController();
  final _isSearching = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        _isSearching.value = false;
      } else {
        _isSearching.value = true;
      }
    });
  }

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
        title: 'Others',
        onTap: (index, _) {
          setState(() {
            _currentIndex = index;
            sideMenu.changePage(index);
          });
        },
        icon: const Icon(Icons.desktop_mac_outlined),
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
      SideMenuItem(
        title: 'Department',
        onTap: (index, _) {
          setState(() {
            _currentIndex = index;
            sideMenu.changePage(index);
          });
        },
        icon: const Icon(Icons.house),
      ),
    ];

    final menuPages = <Widget>[
      const AllComputerView(),
      const FirstFloorView(),
      const SecondFloorView(),
      const ThirdFloorView(),
      const OthersView(),
      const UpdateView(),
      const DepartmentView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Detail'),
        flexibleSpace: _currentIndex != 5
            ? FlexibleSpaceBar(
                centerTitle: true,
                title: SizedBox(
                  width: 200.0,
                  // height: 100.0,
                  child: Center(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.black,
                      controller: searchController,
                      onChanged: (value) async {
                        await ref
                            .read(searchComputerProvider.notifier)
                            .searchComputer(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search computer..',
                        isDense: false,
                        hintStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(allComputerProvider.notifier).downloadExcel();
            },
            icon: const Icon(
              Icons.file_download_outlined,
              color: Colors.white,
            ),
            splashRadius: 30.0,
            iconSize: 30.0,
            tooltip: 'Download Arriba Excel',
          ),
          // InkWell(
          //   onTap: () {
          //     // instance.exportExcel();
          //     final allComputer = ref.read(allComputerProvider.notifier);
          //     allComputer.downloadExcel();
          //   },
          //   child: Ink(
          //     height: 50.0,
          //     width: 125.0,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5.0),
          //       color: Colors.orange[300],
          //     ),
          //     padding: const EdgeInsets.all(5.0),
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.download,
          //           color: Colors.white,
          //         ),
          //         Text(
          //           'Export excel',
          //           style: TextStyle(
          //             fontSize: 16.0,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
            // child: menuPages.elementAt(_currentIndex),
            child: ValueListenableBuilder(
              valueListenable: _isSearching,
              builder: (context, value, child) {
                if (value) {
                  return const SearchView();
                }
                return menuPages.elementAt(_currentIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}
