class ApiConstants {
  static const apiBaseUrl = "https://doctormate.runasp.net/api/";
  //Auth Endpoints
  static const login = "Login";
  static const register = "Register";
  static const completeProfile = "CompleteProfile/complete";
  static const otp = "Otp";
  static const sendOtp = "$otp/send";
  static const verifyOtp = "$otp/verify";
  static const resetPassword = "PasswordReset/reset-password";
  static const specialties = "Specialties";
  static const doctorsBySpecialty = "$specialties/{specialtyId}/doctors";
  static const doctorDetails = "$specialties/doctors/{doctorId}";
  static const profileManagement = "Profile_Management";
  static const uploadProfileImage = "$profileManagement/image";
  static const updateProfileDetails = "$profileManagement/update";
  static const availableSlots = "doctors/{doctorId}/available-slots";
  static const appointments = "appointments";
  static const patientAppointments = "$appointments/patient";
  static const updateAppointmentStatus = "$appointments/{appointmentId}/status";
  static const rescheduleAppointment =
      "$appointments/{appointmentId}/reschedule";
  static const appointmentDetails = "$appointments/{appointmentId}/details";
  static const medicalRecords = "records/patient";
  static const prescriptions = "prescriptions";
  static const communicationSessions = "communication/sessions";
  static const communicationCallToken = "communication/call-token";
  static const communicationCloseSession =
      "communication/sessions/{sessionId}/close";
  static const communicationSessionByAppointment =
      "communication/sessions/{appointmentId}";
  static const medicalImages = "medical-images";
  static const searchDoctors = "doctors/Search";
  static const deviceTokenRegister = "device-tokens/register";
  static const deviceTokenUnregister = "device-tokens/unregister";
  static const notifications = "Notifications";
  static const notificationsUnreadCount = "$notifications/unread-count";
  static const notificationsMarkRead = "$notifications/{notificationId}/read";
  static const notificationsMarkAllRead = "$notifications/read-all";
  static const doctorReviews = "doctor-reviews";

  // AI Endpoints
  static const aiBaseUrl = "https://doctormate-ai-production.up.railway.app/";
  static const aiSkinCheck = "ai/skin/check";
  static const aiSymptomsCheck = "ai/symptoms/check";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
