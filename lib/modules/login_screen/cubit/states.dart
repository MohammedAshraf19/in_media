abstract class SocialLoginStates{}
class SocialInitLogin extends SocialLoginStates{}
class SocialLoginLoading extends SocialLoginStates{}
class SocialLoginSuccess extends SocialLoginStates{
  final String uId;

  SocialLoginSuccess(this.uId);
}
class SocialLoginError extends SocialLoginStates{
  final error;

  SocialLoginError(this.error);
}
class SocialLoginChangePasswordVisibility extends SocialLoginStates{}