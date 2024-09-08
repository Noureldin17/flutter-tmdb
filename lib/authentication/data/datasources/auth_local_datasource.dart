import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(
      String sessionId, String type, bool keepMeSignedIn);
  Future<void> deleteSessionId();
  Future<Map<dynamic, dynamic>> getSessionId();
  Future<void> onBoardUser();
  Future<bool> checkOnBoardUser();
  Future<bool> keepSignedIn();
}

class AuthenticationLocalImpl implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalImpl(this.sharedPreferences);

  @override
  Future<void> saveSessionId(
      String sessionId, String type, bool keepMeSignedIn) async {
    if (type == "user") {
      await sharedPreferences.setString('session_id', sessionId);
      await sharedPreferences.setBool('keep_user_signed', keepMeSignedIn);
    } else if (type == 'guest') {
      await sharedPreferences.setString('guest_session_id', sessionId);
    }
  }

  @override
  Future<void> deleteSessionId() async {
    try {
      await sharedPreferences.remove('session_id');
      await sharedPreferences.remove('keep_user_signed');
    } catch (_) {
      await sharedPreferences.remove('guest_session_id');
    }
  }

  @override
  Future<Map<dynamic, dynamic>> getSessionId() async {
    final value = sharedPreferences.getString('session_id');
    if (value != null) {
      return {'key': 'session_id', 'value': value.toString()};
    } else {
      final value = sharedPreferences.getString('guest_session_id');
      return {'key': 'guest_session_id', 'value': value.toString()};
    }
  }

  @override
  Future<bool> checkOnBoardUser() async {
    final value = sharedPreferences.getBool('onboard_user');
    if (value == null) {
      return false;
    } else if (value == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> onBoardUser() async {
    await sharedPreferences.setBool('onboard_user', true);
  }

  @override
  Future<bool> keepSignedIn() async {
    final value = sharedPreferences.getBool('keep_user_signed');
    if (value == null) {
      return false;
    } else if (value == true) {
      return true;
    } else {
      return false;
    }
  }
}
