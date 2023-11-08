import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/computer_detail_riverpod.dart';
import '../model/computer_detail_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(computerDetailProvider.notifier).getComputerDetail();
    });
  }

  void showDataModal(ComputerDetailModel model) {
    final dateFormat = DateFormat().add_yMEd().add_Hms();
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.0),
        topLeft: Radius.circular(20.0),
      )),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.90,
          minChildSize: 0.90,
          maxChildSize: 0.90,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.grey[400],
                      height: 30.0,
                      width: 325.0,
                      child: const Center(
                        child: Text(
                          'Computer Profile Summary',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text('Hostname: ${model.hostname}'),
                    Text('UUID: ${model.uuid}'),
                    Text('Network: ${model.network}'),
                    Text('Last Update: ${dateFormat.format(model.timeStamp)}'),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Os',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.os),
                            ],
                          ),
                          const SizedBox(width: 50.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Defender',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.defender),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Cpu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.cpu),
                            ],
                          ),
                          const SizedBox(width: 50.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Motherboard',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.motherboard),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Ram',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.ram),
                            ],
                          ),
                          const SizedBox(width: 50.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Storage',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.storage),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'User',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.user),
                            ],
                          ),
                          const SizedBox(width: 50.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Monitor',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.monitor),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey[400],
                                height: 25.0,
                                width: 325.0,
                                child: const Center(
                                  child: Text(
                                    'Browser',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(model.browser),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataList = ref.watch(computerDetailProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Detail'),
      ),
      body: Center(
        child: SizedBox(
          width: 500.0,
          child: RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(computerDetailProvider.notifier)
                  .getComputerDetail();
            },
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    minVerticalPadding: 0.0,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    title: Text(dataList[index].hostname),
                    onTap: () {
                      showDataModal(dataList[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
