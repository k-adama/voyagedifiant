import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:voyagedifiant/core/constants/clean_text.dart';

class InvoicePdfService {
  static Future<File> generateInvoicePdf({
    required Map<String, dynamic> vehiculeInfo,
   // required double amount,
  }) async {
    final pdf = pw.Document();
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'fr_FR', name: 'FCFA');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Facture',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(cleanText('Nom du vehicule : ')),
              pw.Text(cleanText('Classe :')),
              pw.Text(cleanText('Chauffeur :')),
              pw.Text(cleanText(
                  'Periode de location : ')),
              pw.SizedBox(height: 10),
             // pw.Text('Coût journalier : ${formatCurrency.format(vehiculeInfo['price'])}'),
             // pw.Text('Coût total : ${formatCurrency.format(vehiculeInfo['totalPriceOperation'])}'),
             // pw.SizedBox(height: 20),
             /* pw.Text('Montant réglé : ${formatCurrency.format(amount)}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),*/
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/facture_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
