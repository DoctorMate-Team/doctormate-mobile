import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart'
    hide DiagnosisModel;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// Helper class for generating and sharing medical documents as PDF or text
class PdfShareHelper {
  // Private constructor to prevent instantiation
  PdfShareHelper._();

  /// Show success message
  static void _showSuccessMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Show error message
  static void _showErrorMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // ==================== PRESCRIPTION ====================

  /// Share prescription as formatted text
  static Future<void> sharePrescriptionText(
    BuildContext context,
    PrescriptionDetailsResponse prescription,
  ) async {
    try {
      final buffer = StringBuffer();
      buffer.writeln('📋 PRESCRIPTION DETAILS');
      buffer.writeln('=' * 40);
      buffer.writeln();

      if (prescription.doctor != null) {
        buffer.writeln('👨‍⚕️ Doctor: ${prescription.doctor!.name}');
        if (prescription.doctor!.specialty != null) {
          buffer.writeln('   Specialty: ${prescription.doctor!.specialty}');
        }
        buffer.writeln();
      }

      if (prescription.patient != null) {
        buffer.writeln('👤 Patient: ${prescription.patient!.name}');
        buffer.writeln();
      }

      if (prescription.appointment?.scheduledStart != null) {
        try {
          final dateTime = DateTime.parse(
            prescription.appointment!.scheduledStart,
          );
          final date = DateFormat('MMMM dd, yyyy').format(dateTime);
          buffer.writeln('📅 Date: $date');
          buffer.writeln();
        } catch (e) {
          buffer.writeln(
            '📅 Date: ${prescription.appointment!.scheduledStart}',
          );
          buffer.writeln();
        }
      }

      buffer.writeln('💊 MEDICATIONS:');
      buffer.writeln('-' * 40);
      for (int i = 0; i < prescription.medications.length; i++) {
        final med = prescription.medications[i];
        buffer.writeln('\n${i + 1}. ${med.drugName}');
        buffer.writeln('   Dosage: ${med.dosage}');
        buffer.writeln('   Frequency: ${med.frequency}');
        buffer.writeln('   Duration: ${med.durationDays} days');
        if (med.instructions.isNotEmpty) {
          buffer.writeln('   Instructions: ${med.instructions}');
        }
      }
      buffer.writeln();

      if (prescription.notes != null && prescription.notes!.isNotEmpty) {
        buffer.writeln('📝 NOTES:');
        buffer.writeln('-' * 40);
        buffer.writeln(prescription.notes);
        buffer.writeln();
      }

      buffer.writeln('=' * 40);
      buffer.writeln('Shared from DoctorMate App');

      await Share.share(
        buffer.toString(),
        subject:
            'Prescription from Dr. ${prescription.doctor?.name ?? "Doctor"}',
      );
    } catch (e) {
      _showErrorMessage(context, 'Failed to share prescription: $e');
    }
  }

  /// Generate and share prescription as PDF
  static Future<void> sharePrescriptionPdf(
    BuildContext context,
    PrescriptionDetailsResponse prescription,
  ) async {
    try {
      final pdf = pw.Document();

      String formattedDate = 'N/A';
      if (prescription.appointment?.scheduledStart != null) {
        try {
          final dateTime = DateTime.parse(
            prescription.appointment!.scheduledStart,
          );
          formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);
        } catch (e) {
          formattedDate = prescription.appointment!.scheduledStart;
        }
      }

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context context) {
            return [
              // Header
              _buildPdfHeader(
                title: 'PRESCRIPTION',
                subtitle: formattedDate,
                color: PdfColors.blue700,
              ),
              pw.SizedBox(height: 20),

              // Doctor Information
              if (prescription.doctor != null) ...[
                _buildPdfSection(
                  title: 'Doctor Information',
                  color: PdfColors.blue700,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfInfoRow(
                        'Name',
                        'Dr. ${prescription.doctor!.name}',
                      ),
                      if (prescription.doctor!.specialty != null)
                        _buildPdfInfoRow(
                          'Specialty',
                          prescription.doctor!.specialty!,
                        ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 15),
              ],

              // Patient Information
              if (prescription.patient != null) ...[
                _buildPdfSection(
                  title: 'Patient Information',
                  color: PdfColors.blue700,
                  child: _buildPdfInfoRow('Name', prescription.patient!.name),
                ),
                pw.SizedBox(height: 20),
              ],

              // Medications
              pw.Text(
                'Prescribed Medications',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue900,
                ),
              ),
              pw.SizedBox(height: 10),

              ...List.generate(prescription.medications.length, (index) {
                final med = prescription.medications[index];
                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 12),
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                    border: pw.Border.all(color: PdfColors.grey400),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${index + 1}. ${med.drugName}',
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      _buildPdfInfoRow('Dosage', med.dosage),
                      _buildPdfInfoRow('Frequency', med.frequency),
                      _buildPdfInfoRow('Duration', '${med.durationDays} days'),
                      if (med.instructions.isNotEmpty)
                        _buildPdfInfoRow('Instructions', med.instructions),
                    ],
                  ),
                );
              }),

              // Notes
              if (prescription.notes != null &&
                  prescription.notes!.isNotEmpty) ...[
                pw.SizedBox(height: 20),
                _buildPdfSection(
                  title: 'Additional Notes',
                  color: PdfColors.amber700,
                  child: pw.Text(
                    prescription.notes!,
                    style: const pw.TextStyle(fontSize: 11),
                    textAlign: pw.TextAlign.justify,
                  ),
                ),
              ],

              // Footer
              pw.SizedBox(height: 30),
              _buildPdfFooter(),
            ];
          },
        ),
      );

      final fileName =
          'Prescription_${prescription.doctor?.name.replaceAll(' ', '_') ?? 'Doctor'}_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf';

      await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
      _showSuccessMessage(context, 'Prescription PDF generated successfully');
    } catch (e) {
      _showErrorMessage(context, 'Failed to generate PDF: $e');
    }
  }

  // ==================== DIAGNOSIS ====================

  /// Share diagnosis as formatted text
  static Future<void> shareDiagnosisText(
    BuildContext context,
    DiagnosisModel diagnosis,
  ) async {
    try {
      final StringBuffer content = StringBuffer();

      content.writeln('═══════════════════════════');
      content.writeln('DIAGNOSIS REPORT');
      content.writeln('═══════════════════════════\n');

      content.writeln('Diagnosis Information:');
      content.writeln('Doctor: Dr. ${diagnosis.doctorName}');
      content.writeln('ICD Code: ${diagnosis.icdCode}');
      content.writeln('Severity: ${diagnosis.severity.toUpperCase()}');
      content.writeln(
        'Date: ${DateFormat('MMM dd, yyyy').format(diagnosis.createdAt)}',
      );
      content.writeln();

      content.writeln('═══════════════════════════');
      content.writeln('Description:');
      content.writeln('═══════════════════════════');
      content.writeln(diagnosis.description);
      content.writeln();

      content.writeln('═══════════════════════════');
      content.writeln('Generated by DoctorMate App');
      content.writeln('═══════════════════════════');

      await Share.share(
        content.toString(),
        subject: 'Diagnosis Report - ${diagnosis.icdCode}',
      );
    } catch (e) {
      _showErrorMessage(context, 'Failed to share diagnosis: $e');
    }
  }

  /// Generate and share diagnosis as PDF
  static Future<void> shareDiagnosisPdf(
    BuildContext context,
    DiagnosisModel diagnosis,
  ) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with severity badge
                pw.Container(
                  padding: const pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.orange700,
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'DIAGNOSIS REPORT',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'ICD Code: ${diagnosis.icdCode}',
                            style: const pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      _buildSeverityBadge(diagnosis.severity),
                    ],
                  ),
                ),
                pw.SizedBox(height: 24),

                // Doctor Information
                _buildPdfSection(
                  title: 'Doctor Information',
                  color: PdfColors.orange700,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: _buildPdfInfoRow(
                          'Doctor Name',
                          'Dr. ${diagnosis.doctorName}',
                        ),
                      ),
                      pw.Expanded(
                        child: _buildPdfInfoRow(
                          'Diagnosis Date',
                          DateFormat(
                            'MMM dd, yyyy',
                          ).format(diagnosis.createdAt),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                // Diagnosis Description
                _buildPdfSection(
                  title: 'Diagnosis Description',
                  color: PdfColors.orange700,
                  backgroundColor: PdfColors.grey200,
                  child: pw.Text(
                    diagnosis.description,
                    style: const pw.TextStyle(fontSize: 11),
                    textAlign: pw.TextAlign.justify,
                  ),
                ),

                pw.Spacer(),

                // Footer
                _buildPdfFooter(),
              ],
            );
          },
        ),
      );

      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            'diagnosis_report_${diagnosis.icdCode}_${DateFormat('yyyyMMdd').format(diagnosis.createdAt)}.pdf',
      );

      _showSuccessMessage(context, 'Diagnosis PDF generated successfully');
    } catch (e) {
      _showErrorMessage(context, 'Failed to generate PDF: $e');
    }
  }

  // ==================== MEDICAL RECORD ====================

  /// Share medical record as formatted text
  static Future<void> shareMedicalRecordText(
    BuildContext context,
    MedicalRecordModel record,
  ) async {
    try {
      final StringBuffer content = StringBuffer();

      content.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
      content.writeln('MEDICAL RECORD');
      content.writeln('━━━━━━━━━━━━━━━━━━━━━━━\n');

      content.writeln('Record Information:');
      content.writeln('Title: ${record.title}');
      content.writeln('Type: ${record.recordType}');
      content.writeln(
        'Date: ${DateFormat('MMM dd, yyyy - hh:mm a').format(record.recordedAt)}',
      );
      content.writeln();

      if (record.diagnoses != null && record.diagnoses!.isNotEmpty) {
        content.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
        content.writeln('Diagnosis Details:');
        content.writeln('━━━━━━━━━━━━━━━━━━━━━━━\n');

        for (var i = 0; i < record.diagnoses!.length; i++) {
          final diagnosis = record.diagnoses![i];
          content.writeln('Diagnosis ${i + 1}:');
          content.writeln('Doctor: ${diagnosis.doctorName}');
          content.writeln('ICD Code: ${diagnosis.icdCode}');
          content.writeln('Severity: ${diagnosis.severity.toUpperCase()}');
          content.writeln('Description: ${diagnosis.description}');
          content.writeln(
            'Date: ${DateFormat('MMM dd, yyyy').format(diagnosis.createdAt)}',
          );
          if (i < record.diagnoses!.length - 1) {
            content.writeln();
          }
        }
      }

      content.writeln('\n━━━━━━━━━━━━━━━━━━━━━━━');
      content.writeln('Generated by DoctorMate App');
      content.writeln('━━━━━━━━━━━━━━━━━━━━━━━');

      await Share.share(
        content.toString(),
        subject: 'Medical Record - ${record.title}',
      );
    } catch (e) {
      _showErrorMessage(context, 'Failed to share medical record: $e');
    }
  }

  /// Generate and share medical record as PDF
  static Future<void> shareMedicalRecordPdf(
    BuildContext context,
    MedicalRecordModel record,
  ) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              // Header
              _buildPdfHeader(
                title: 'MEDICAL RECORD',
                subtitle: record.title,
                color: PdfColors.blue700,
              ),
              pw.SizedBox(height: 20),

              // Record Information
              _buildPdfSection(
                title: 'Record Information',
                color: PdfColors.blue700,
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: _buildPdfInfoRow(
                        'Record Type',
                        record.recordType.toUpperCase(),
                      ),
                    ),
                    pw.Expanded(
                      child: _buildPdfInfoRow(
                        'Date Recorded',
                        DateFormat(
                          'MMM dd, yyyy - hh:mm a',
                        ).format(record.recordedAt),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Diagnosis Information
              if (record.diagnoses != null && record.diagnoses!.isNotEmpty) ...[
                pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Diagnosis Details',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue700,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      ...record.diagnoses!.asMap().entries.map((entry) {
                        final diagnosis = entry.value;
                        return pw.Container(
                          margin: const pw.EdgeInsets.only(bottom: 15),
                          padding: const pw.EdgeInsets.all(12),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white,
                            borderRadius: pw.BorderRadius.circular(6),
                            border: pw.Border.all(color: PdfColors.grey400),
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Diagnosis ${entry.key + 1}',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  _buildSeverityBadge(diagnosis.severity),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              pw.Row(
                                children: [
                                  pw.Expanded(
                                    child: _buildPdfInfoRow(
                                      'Doctor',
                                      diagnosis.doctorName,
                                    ),
                                  ),
                                  pw.Expanded(
                                    child: _buildPdfInfoRow(
                                      'ICD Code',
                                      diagnosis.icdCode,
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              _buildPdfInfoRow(
                                'Description',
                                diagnosis.description,
                              ),
                              pw.SizedBox(height: 6),
                              pw.Text(
                                'Date: ${DateFormat('MMM dd, yyyy').format(diagnosis.createdAt)}',
                                style: const pw.TextStyle(
                                  fontSize: 9,
                                  color: PdfColors.grey700,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),
              ],

              // Footer
              pw.Spacer(),
              _buildPdfFooter(),
            ];
          },
        ),
      );

      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            'medical_record_${record.title.replaceAll(' ', '_')}_${DateFormat('yyyyMMdd').format(record.recordedAt)}.pdf',
      );

      _showSuccessMessage(context, 'Medical record PDF generated successfully');
    } catch (e) {
      _showErrorMessage(context, 'Failed to generate PDF: $e');
    }
  }

  // ==================== PDF BUILDING HELPERS ====================

  /// Build PDF header with title and subtitle
  static pw.Widget _buildPdfHeader({
    required String title,
    required String subtitle,
    required PdfColor color,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            subtitle,
            style: const pw.TextStyle(color: PdfColors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// Build PDF section with title and content
  static pw.Widget _buildPdfSection({
    required String title,
    required PdfColor color,
    required pw.Widget child,
    PdfColor? backgroundColor,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: backgroundColor,
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: color,
            ),
          ),
          pw.SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  /// Build PDF info row (label: value)
  static pw.Widget _buildPdfInfoRow(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '$label:',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
        ),
        pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
      ],
    );
  }

  /// Build severity badge for diagnosis
  static pw.Widget _buildSeverityBadge(String severity) {
    PdfColor badgeColor;
    switch (severity.toLowerCase()) {
      case 'severe':
        badgeColor = PdfColors.red;
        break;
      case 'moderate':
        badgeColor = PdfColors.orange;
        break;
      default:
        badgeColor = PdfColors.green;
    }

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: pw.BoxDecoration(
        color: badgeColor,
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Text(
        severity.toUpperCase(),
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  /// Build PDF footer
  static pw.Widget _buildPdfFooter() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey400)),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'This document was generated by DoctorMate',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            'Generated on: ${DateFormat('MMM dd, yyyy - hh:mm a').format(DateTime.now())}',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }
}
