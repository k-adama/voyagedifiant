import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:voyagedifiant/core/constants/app_constants.dart';

Future<File> generateHotelInvoicePdf(Map<String, dynamic> data) async {
  final Uint8List logoBytes = await rootBundle
      .load('assets/icons/logo-voyage.png')
      .then((data) => data.buffer.asUint8List());

  final pdf = pw.Document();

  final String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  final rentalPeriod = data['rental_period'] as String;

 /* final parts = rentalPeriod.split(' ');
  final startDateStr = '${parts[0]} ${parts[1]} ${parts[2]} ${parts[3]}';
  final endDateStr = '${parts[4]} ${parts[5]} ${parts[6]} ${parts[7]}';
  final formattedRentalPeriod = 'du $startDateStr au $endDateStr';*/

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(32),
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 100,
                height: 60,
                child: pw.Image(pw.MemoryImage(logoBytes)),
              ),

              // Date d’émission
              pw.Text(
                'Date : $formattedDate',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),

          pw.SizedBox(height: 20),

          // Infos client en dessous du logo (left aligned)
          pw.Text('Client : ${data['username']}',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.Text('Téléphone : ${data['phone']}',
              style: pw.TextStyle(fontSize: 12)),

          pw.SizedBox(height: 20),

          // Titre centré
          pw.Center(
            child: pw.Text(
              'Résumé de la facture',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.underline,
              ),
            ),
          ),

          pw.SizedBox(height: 25),

          // Corps de la facture
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Hôtel : ${data['hotel_name']}',
                    style: pw.TextStyle(fontSize: 12)),
                pw.Text('Classe : ${data['class']}',
                    style: pw.TextStyle(fontSize: 12)),
                pw.Text('Localisation : ${data['city']}',
                    style: pw.TextStyle(fontSize: 12)),
                pw.Text(
                    'Période de location : ${AppConstants.extractFormattedDateRange(rentalPeriod)}',
                    style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 12),
                pw.Text('Coût journalier : ${data['price']} FCFA',
                    style: pw.TextStyle(fontSize: 12)),
                pw.Text('Coût total : ${data['total_price']} FCFA',
                    style: pw.TextStyle(fontSize: 12)),
                pw.Text('Montant à payer : ${data['montantApaye']} FCFA',
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    ),
  );

// Sauvegarde PDF comme avant...
  final output = await getTemporaryDirectory();
  final file = File(
      "${output.path}/facture_${DateTime.now().millisecondsSinceEpoch}.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}
