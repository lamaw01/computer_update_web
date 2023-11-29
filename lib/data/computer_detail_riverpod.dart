import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/browser_model.dart';
import '../model/computer_detail_model.dart';
import '../model/os_model.dart';
import '../services/dio_service.dart';

final allComputerProvider =
    NotifierProvider<AllComputerDetail, List<ComputerDetailModel>>(
        AllComputerDetail.new);

class AllComputerDetail extends Notifier<List<ComputerDetailModel>> {
  @override
  List<ComputerDetailModel> build() {
    return <ComputerDetailModel>[];
  }

  Future<void> getAllComputerDetail() async {
    try {
      state = await DioService().getAllComputerDetail();
    } catch (e) {
      log(e.toString());
    }
  }

  OsModel checkOsString(int index) {
    final returnValue = OsModel();
    try {
      final firstIndex = state[index];
      String os = firstIndex.os;

      String caption = os.substring(18, os.indexOf('BuildNumber'));
      debugPrint(caption);
      returnValue.caption = caption;

      String buildNumber = os.substring(62, os.indexOf('Version'));
      debugPrint(buildNumber);
      returnValue.buildNumber = buildNumber;

      String version = os.substring(87, os.indexOf('SystemDirectory'));
      debugPrint(version);
      returnValue.version = version;

      debugPrint(firstIndex.updateId);
    } catch (e) {
      debugPrint(e.toString());
    }
    return returnValue;
  }

  String checkDefenderString(int index) {
    String returnValue = '';
    try {
      final firstIndex = state[index];
      String defender = firstIndex.defender;

      String caption =
          defender.substring(28, defender.indexOf('QuickScanSignatureVersion'));
      debugPrint(caption);
      returnValue = caption;
    } catch (e) {
      debugPrint(e.toString());
    }
    return returnValue;
  }

  BrowserModel checkBrowserString(int index) {
    final returnValue = BrowserModel();
    try {
      final firstIndex = state[index];
      String browser = firstIndex.browser;

      String chrome = browser.substring(9, browser.indexOf('MSEdge'));
      debugPrint(chrome);
      returnValue.chrome = chrome;

      String msedge = browser.substring(browser.indexOf('MSEdge') + 9);
      debugPrint(msedge);
      returnValue.msedge = msedge;
    } catch (e) {
      debugPrint(e.toString());
    }
    return returnValue;
  }

  String checkMsOfficeString(int index) {
    String returnValue = '';
    try {
      final firstIndex = state[index];
      String msoffice = firstIndex.msoffice;

      String productversion = msoffice.substring(17);
      debugPrint(productversion);
      returnValue = productversion;
    } catch (e) {
      debugPrint(e.toString());
    }
    return returnValue;
  }

  void downloadExcel() {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];
      var cellStyle = CellStyle(
          backgroundColorHex: '#dddddd',
          fontFamily: getFontFamily(FontFamily.Calibri),
          horizontalAlign: HorizontalAlign.Center,
          fontSize: 10,
          bold: true);

      var column1 = sheetObject.cell(CellIndex.indexByString('A1'));
      column1
        ..value = const TextCellValue('#')
        ..cellStyle = cellStyle;

      var column2 = sheetObject.cell(CellIndex.indexByString('B1'));
      column2
        ..value = const TextCellValue('Station')
        ..cellStyle = cellStyle;

      var column3 = sheetObject.cell(CellIndex.indexByString('C1'));
      column3
        ..value = const TextCellValue('OS')
        ..cellStyle = cellStyle;

      var column4 = sheetObject.cell(CellIndex.indexByString('D1'));
      column4
        ..value = const TextCellValue('Version')
        ..cellStyle = cellStyle;

      var column5 = sheetObject.cell(CellIndex.indexByString('E1'));
      column5
        ..value = const TextCellValue('Build')
        ..cellStyle = cellStyle;

      var column6 = sheetObject.cell(CellIndex.indexByString('F1'));
      column6
        ..value = const TextCellValue('Office')
        ..cellStyle = cellStyle;

      var column7 = sheetObject.cell(CellIndex.indexByString('G1'));
      column7
        ..value = const TextCellValue('Defender')
        ..cellStyle = cellStyle;

      var column8 = sheetObject.cell(CellIndex.indexByString('H1'));
      column8
        ..value = const TextCellValue('Chrome')
        ..cellStyle = cellStyle;

      var column9 = sheetObject.cell(CellIndex.indexByString('I1'));
      column9
        ..value = const TextCellValue('MSEdge')
        ..cellStyle = cellStyle;

      var column10 = sheetObject.cell(CellIndex.indexByString('J1'));
      column10
        ..value = const TextCellValue('Timestamp')
        ..cellStyle = cellStyle;

      final os = checkOsString(160);
      final office = checkMsOfficeString(160);
      final defender = checkDefenderString(160);
      final browser = checkBrowserString(160);
      // const int1 = IntCellValue(1);
      // log(int1.value.toString());

      List<CellValue?> dataList = [
        const IntCellValue(1),
        TextCellValue(state[160].hostname),
        TextCellValue(os.caption),
        TextCellValue(os.version),
        TextCellValue(os.buildNumber),
        TextCellValue(office),
        TextCellValue(defender),
        TextCellValue(browser.chrome),
        TextCellValue(browser.msedge),
        DateCellValue.fromDateTime(state[160].timeStamp),
      ];
      sheetObject.appendRow(dataList);

      // sheetObject.appendRow([
      //   const IntCellValue(1),
      //   TextCellValue(state[160].hostname),
      //   TextCellValue(os.caption),
      //   TextCellValue(os.version),
      //   TextCellValue(os.buildNumber),
      //   TextCellValue(office),
      //   TextCellValue(defender),
      //   TextCellValue(browser.chrome),
      //   TextCellValue(browser.msedge),
      //   TextCellValue(DateTime.now().toString()),
      // ]);

      // for (int i = 0; i < state.length; i++) {
      //   final os = checkOsString(i);
      //   final office = checkMsOfficeString(i);
      //   final defender = checkDefenderString(i);
      //   final browser = checkBrowserString(i);

      //   List<CellValue> dataList = [
      //     IntCellValue(i + 1),
      //     TextCellValue(state[i].hostname),
      //     TextCellValue(os.caption),
      //     TextCellValue(os.version),
      //     TextCellValue(os.buildNumber),
      //     TextCellValue(office),
      //     TextCellValue(defender),
      //     TextCellValue(browser.chrome),
      //     TextCellValue(browser.msedge),
      //     DateCellValue.fromDateTime(state[i].timeStamp),
      //   ];
      //   sheetObject.appendRow(dataList);
      // }

      // var cellStyleData = CellStyle(
      //   fontFamily: getFontFamily(FontFamily.Calibri),
      //   horizontalAlign: HorizontalAlign.Center,
      //   fontSize: 9,
      // );
      // var rC = 0;

      // for (int i = 0; i < sortedRawHistory.length; i++) {
      //   for (int j = 0; j < sortedRawHistory[i].logs.length; j++) {
      //     rC = rC + 1;
      //     List<dynamic> dataList = [
      //       sortedRawHistory[i].employeeId,
      //       fullNameHistory(sortedRawHistory[i]),
      //       _dateYmd.format(sortedRawHistory[i].date),
      //       dateFormat12or24Web(sortedRawHistory[i].logs[j].timeStamp),
      //       sortedRawHistory[i].logs[j].logType,
      //     ];
      //     sheetObject.appendRow(dataList);
      //     sheetObject.setColWidth(0, 7.0);
      //     sheetObject.setColWidth(1, 22.0);
      //     sheetObject.setColWidth(2, 10.0);
      //     sheetObject.setColWidth(3, 10.1);
      //     sheetObject.setColWidth(4, 8.1);
      //     sheetObject.updateCell(
      //       CellIndex.indexByColumnRow(
      //         columnIndex: 0,
      //         rowIndex: rC,
      //       ),
      //       sortedRawHistory[i].employeeId,
      //       cellStyle: cellStyleData,
      //     );
      //     sheetObject.updateCell(
      //       CellIndex.indexByColumnRow(
      //         columnIndex: 1,
      //         rowIndex: rC,
      //       ),
      //       fullNameHistory(sortedRawHistory[i]),
      //       cellStyle: cellStyleData,
      //     );
      //     sheetObject.updateCell(
      //       CellIndex.indexByColumnRow(
      //         columnIndex: 2,
      //         rowIndex: rC,
      //       ),
      //       _dateYmd.format(sortedRawHistory[i].date),
      //       cellStyle: cellStyleData,
      //     );
      //     sheetObject.updateCell(
      //       CellIndex.indexByColumnRow(
      //         columnIndex: 3,
      //         rowIndex: rC,
      //       ),
      //       dateFormat12or24Web(sortedRawHistory[i].logs[j].timeStamp),
      //       cellStyle: cellStyleData,
      //     );
      //     sheetObject.updateCell(
      //       CellIndex.indexByColumnRow(
      //         columnIndex: 4,
      //         rowIndex: rC,
      //       ),
      //       sortedRawHistory[i].logs[j].logType,
      //       cellStyle: cellStyleData,
      //     );
      //   }
      // }
      excel.save(fileName: 'arriba_computer_detail.xlsx');
    } catch (e) {
      debugPrint('$e exportRawLogsExcel');
    }
  }
}
