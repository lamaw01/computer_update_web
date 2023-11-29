import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../data/computer_detail_riverpod.dart';

class DetailColumn extends ConsumerWidget {
  const DetailColumn({super.key, required this.title, required this.data});
  final String title;
  final String data;
  // final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        // final dataList = ref.read(allComputerProvider.notifier);
        // dataList.checkOsString();
        // dataList.checkDefenderString();
        // dataList.checkBrowserString();
        // dataList.checkMsOfficeString();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey[400],
            height: 25.0,
            width: 325.0,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(data),
        ],
      ),
    );
  }
}
