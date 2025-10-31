class ApiConstants {
  static const apiBaseUrl = "https://doctormate.runasp.net/api/";
  //Auth Endpoints
  static const login = "Login";
  static const register = "Register";
  static const completeProfile = "CompleteProfile/complete";
  static const sendOtp = "Otp/send";
  static const resetPassword = "PasswordReset/reset-password";
  static const verifyOtp = "Otp/verify";
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
