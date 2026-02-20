import 'package:doctor_mate/core/models/notification_data.dart';
import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationData', () {
    test('should parse DiagnosisAdded notification from map', () {
      final data = {
        'metadata': {
          'diagnosisId': '945fa7a5-73c2-48e3-abdd-d6948a17a7c9',
          'doctorName': 'Mohamed',
          'appointmentId': '693bf3db-e67e-476f-b078-06e9678a2c21',
        },
        'notificationId': '9599c4e3-1d8a-4973-bcc0-24620b6e94cd',
        'type': 'DiagnosisAdded',
        'click_action': 'OPEN_MEDICAL_RECORD',
      };

      final notification = NotificationData.fromMap(data);

      expect(notification.type, NotificationType.diagnosisAdded);
      expect(
        notification.clickAction,
        NotificationClickAction.openMedicalRecord,
      );
      expect(notification.diagnosisId, '945fa7a5-73c2-48e3-abdd-d6948a17a7c9');
      expect(notification.doctorName, 'Mohamed');
    });

    test('should parse AppointmentReminder notification from map', () {
      final data = {
        'metadata': {
          'appointmentId': 'c8f0d20e-49c4-4113-8d4b-1f55fccc6af9',
          'patientName': 'kamal Hanna',
          'scheduledStart': '2026-02-11T14:45:00',
        },
        'notificationId': '9599c4e3-1d8a-4973-bcc0-24620b6e94cd',
        'type': 'AppointmentReminder',
        'click_action': '',
      };

      final notification = NotificationData.fromMap(data);

      expect(notification.type, NotificationType.appointmentReminder);
      expect(notification.clickAction, NotificationClickAction.none);
      expect(
        notification.appointmentId,
        'c8f0d20e-49c4-4113-8d4b-1f55fccc6af9',
      );
      expect(notification.patientName, 'kamal Hanna');
      expect(notification.scheduledStart, '2026-02-11T14:45:00');
    });

    test('should parse metadata from JSON string', () {
      final data = {
        'metadata':
            '{"diagnosisId":"945fa7a5-73c2-48e3-abdd-d6948a17a7c9","doctorName":"Mohamed"}',
        'notificationId': 'test-123',
        'type': 'DiagnosisAdded',
        'click_action': 'OPEN_MEDICAL_RECORD',
      };

      final notification = NotificationData.fromMap(data);

      expect(notification.diagnosisId, '945fa7a5-73c2-48e3-abdd-d6948a17a7c9');
      expect(notification.doctorName, 'Mohamed');
    });

    test('should handle PrescriptionCreated notification', () {
      final data = {
        'metadata': {
          'prescriptionId': 'cd54e30d-e8be-44b1-9bfd-73babcdb51f0',
          'doctorName': 'Mohamed',
          'medicationCount': 3,
        },
        'notificationId': '04b5304d-d613-4bfd-8d74-b587c2d4c8e1',
        'type': 'PrescriptionCreated',
        'click_action': 'OPEN_MEDICAL_RECORD',
      };

      final notification = NotificationData.fromMap(data);

      expect(notification.type, NotificationType.prescriptionCreated);
      expect(
        notification.prescriptionId,
        'cd54e30d-e8be-44b1-9bfd-73babcdb51f0',
      );
      expect(notification.medicationCount, 3);
    });

    test('should handle unknown notification type', () {
      final data = {
        'metadata': {},
        'notificationId': 'test-123',
        'type': 'UnknownType',
        'click_action': '',
      };

      final notification = NotificationData.fromMap(data);

      expect(notification.type, NotificationType.unknown);
      expect(notification.clickAction, NotificationClickAction.none);
    });

    test('should convert to JSON and back', () {
      final original = NotificationData(
        notificationId: 'test-123',
        type: NotificationType.diagnosisAdded,
        clickAction: NotificationClickAction.openMedicalRecord,
        metadata: {'diagnosisId': 'diag-123', 'doctorName': 'Dr. Smith'},
      );

      final json = original.toJson();
      final parsed = NotificationData.fromJson(json);

      expect(parsed.notificationId, original.notificationId);
      expect(parsed.type, original.type);
      expect(parsed.clickAction, original.clickAction);
      expect(parsed.diagnosisId, 'diag-123');
      expect(parsed.doctorName, 'Dr. Smith');
    });
  });

  group('NotificationType', () {
    test('should parse type from string', () {
      expect(
        NotificationType.fromString('DiagnosisAdded'),
        NotificationType.diagnosisAdded,
      );
      expect(
        NotificationType.fromString('AppointmentReminder'),
        NotificationType.appointmentReminder,
      );
      expect(
        NotificationType.fromString('AppointmentConfirmed'),
        NotificationType.appointmentConfirmed,
      );
      expect(
        NotificationType.fromString('PrescriptionCreated'),
        NotificationType.prescriptionCreated,
      );
      expect(
        NotificationType.fromString('InvalidType'),
        NotificationType.unknown,
      );
      expect(NotificationType.fromString(null), NotificationType.unknown);
    });
  });

  group('NotificationClickAction', () {
    test('should parse action from string', () {
      expect(
        NotificationClickAction.fromString('OPEN_MEDICAL_RECORD'),
        NotificationClickAction.openMedicalRecord,
      );
      expect(
        NotificationClickAction.fromString('OPEN_APPOINTMENT'),
        NotificationClickAction.openAppointment,
      );
      expect(
        NotificationClickAction.fromString(''),
        NotificationClickAction.none,
      );
      expect(
        NotificationClickAction.fromString(null),
        NotificationClickAction.none,
      );
    });
  });
}
