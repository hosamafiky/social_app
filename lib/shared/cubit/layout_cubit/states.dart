import 'package:social_app/models/user_model/user_model.dart';

abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class LayoutGetUserDataLoadingState extends LayoutStates {}

class LayoutGetUserDataSuccessState extends LayoutStates {
  final UserModel userModel;

  LayoutGetUserDataSuccessState(this.userModel);
}

class LayoutGetUserDataErrorState extends LayoutStates {
  final String error;

  LayoutGetUserDataErrorState(this.error);
}

class LayoutGetUsersDataLoadingState extends LayoutStates {}

class LayoutGetUsersDataSuccessState extends LayoutStates {}

class LayoutGetUsersDataErrorState extends LayoutStates {
  final String error;

  LayoutGetUsersDataErrorState(this.error);
}

class LayoutGetPostsDataLoadingState extends LayoutStates {}

class LayoutGetPostsDataSuccessState extends LayoutStates {}

class LayoutGetPostsLengthSuccessState extends LayoutStates {}

class LayoutGetPostsDataErrorState extends LayoutStates {
  final String error;

  LayoutGetPostsDataErrorState(this.error);
}

class LayoutLikePostDataSuccessState extends LayoutStates {}

class LayoutLikePostDataErrorState extends LayoutStates {
  final String error;

  LayoutLikePostDataErrorState(this.error);
}

class LayoutCommentOnPostDataSuccessState extends LayoutStates {}

class LayoutCommentOnPostDataErrorState extends LayoutStates {
  final String error;

  LayoutCommentOnPostDataErrorState(this.error);
}

class LayoutChangeBNBIndexState extends LayoutStates {}

class LayoutAddPostState extends LayoutStates {}

class LayoutGetProfilePictureSuccessState extends LayoutStates {}

class LayoutGetProfilePictureErrorState extends LayoutStates {}

class LayoutGetCoverPictureSuccessState extends LayoutStates {}

class LayoutGetCoverPictureErrorState extends LayoutStates {}

class LayoutGetPostImageSuccessState extends LayoutStates {}

class LayoutGetPostImageErrorState extends LayoutStates {}

class LayoutUploadProfilePictureLoadingState extends LayoutStates {}

class LayoutUploadProfilePictureSuccessState extends LayoutStates {}

class LayoutUploadProfilePictureErrorState extends LayoutStates {}

class LayoutUploadCoverPictureLoadingState extends LayoutStates {}

class LayoutUploadCoverPictureSuccessState extends LayoutStates {}

class LayoutUploadCoverPictureErrorState extends LayoutStates {}

class LayoutUploadPostImageLoadingState extends LayoutStates {}

class LayoutUploadPostImageSuccessState extends LayoutStates {}

class LayoutUploadPostImageErrorState extends LayoutStates {}

class LayoutUpdateUserDataLoadingState extends LayoutStates {}

class LayoutUpdateUserDataErrorState extends LayoutStates {}

class LayoutFieldFilledState extends LayoutStates {}

class LayoutFieldEmptyState extends LayoutStates {}

class LayoutCreatePostLoadingState extends LayoutStates {}

class LayoutCreatePostSuccessState extends LayoutStates {}

class LayoutCreatePostErrorState extends LayoutStates {}

class LayoutRemovePostImageState extends LayoutStates {}

class LayoutSendMessageLoadingState extends LayoutStates {}

class LayoutSendMessageSuccessState extends LayoutStates {}

class LayoutSendMessageErrorState extends LayoutStates {}

class LayoutGetMessagesSuccessState extends LayoutStates {}
