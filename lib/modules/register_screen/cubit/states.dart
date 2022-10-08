abstract class SocialRegisterStates{}
class SocialRegisterInit extends SocialRegisterStates{}
class SocialRegisterLoading extends SocialRegisterStates{}
class SocialRegisterSuccess extends SocialRegisterStates{}
class SocialRegisterError extends SocialRegisterStates{
  final error;

  SocialRegisterError(this.error);
}
class SocialCreateUserSuccess extends SocialRegisterStates{
  final String uId;
  SocialCreateUserSuccess({
    required this.uId,
  });
}
class SocialCreateUserError extends SocialRegisterStates{
  final error;

  SocialCreateUserError(this.error);
}
class SocialRegisterChangePasswordVisibility extends SocialRegisterStates{}