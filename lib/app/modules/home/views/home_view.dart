import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qlw_parser/app/data/qlw.dart' as qlw;
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('QLW parser'),
        ),
        body: Center(
          child: controller.qlwFile.value == null
              ? const Text('No file selected.')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Header: ${controller.qlwFile.value!.header}'),
                    Text(
                        'Number of records: ${controller.qlwFile.value!.numRecords}'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.qlwFile.value!.records.length,
                        itemBuilder: (context, index) {
                          qlw.Record record =
                              controller.qlwFile.value!.records[index];
                          return ListTile(
                            title: Text(
                                'Record ${index + 1}: ID = ${record.id}, Value = ${record.value}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.pickFile,
          tooltip: 'Pick File',
          child: const Icon(Icons.folder_open),
        ),
      );
    });
  }
}
