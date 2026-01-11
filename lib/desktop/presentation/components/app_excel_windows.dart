import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:open_filex/open_filex.dart';

class AppExcelWindows {
  static Future<File> exportAssetData({
    required List<String> columnLabels,
    required List<Map<String, String>> tableData,
    String fileName = "Export_Assets",
  }) async {
    try {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Simpan Laporan Excel',
        fileName: '$fileName.xlsx',
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (outputFile == null) throw 'An error occurred, please try again';

      if (!outputFile.toLowerCase().endsWith('.xlsx')) {
        outputFile = '$outputFile.xlsx';
      }

      final Excel excel = Excel.createExcel();
      final Sheet sheetObject = excel['Sheet1'];

      CellStyle headerStyle = CellStyle(
        bold: true,
        fontFamily: getFontFamily(FontFamily.Arial),
        backgroundColorHex: ExcelColor.fromHexString('#F1F5F9'),
        fontColorHex: ExcelColor.fromHexString('#1E293B'),
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      );

      for (int i = 0; i < columnLabels.length; i++) {
        var cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
        );
        cell.value = TextCellValue(columnLabels[i]);
        cell.cellStyle = headerStyle;
      }

      for (int rowIdx = 0; rowIdx < tableData.length; rowIdx++) {
        final rowData = tableData[rowIdx];

        for (int colIdx = 0; colIdx < columnLabels.length; colIdx++) {
          String cellValue = rowData.values.elementAt(colIdx);

          var cell = sheetObject.cell(
            CellIndex.indexByColumnRow(
              columnIndex: colIdx,
              rowIndex: rowIdx + 1,
            ),
          );
          cell.value = TextCellValue(cellValue);
        }
      }

      final fileBytes = excel.save();
      if (fileBytes != null) {
        final File file = File(outputFile);
        final res = await file.writeAsBytes(fileBytes);

        return res;
      } else {
        throw 'An error occurred, please try again';
      }
    } catch (e) {
      rethrow;
    }
  }
}
