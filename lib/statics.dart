import 'package:flutter/material.dart';
import 'package:app_personas/create.dart';
import 'package:app_personas/hobbies_list.dart';
import 'package:app_personas/list.dart';

class StatisticsWidget extends StatelessWidget {
  final int userCount;
  final List<String> dataList;

  StatisticsWidget({required this.userCount, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User Count: $userCount'),
        SizedBox(height: 10),
        Text('Data List Count: ${dataList.length}'),
      ],
    );
  }
}