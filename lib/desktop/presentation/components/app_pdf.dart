import 'dart:convert';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_document.dart';
import 'package:asset_management/domain/entities/preparation/preparation_document_item.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

enum LetterType { outgoing, receipt, handover }

class AppPdf {
  static Future<pw.MemoryImage?> _fetchImage(String base64String) async {
    if (!base64String.isFilled()) return null;

    try {
      final cleanBase64 = base64String.contains(',')
          ? base64String.split(',').last
          : base64String;

      final bytes = base64Decode(cleanBase64);

      return pw.MemoryImage(bytes);
    } catch (e) {
      print("Error decoding base64: $e");
      return null;
    }
  }

  static List<Map<String, String>> _generateDataRows(
    List<PreparationDocumentItem> items,
  ) {
    return items.asMap().entries.map((entry) {
      var e = entry.value;

      return {
        'no': e.no.toString(),
        'device': e.device ?? '-',
        'model': e.model ?? '-',
        'asset_code': e.assetCode ?? '-',
        'quantity': e.quantity.toString(),
      };
    }).toList();
  }

  static String _noDocument(String value, PreparationDocument document) {
    return '$value-${document.code}';
  }

  static pw.Widget _buildHeader({
    required pw.MemoryImage logo,
    required PreparationDocument document,
    required String noDoc,
    bool? showFullDestination = false,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(height: 40, width: 100, child: pw.Image(logo)),
            pw.Text(
              'PT. DUTA INTIDAYA / WAREHOUSE BITUNG',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              'Komp. Pergudangan Nihon Seima Blok. H\nJl. Gatot Subroto No. 8 Kel. Kadujaya - Bitung\nKab. Tangerang - Banten (021) 5971 4382',
              style: const pw.TextStyle(fontSize: 8),
            ),
          ],
        ),
        pw.Wrap(
          crossAxisAlignment: pw.WrapCrossAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'NO',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'TGL',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
                if (noDoc != 'SK') pw.SizedBox(height: 3),
                if (noDoc != 'SK')
                  pw.Text(
                    'YTH',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
              ],
            ),
            pw.SizedBox(width: 10),
            pw.Column(
              children: [
                pw.Text(
                  ':',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  ':',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
                if (noDoc != 'SK') pw.SizedBox(height: 3),
                if (noDoc != 'SK')
                  pw.Text(
                    ':',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
              ],
            ),
            pw.SizedBox(width: 10),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  _noDocument(noDoc, document),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  DateFormat('dd MMMM y', 'id_ID').format(DateTime.now()),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
                if (noDoc != 'SK') pw.SizedBox(height: 3),
                if (noDoc != 'SK')
                  pw.Text(
                    showFullDestination!
                        ? '${document.destination}\n${document.destinationInit} - ${document.destinationCode}'
                        : '${document.destination}',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
              ],
            ),
            pw.SizedBox(height: 48),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTitle({required String title, String? description}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
          child: pw.Text(
            title,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 12,
              letterSpacing: 2,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.SizedBox(height: 24),
        if (description != null)
          pw.Text(
            description,
            style: pw.TextStyle(fontSize: 8, lineSpacing: 2),
          ),
      ],
    );
  }

  static pw.Widget _buildDataTable(List<Map<String, String>> rows) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
      children: [
        pw.TableRow(
          children: [
            _cell('NO', isHeader: true),
            _cell('DEVICE', isHeader: true),
            _cell('MODEL', isHeader: true),
            _cell('ASSET CODE', isHeader: true),
            _cell('QTY', isHeader: true),
          ],
        ),
        ...rows.map((item) {
          return pw.TableRow(
            children: [
              _cell(item['no']?.toString() ?? ''),
              _cell(item['device']?.toString() ?? ''),
              _cell(item['model']?.toString() ?? ''),
              _cell(item['asset_code']?.toString() ?? ''),
              _cell(item['quantity']?.toString() ?? ''),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _buildTextInSquare({required String value}) {
    return pw.Container(
      width: double.maxFinite,
      padding: const pw.EdgeInsets.all(5),
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      child: pw.Text(
        value,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
      ),
    );
  }

  static pw.Widget _buildNotes({required String? notes}) {
    return pw.Column(
      children: [
        pw.Container(
          width: double.maxFinite,
          padding: const pw.EdgeInsets.all(5),
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Text(
            'Catatan : ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
          ),
        ),
        pw.Container(
          width: double.maxFinite,
          height: 50,
          decoration: pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(),
              right: pw.BorderSide(),
              bottom: pw.BorderSide(),
            ),
          ),
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            notes ?? '',
            style: pw.TextStyle(fontSize: 9, fontStyle: pw.FontStyle.italic),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSignature({
    required String approvedBy,
    required String createdBy,
    required String preparedBy,
    pw.MemoryImage? signatureApproved,
    pw.MemoryImage? signatureCreated,
    pw.MemoryImage? signaturePrepared,
    required LetterType type,
  }) {
    return type == LetterType.outgoing
        ? pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 16),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _sign('Security', '(                          )'),
                _sign(
                  'Prepared By',
                  preparedBy.toCapitalize(),
                  signature: signaturePrepared,
                ),
                _sign(
                  'Created By',
                  createdBy.toCapitalize(),
                  signature: signatureCreated,
                ),
                _sign(
                  'Approved By',
                  approvedBy.toCapitalize(),
                  signature: signatureApproved,
                ),
              ],
            ),
          )
        : type == LetterType.receipt
        ? pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 16),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _sign('Received By', '(                          )'),
                _sign(
                  'Created By',
                  createdBy.toCapitalize(),
                  signature: signatureCreated,
                ),
                _sign(
                  'Approved By',
                  approvedBy.toCapitalize(),
                  signature: signatureApproved,
                ),
              ],
            ),
          )
        : pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 16),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _sign('Received By', '(                          )'),
                _sign(
                  'Submitted By',
                  createdBy.toCapitalize(),
                  signature: signatureCreated,
                ),
                _sign(
                  'Approved By',
                  approvedBy.toCapitalize(),
                  signature: signatureApproved,
                ),
              ],
            ),
          );
  }

  static pw.Widget _cell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(
        horizontal: isHeader ? 6 : 6,
        vertical: isHeader ? 8 : 8,
      ),
      child: pw.Center(
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: isHeader ? 10 : 9,
            fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  static pw.Widget _sign(
    String title,
    String name, {
    pw.MemoryImage? signature,
  }) {
    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(title, style: const pw.TextStyle(fontSize: 10)),

        pw.Stack(
          alignment: pw.Alignment.center,
          overflow: pw.Overflow.visible,
          children: [
            pw.SizedBox(height: 45, width: 90),

            if (signature != null)
              pw.Positioned(
                bottom: -10,
                child: pw.Image(
                  signature,
                  height: 70,
                  width: 100,
                  fit: pw.BoxFit.contain,
                ),
              ),
          ],
        ),

        pw.Text(
          name,
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  static Future<Uint8List> generateDocuments(
    PreparationDocument document,
    List<PreparationDocumentItem> items,
  ) async {
    final pdf = pw.Document();
    final logo = pw.MemoryImage(
      (await rootBundle.load(Assets.logoPdf)).buffer.asUint8List(),
    );
    final ttfRegular = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Poppins-Regular.ttf"),
    );
    final ttfBold = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Poppins-Bold.ttf"),
    );

    pw.MemoryImage? approvedSignature;
    if (document.approved != null) {
      approvedSignature = await _fetchImage(document.approvedSignature!);
    }

    pw.MemoryImage? createdSignature;
    if (document.created != null) {
      createdSignature = await _fetchImage(document.createdSignature!);
    }

    pw.MemoryImage? workerSignature;
    if (document.worker != null) {
      workerSignature = await _fetchImage(document.workerSignature!);
    }

    final dataRows = _generateDataRows(items);

    // SURAT KELUAR
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: ttfRegular, bold: ttfBold),
        orientation: pw.PageOrientation.portrait,
        margin: const pw.EdgeInsets.fromLTRB(32, 24, 32, 32),
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _buildHeader(logo: logo, document: document, noDoc: 'SK'),
          pw.SizedBox(height: 24),
          _buildTitle(title: 'SURAT KELUAR\nASSET IT'),
          pw.SizedBox(height: 8),
          _buildDataTable(dataRows),
          pw.SizedBox(height: 24),
          _buildTextInSquare(
            value:
                'TUJUAN : ${document.destination} | BANYAKNYA : ${document.totalBox} BOX',
          ),
          pw.SizedBox(height: 8),
          _buildNotes(notes: document.notes),
          pw.SizedBox(height: 24),
          _buildSignature(
            type: LetterType.outgoing,
            approvedBy: document.approved ?? '',
            createdBy: document.created ?? '',
            preparedBy: document.worker ?? '',
            signatureApproved: approvedSignature,
            signatureCreated: createdSignature,
            signaturePrepared: workerSignature,
          ),
        ],
      ),
    );

    // SURAT JALAN
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: ttfRegular, bold: ttfBold),
        orientation: pw.PageOrientation.portrait,
        margin: const pw.EdgeInsets.fromLTRB(32, 24, 32, 32),
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _buildHeader(logo: logo, document: document, noDoc: 'SJ'),
          pw.SizedBox(height: 24),
          _buildTitle(
            title: 'RECEIPT\nTANDA TERIMA',
            description:
                'Dengan Hormat,\nHarap dapat diterima barang tersebut dibawah ini :',
          ),
          pw.SizedBox(height: 8),
          _buildDataTable(dataRows),
          pw.SizedBox(height: 24),
          _buildTextInSquare(value: 'BANYAKNYA : ${document.totalBox} BOX'),
          pw.SizedBox(height: 8),
          _buildNotes(notes: document.notes),
          pw.SizedBox(height: 24),
          _buildSignature(
            type: LetterType.receipt,
            approvedBy: document.approved ?? '',
            createdBy: document.created ?? '',
            preparedBy: document.worker ?? '',
            signatureApproved: approvedSignature,
            signatureCreated: createdSignature,
            signaturePrepared: workerSignature,
          ),
        ],
      ),
    );

    // SERAH TERIMA
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: ttfRegular, bold: ttfBold),
        orientation: pw.PageOrientation.portrait,
        margin: const pw.EdgeInsets.fromLTRB(32, 24, 32, 32),
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _buildHeader(logo: logo, document: document, noDoc: 'ST'),
          pw.SizedBox(height: 24),
          _buildTitle(
            title: 'SERAH TERIMA\nASSET IT',
            description:
                'Dengan Hormat,\nBersama dengan surat ini, kami serahkan Asset IT dengan rincian sebagai berikut :',
          ),
          pw.SizedBox(height: 8),
          _buildDataTable(dataRows),
          pw.SizedBox(height: 32),
          _buildNotes(notes: document.notes),
          pw.SizedBox(height: 24),
          _buildSignature(
            type: LetterType.handover,
            approvedBy: document.approved ?? '',
            createdBy: document.created ?? '',
            preparedBy: document.worker ?? '',
            signatureApproved: approvedSignature,
            signatureCreated: createdSignature,
            signaturePrepared: workerSignature,
          ),
        ],
      ),
    );

    return await pdf.save();
  }
}
