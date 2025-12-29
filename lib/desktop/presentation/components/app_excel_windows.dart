import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';

class AppExcelWindows {
  static Future<void> exportAssetData({
    required List<String> columnLabels,
    required List<Map<String, String>> tableData,
    String fileName = "Export_Assets",
  }) async {
    try {
      // 1. Munculkan Dialog Simpan File Windows
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Simpan Laporan Excel',
        fileName: '$fileName.xlsx',
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      // Jika user menekan 'Cancel'
      if (outputFile == null) return;

      // Pastikan path memiliki ekstensi .xlsx
      if (!outputFile.toLowerCase().endsWith('.xlsx')) {
        outputFile = '$outputFile.xlsx';
      }

      // 2. Inisialisasi Excel
      final Excel excel = Excel.createExcel();
      final Sheet sheetObject = excel['Sheet1'];

      // 3. Styling Header
      CellStyle headerStyle = CellStyle(
        bold: true,
        fontFamily: getFontFamily(FontFamily.Arial),
        backgroundColorHex: ExcelColor.fromHexString(
          '#F1F5F9',
        ), // Warna Abu-abu muda
        fontColorHex: ExcelColor.fromHexString('#1E293B'),
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      );

      // 4. Tulis Header
      for (int i = 0; i < columnLabels.length; i++) {
        var cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
        );
        cell.value = TextCellValue(columnLabels[i]);
        cell.cellStyle = headerStyle;
      }

      // 5. Tulis Data (Isi Tabel)
      for (int rowIdx = 0; rowIdx < tableData.length; rowIdx++) {
        final rowData = tableData[rowIdx];

        // Loop berdasarkan label kolom untuk memastikan data masuk ke kolom yang benar
        for (int colIdx = 0; colIdx < columnLabels.length; colIdx++) {
          // Kita butuh key dari data yang sesuai dengan kolom saat ini
          // Tips: Pastikan urutan values di Map sesuai dengan urutan Label
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

      // 6. Proses Penyimpanan ke Drive Windows
      final fileBytes = excel.save();
      if (fileBytes != null) {
        final File file = File(outputFile);
        await file.writeAsBytes(fileBytes);

        // 7. Berikan opsi untuk langsung membuka file setelah selesai
        await OpenFilex.open(outputFile);
      }
    } catch (e) {
      // Handle error jika file sedang terbuka (locked) atau akses ditolak
      rethrow;
    }
  }
}
