import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'https://faida.onrender.com/auth';
  static const String _loginEndpoint = '$_baseUrl/login';
  static const String _signupEndpoint = '$_baseUrl/signup';
  
  // SharedPreferences keys
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userTokenKey = 'userToken';
  static const String _userDataKey = 'userData';

  // Login method
  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_loginEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Save login state and user data
        await _saveLoginState(data);
        
        return AuthResult(
          success: true,
          message: 'Login successful',
          data: data,
        );
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return AuthResult(
          success: false,
          message: errorData['message'] ?? 'Login failed',
          data: null,
        );
      }
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Network error: ${e.toString()}',
        data: null,
      );
    }
  }

  // Signup method
  Future<AuthResult> signup(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_signupEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Save login state and user data
        await _saveLoginState(data);
        
        return AuthResult(
          success: true,
          message: 'Signup successful',
          data: data,
        );
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return AuthResult(
          success: false,
          message: errorData['message'] ?? 'Signup failed',
          data: null,
        );
      }
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Network error: ${e.toString()}',
        data: null,
      );
    }
  }

  // Save login state to SharedPreferences
  Future<void> _saveLoginState(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userDataKey, jsonEncode(userData));
    
    // Save token if available
    if (userData.containsKey('token')) {
      await prefs.setString(_userTokenKey, userData['token']);
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  // Get user token
  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTokenKey);
  }

  // Logout method
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_userTokenKey);
    await prefs.remove(_userDataKey);
  }

  // Send OTP (mock implementation - replace with actual API)
  Future<AuthResult> sendOTP(String emailOrPhone) async {
    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));
      
      // Mock successful OTP send
      return AuthResult(
        success: true,
        message: 'OTP sent successfully to $emailOrPhone',
        data: {'otp_sent': true},
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to send OTP: ${e.toString()}',
        data: null,
      );
    }
  }

  // Verify OTP (mock implementation - replace with actual API)
  Future<AuthResult> verifyOTP(String emailOrPhone, String otp) async {
    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Mock OTP verification - replace with actual logic
      if (otp == '1234') {
        return AuthResult(
          success: true,
          message: 'OTP verified successfully',
          data: {'verified': true},
        );
      } else {
        return AuthResult(
          success: false,
          message: 'Invalid OTP',
          data: null,
        );
      }
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'OTP verification failed: ${e.toString()}',
        data: null,
      );
    }
  }

  // Login with Google (mock implementation)
  Future<AuthResult> loginWithGoogle() async {
    try {
      // Simulate Google login delay
      await Future.delayed(Duration(seconds: 2));
      
      // Mock successful Google login
      final mockUserData = {
        'id': '123',
        'username': 'Google User',
        'email': 'user@gmail.com',
        'token': 'mock_google_token',
        'loginMethod': 'google'
      };
      
      await _saveLoginState(mockUserData);
      
      return AuthResult(
        success: true,
        message: 'Google login successful',
        data: mockUserData,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Google login failed: ${e.toString()}',
        data: null,
      );
    }
  }
}

// Auth result class
class AuthResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  AuthResult({
    required this.success,
    required this.message,
    this.data,
  });
}