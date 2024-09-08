class LoginRequestParams {
  final String username;
  final String password;
  final bool keepMeSignedIn;

  LoginRequestParams(this.username, this.password, this.keepMeSignedIn);

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
