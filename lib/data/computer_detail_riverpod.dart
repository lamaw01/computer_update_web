import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../model/browser_model.dart';
import '../model/computer_detail_model.dart';
import '../model/os_model.dart';
import '../services/dio_service.dart';
import 'firstfloor_riverpod.dart';
import 'second_floor_riverpod.dart';
// await ref.read(allComputerProvider.notifier).getAllComputerDetail();

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
      // debugPrint(caption);
      returnValue.caption = caption;

      String buildNumber = os.substring(62, os.indexOf('Version'));
      // debugPrint(buildNumber);
      returnValue.buildNumber = buildNumber;

      String version = os.substring(87, os.indexOf('SystemDirectory'));
      // debugPrint(version);
      returnValue.version = version;

      // debugPrint(firstIndex.updateId);
    } catch (e) {
      debugPrint("$e checkOsString");
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
      // debugPrint(caption);
      returnValue = caption;
    } catch (e) {
      debugPrint("$e checkDefenderString");
      final firstIndex = state[index];
      String defender = firstIndex.defender;
      String caption = defender.substring(28);
      returnValue = caption;
    }
    return returnValue;
  }

  BrowserModel checkBrowserString(int index) {
    final returnValue = BrowserModel();
    try {
      final firstIndex = state[index];
      String browser = firstIndex.browser;

      String chrome = browser.substring(9, browser.indexOf('MSEdge'));
      // debugPrint(chrome);
      returnValue.chrome = chrome;

      String msedge = browser.substring(browser.indexOf('MSEdge') + 9);
      // debugPrint(msedge);
      returnValue.msedge = msedge;
    } catch (e) {
      debugPrint("$e checkBrowserString");
    }
    return returnValue;
  }

  String checkMsOfficeString(int index) {
    String returnValue = '';
    try {
      final firstIndex = state[index];
      String msoffice = firstIndex.msoffice;

      String productversion = msoffice.substring(17);
      // debugPrint(productversion);
      returnValue = productversion;
    } catch (e) {
      // debugPrint("$e checkMsOfficeString");
      returnValue = '14.0.4734.1000';
    }
    return returnValue;
  }

  void downloadExcel() {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];
      var cellStyle = CellStyle(
          backgroundColorHex: '#000000',
          fontFamily: getFontFamily(FontFamily.Calibri),
          horizontalAlign: HorizontalAlign.Center,
          fontSize: 10,
          fontColorHex: '#dddddd',
          bold: true);

      var column1 = sheetObject.cell(CellIndex.indexByString('A1'));
      column1
        ..value = const TextCellValue('Station')
        ..cellStyle = cellStyle;

      var column2 = sheetObject.cell(CellIndex.indexByString('B1'));
      column2
        ..value = const TextCellValue('OS')
        ..cellStyle = cellStyle;

      var column3 = sheetObject.cell(CellIndex.indexByString('C1'));
      column3
        ..value = const TextCellValue('Version')
        ..cellStyle = cellStyle;

      var column4 = sheetObject.cell(CellIndex.indexByString('D1'));
      column4
        ..value = const TextCellValue('Build')
        ..cellStyle = cellStyle;

      var column5 = sheetObject.cell(CellIndex.indexByString('E1'));
      column5
        ..value = const TextCellValue('Office')
        ..cellStyle = cellStyle;

      var column6 = sheetObject.cell(CellIndex.indexByString('F1'));
      column6
        ..value = const TextCellValue('Defender')
        ..cellStyle = cellStyle;

      var column7 = sheetObject.cell(CellIndex.indexByString('G1'));
      column7
        ..value = const TextCellValue('Chrome')
        ..cellStyle = cellStyle;

      var column8 = sheetObject.cell(CellIndex.indexByString('H1'));
      column8
        ..value = const TextCellValue('MSEdge')
        ..cellStyle = cellStyle;

      var column9 = sheetObject.cell(CellIndex.indexByString('I1'));
      column9
        ..value = const TextCellValue('Timestamp')
        ..cellStyle = cellStyle;

      ref.read(firstFloorProvider.notifier).sortFirstFloorComputerDetail();
      ref.read(secondFloorProvider.notifier).sortSecondFloorComputerDetail();

      final arribaComputers = <ComputerDetailModel>[];
      arribaComputers.addAll(ref.read(firstFloorProvider));
      arribaComputers.addAll(ref.read(secondFloorProvider));

      for (int i = 0; i < arribaComputers.length; i++) {
        OsModel? os;
        String office = '';
        String defender = '';
        BrowserModel? browser;

        try {
          os = checkOsString(i);
          office = checkMsOfficeString(i);
          defender = checkDefenderString(i);
          browser = checkBrowserString(i);
        } catch (e) {
          debugPrint('$e');
        }
        // final os = checkOsString(i);
        // final office = checkMsOfficeString(i);
        // final defender = checkDefenderString(i);
        // final browser = checkBrowserString(i);
        final dateFormat = DateFormat('yyyy-MM-dd hh:mm');

        List<CellValue?> dataList = [
          TextCellValue(state[i].hostname),
          TextCellValue(os?.caption ?? ''),
          TextCellValue(os?.version ?? ''),
          TextCellValue(os?.buildNumber ?? ''),
          TextCellValue(office),
          TextCellValue(defender),
          TextCellValue(browser?.chrome ?? ''),
          TextCellValue(browser?.msedge ?? ''),
          TextCellValue(dateFormat.format(state[i].timeStamp)),
        ];
        sheetObject.appendRow(dataList);
        sheetObject.setColumnWidth(0, 14.0);
        sheetObject.setColumnWidth(1, 25.0);
        sheetObject.setColumnWidth(2, 14.5);
        sheetObject.setColumnWidth(3, 13.0);
        sheetObject.setColumnWidth(4, 18.5);
        sheetObject.setColumnWidth(5, 17.5);
        sheetObject.setColumnWidth(6, 19.5);
        sheetObject.setColumnWidth(7, 19.0);
        sheetObject.setColumnWidth(8, 21.5);
      }

      for (int x = 0; x < 9; x++) {
        for (int y = 1; y < arribaComputers.length + 1; y++) {
          sheetObject
              .cell(
                CellIndex.indexByColumnRow(columnIndex: x, rowIndex: y),
              )
              .cellStyle = CellStyle(
            fontFamily: getFontFamily(FontFamily.Calibri),
            horizontalAlign: HorizontalAlign.Center,
            fontSize: 10,
          );
        }
      }
      excel.save(fileName: 'arriba_computer_detail.xlsx');
    } catch (e) {
      debugPrint('$e exportRawLogsExcel');
    }
  }
}
