import 'package:flutter/material.dart';

import '../screens/LocationPermissionScreen.dart';
import '../screens/LoginScreen.dart';
import '../screens/OtpVerificationScreen.dart';
import '../screens/SendOtpScreen.dart';
import '../screens/SignUpScreen.dart';
import '../screens/ForgotPasswordScreen.dart';
import '../screens/ForgotPasswordOTPScreen.dart';
import '../screens/ResetPasswordScreen.dart';
import '../screens/home/home_screen.dart';
import '../screens/intro.dart';
import '../screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(),
  '/intro': (context) => const IntroScreen(),
  '/home': (context) => const HomeScreen(),
  '/sendOtp': (context) => const SendOTPScreen(),
  '/otp': (context) {
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return OTPVerificationScreen(email: email);
  },
  '/signup': (context) => const SignupScreen(), // Direct registration with API
  '/login': (context) => const LoginScreen(),
  '/forgotPassword': (context) => const ForgotPasswordScreen(),
  '/forgotPasswordOtp': (context) {
    final phoneNumber = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return ForgotPasswordOTPScreen(phoneNumber: phoneNumber);
  },
  '/resetPassword': (context) {
    final phoneNumber = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return ResetPasswordScreen(phoneNumber: phoneNumber);
  },
  '/location': (context) => const LocationPermissionScreen(),
};