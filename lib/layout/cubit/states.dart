abstract class SocialLayoutStates{}
class SocialLayoutInit extends SocialLayoutStates{}
class SocialUploadPostState extends SocialLayoutStates{}
class SocialChangeBottomNavState extends SocialLayoutStates{}

class SocialGetUserDataSuccess extends SocialLayoutStates{}
class SocialGetUserDataLoading extends SocialLayoutStates{}
class SocialGetUserDataError extends SocialLayoutStates{}

// profile
class SocialUpdateProfileLoadingState extends SocialLayoutStates{}
class SocialUpdateProfileErrorState extends SocialLayoutStates{}
class SocialProfileImagePickedSuccessState extends SocialLayoutStates{}
class SocialProfileImagePickedErrorState extends SocialLayoutStates{}
class SocialCoverImagePickedSuccessState extends SocialLayoutStates{}
class SocialCoverImagePickedErrorState extends SocialLayoutStates{}
class SocialUploadCoverImageErrorState extends SocialLayoutStates{}
class SocialRemoveProfileImageState extends SocialLayoutStates{}
class SocialRemoveCoverImageState extends SocialLayoutStates{}
// post
class SocialUpdatePostImageLoadingState extends SocialLayoutStates{}
class SocialUpdatePostImageErrorState extends SocialLayoutStates{}
class SocialCreatePostLoadingState extends SocialLayoutStates{}
class SocialCreatePostErrorState extends SocialLayoutStates{}
class SocialRemovePostImageState extends SocialLayoutStates{}
class SocialGetPostsLoading extends SocialLayoutStates{}
class SocialGetPostsSuccess extends SocialLayoutStates{}
class SocialCreatePostSuccessState extends SocialLayoutStates{}
class SocialGetPostsError extends SocialLayoutStates{
  final error;
  SocialGetPostsError(this.error);
}
class SocialLikePostSuccessState extends SocialLayoutStates{}
class SocialLikePostErrorState extends SocialLayoutStates{}

// Chat
class SocialGetAllUserSuccess extends SocialLayoutStates{}
class SocialGetAllUserError extends SocialLayoutStates{}
class SocialSendMessageSuccessState extends SocialLayoutStates{}
class SocialSendMessageErrorState extends SocialLayoutStates{}
class SocialGetMessageSuccessState extends SocialLayoutStates{}

class ChangeMode extends SocialLayoutStates{}
class ChangeModeError extends SocialLayoutStates{}

