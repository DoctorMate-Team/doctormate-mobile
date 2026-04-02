enum NotificationType {
  diagnosisAdded('DiagnosisAdded'),
  appointmentReminder('AppointmentReminder'),
  appointmentConfirmed('AppointmentConfirmed'),
  appointmentCancelled('AppointmentCancelled'),
  appointmentExpired('AppointmentExpired'),
  prescriptionCreated('PrescriptionCreated'),
  paymentSuccess('PaymentSuccess'),
  unknown('Unknown');

  final String value;
  const NotificationType(this.value);

  static NotificationType fromString(String? type) {
    if (type == null) return NotificationType.unknown;

    return NotificationType.values.firstWhere(
      (e) => e.value == type,
      orElse: () => NotificationType.unknown,
    );
  }
}

enum NotificationClickAction {
  openMedicalRecord('OPEN_MEDICAL_RECORD'),
  openAppointment('OPEN_APPOINTMENT'),
  openAppointmentDetails('OPEN_APPOINTMENT_DETAILS'),
  openNotifications('OPEN_NOTIFICATIONS'),
  openPaymentDetails('OPEN_PAYMENT_DETAILS'),
  none('');

  final String value;
  const NotificationClickAction(this.value);

  static NotificationClickAction fromString(String? action) {
    if (action == null || action.isEmpty) return NotificationClickAction.none;

    return NotificationClickAction.values.firstWhere(
      (e) => e.value == action,
      orElse: () => NotificationClickAction.none,
    );
  }
}
