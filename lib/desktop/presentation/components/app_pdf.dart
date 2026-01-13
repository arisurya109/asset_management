import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AppPdf {
  static void showPdfPreviewDialog(
    BuildContext context,
    Preparation preparation,
    List<PreparationDetail> preparationDetails,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 600,
            height: 800,
            child: Column(
              children: [
                // Header dialog
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Preview PDF',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                ),

                // Body: PDF Preview
                Expanded(
                  child: PdfPreview(
                    actionBarTheme: PdfActionBarTheme(height: 50),
                    initialPageFormat: PdfPageFormat.a4,
                    canDebug: false,
                    enableScrollToPage: true,
                    canChangeOrientation: false,
                    canChangePageFormat: false,
                    build: (format) =>
                        AppPdf.outgoingLetter(preparation, preparationDetails),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<Uint8List> outgoingLetter(
    Preparation preparation,
    List<PreparationDetail> preparationDetails,
  ) async {
    final pdf = pw.Document();

    final img = await rootBundle.load(Assets.logoPdf);
    final imageBytes = img.buffer.asUint8List();

    const tableHeaders = ['NO', 'BARANG', 'TYPE', 'ASSET CODE', 'QTY'];
    pdf.addPage(
      pw.MultiPage(
        orientation: pw.PageOrientation.portrait,
        margin: pw.EdgeInsets.fromLTRB(32, 24, 32, 32),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  height: 100,
                  width: 200,
                  child: pw.Image(pw.MemoryImage(imageBytes)),
                ),
                pw.SizedBox(width: 24),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'PT. DUTA INTIDAYA\n(WAREHOUSE BITUNG)',
                      style: pw.TextStyle(
                        fontSize: 18,
                        lineSpacing: 3,
                        letterSpacing: 3,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'Komp. Pergudangan Nihon Seima Blok. H\nJl. Gatot Subroto No. 8 Kel. Kadujaya - Bitung\nKab. Tangerang - Banten (021) 5971 4382',
                      style: pw.TextStyle(lineSpacing: 3, letterSpacing: 1),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 24),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'SURAT KELUAR ASSET IT',
                    style: pw.TextStyle(
                      fontSize: 12,
                      lineSpacing: 3,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Row(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'NOMOR',
                          style: pw.TextStyle(
                            lineSpacing: 3,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Text(
                          'TANGGAL',
                          style: pw.TextStyle(
                            lineSpacing: 3,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 6),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          ':',
                          style: pw.TextStyle(
                            lineSpacing: 3,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(
                            lineSpacing: 3,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 6),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'SK-${preparation.code}',
                          style: pw.TextStyle(
                            lineSpacing: 3,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Text(
                          DateFormat(
                            'dd MMMM y',
                            'id_ID',
                          ).format(DateTime.now()),
                          style: pw.TextStyle(
                            lineSpacing: 3,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.TableHelper.fromTextArray(
              border: pw.TableBorder.all(),
              cellAlignment: pw.Alignment.centerLeft,
              cellPadding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              headerHeight: 25,
              cellHeight: 25,
              cellAlignments: {
                0: pw.Alignment.center,
                1: pw.Alignment.center,
                2: pw.Alignment.center,
                3: pw.Alignment.center,
                4: pw.Alignment.center,
              },
              headerStyle: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
              cellStyle: const pw.TextStyle(fontSize: 9),
              headers: tableHeaders,
              data: List<List<String>>.generate(
                preparationDetails.length,
                (row) => List<String>.generate(tableHeaders.length, (col) {
                  if (col == 0) {
                    return (row + 1).toString();
                  } else if (col == 1) {
                    return preparationDetails[row].category ?? '';
                  } else if (col == 2) {
                    return preparationDetails[row].model ?? '';
                  } else if (col == 3) {
                    return preparationDetails[row].assetCode ?? '';
                  } else if (col == 4) {
                    return preparationDetails[row].quantity.toString();
                  }
                  return '';
                }),
              ),
            ),
            pw.SizedBox(height: 24),
            pw.Column(
              children: [
                pw.Container(
                  width: double.maxFinite,
                  padding: pw.EdgeInsets.all(5),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Text('Catatan : '),
                ),
                pw.Container(
                  width: double.maxFinite,
                  height: 60,
                  padding: pw.EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(),
                      left: pw.BorderSide(),
                      right: pw.BorderSide(),
                    ),
                  ),
                  child: pw.Text(
                    preparation.notes ?? '',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 24),
            pw.Container(
              height: 80,
              padding: pw.EdgeInsets.symmetric(horizontal: 16),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text('Yang Mengeluarkan'),
                      pw.Spacer(),
                      // pw.Text(preparation.created!.toCapitalize()),
                      pw.Text('TESTING'),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('Security'),
                      pw.Spacer(),
                      pw.Text('(                            )'),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('Disetujui'),
                      pw.Spacer(),
                      // pw.Text(preparation.approved!.toCapitalize()),
                      pw.Text('TESTING'),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }
}
