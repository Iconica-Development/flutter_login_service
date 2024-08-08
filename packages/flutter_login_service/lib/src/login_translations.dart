import "package:flutter/material.dart";

/// [LoginServiceTranslations] is used to provide custom error messages
/// for the [LoginService] implementations.
@immutable
class LoginServiceTranslations {
  const LoginServiceTranslations({
    required this.errorTitle,
    required this.errorMessage,
    required this.userDisabledTitle,
    required this.userDisabledMessage,
    required this.wrongPasswordTitle,
    required this.wrongPasswordMessage,
    required this.tooManyRequestsTitle,
    required this.tooManyRequestsMessage,
    required this.invalidCredentialsTitle,
    required this.invalidCredentialsMessage,
    required this.changePasswordInvalidEmailTitle,
    required this.changePasswordInvalidEmailMessage,
    required this.changePasswordUserNotFoundTitle,
    required this.changePasswordUserNotFoundMessage,
    required this.changePasswordErrorTitle,
    required this.changePasswordErrorMessage,
    required this.networkTitle,
    required this.networkMessage,
  });

  /// [empty] is used to create an empty [LoginServiceTranslations] object, to
  /// use the default error messages.
  const LoginServiceTranslations.empty()
      : errorTitle = "Error",
        errorMessage = "An unknown error occured",
        userDisabledTitle = "User disabled",
        userDisabledMessage =
            "If you have any questions as to how this happened, please contact"
                " us at [email].",
        wrongPasswordTitle = "Wrong password",
        wrongPasswordMessage =
            "The password you entered is incorrect. Please try again.",
        tooManyRequestsTitle = "To many requests",
        tooManyRequestsMessage = "You’ve tried to log in too many times.",
        invalidCredentialsTitle = "Incorrect",
        invalidCredentialsMessage =
            "Your login credentials are incorrect, please try again.",
        changePasswordInvalidEmailTitle = "Invalid email",
        changePasswordInvalidEmailMessage =
            "The email you entered is invalid. Please try again.",
        changePasswordUserNotFoundTitle = "Unknown email",
        changePasswordUserNotFoundMessage =
            "The email you entered is unknown. Please try again.",
        changePasswordErrorTitle = "Error",
        changePasswordErrorMessage = "An unknown error occured",
        networkTitle = "No network connection",
        networkMessage = "Please check your network connection";
  final String errorTitle;
  final String errorMessage;
  final String userDisabledTitle;
  final String userDisabledMessage;
  final String wrongPasswordTitle;
  final String wrongPasswordMessage;
  final String tooManyRequestsTitle;
  final String tooManyRequestsMessage;
  final String invalidCredentialsTitle;
  final String invalidCredentialsMessage;
  final String changePasswordInvalidEmailTitle;
  final String changePasswordInvalidEmailMessage;
  final String changePasswordUserNotFoundTitle;
  final String changePasswordUserNotFoundMessage;
  final String changePasswordErrorTitle;
  final String changePasswordErrorMessage;
  final String networkTitle;
  final String networkMessage;

  /// [copyWith] is used to create a new [LoginServiceTranslations] object
  /// with the provided values. If a value is not provided, the original
  /// value will be used.
  LoginServiceTranslations copyWith({
    String? errorTitle,
    String? errorMessage,
    String? userDisabledTitle,
    String? userDisabledMessage,
    String? wrongPasswordTitle,
    String? wrongPasswordMessage,
    String? tooManyRequestsTitle,
    String? tooManyRequestsMessage,
    String? invalidCredentialsTitle,
    String? invalidCredentialsMessage,
    String? changePasswordInvalidEmailTitle,
    String? changePasswordInvalidEmailMessage,
    String? changePasswordUserNotFoundTitle,
    String? changePasswordUserNotFoundMessage,
    String? changePasswordErrorTitle,
    String? changePasswordErrorMessage,
    String? networkTitle,
    String? networkMessage,
  }) =>
      LoginServiceTranslations(
        errorTitle: errorTitle ?? this.errorTitle,
        errorMessage: errorMessage ?? this.errorMessage,
        userDisabledTitle: userDisabledTitle ?? this.userDisabledTitle,
        userDisabledMessage: userDisabledMessage ?? this.userDisabledMessage,
        wrongPasswordTitle: wrongPasswordTitle ?? this.wrongPasswordTitle,
        wrongPasswordMessage: wrongPasswordMessage ?? this.wrongPasswordMessage,
        tooManyRequestsTitle: tooManyRequestsTitle ?? this.tooManyRequestsTitle,
        tooManyRequestsMessage:
            tooManyRequestsMessage ?? this.tooManyRequestsMessage,
        invalidCredentialsTitle:
            invalidCredentialsTitle ?? this.invalidCredentialsTitle,
        invalidCredentialsMessage:
            invalidCredentialsMessage ?? this.invalidCredentialsMessage,
        changePasswordInvalidEmailTitle: this.changePasswordInvalidEmailTitle,
        changePasswordInvalidEmailMessage:
            this.changePasswordInvalidEmailMessage,
        changePasswordUserNotFoundTitle: this.changePasswordUserNotFoundTitle,
        changePasswordUserNotFoundMessage:
            this.changePasswordUserNotFoundMessage,
        changePasswordErrorTitle: this.changePasswordErrorTitle,
        changePasswordErrorMessage: this.changePasswordErrorMessage,
        networkTitle: this.networkTitle,
        networkMessage: this.networkMessage,
      );
}
