// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/modules/addPost_module/addPost_module.dart';
import 'package:social_app/modules/chats_module/chats_module.dart';
import 'package:social_app/modules/home_module/home_module.dart';
import 'package:social_app/modules/users_module/users_module.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/layout_cubit/states.dart';
import 'package:social_app/shared/style/my_flutter_app_icons.dart';
import '../../../models/message_model/message_model.dart';
import '../../../models/post_model/post_model.dart';
import '../../../modules/settings_module/settings_module.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData() {
    emit(LayoutGetUserDataLoadingState());
    print(uId);
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(LayoutGetUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LayoutGetUserDataErrorState(error.toString()));
    });
  }

  int currenIndex = 0;
  List<BottomNavigationBarItem> bnbItems = [
    const BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Paper_Plus), label: 'Post'),
    const BottomNavigationBarItem(icon: Icon(IconBroken.User1), label: 'Users'),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Setting), label: 'Settings'),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen(),
    AddPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = ['Home', 'Chats', 'AddPost', 'Users', 'Settings'];
  void changeBNBIndex(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(LayoutAddPostState());
    } else {
      currenIndex = index;
      emit(LayoutChangeBNBIndexState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
    } else {
      print('No image selected.');
      emit(LayoutGetProfilePictureErrorState());
    }
  }

  File? coverImage;
  Future getCoverImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadCoverImage();
    } else {
      print('No image selected.');
      emit(LayoutGetCoverPictureErrorState());
    }
  }

  String? profileImageUrl;
  void uploadProfileImage() {
    emit(LayoutUploadProfilePictureLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(LayoutUploadProfilePictureSuccessState());
      }).catchError((error) {
        emit(LayoutUploadProfilePictureErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(LayoutUploadProfilePictureErrorState());
    });
  }

  String? coverImageUrl;
  void uploadCoverImage() {
    emit(LayoutUploadCoverPictureLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(LayoutUploadCoverPictureSuccessState());
      }).catchError((error) {
        emit(LayoutUploadCoverPictureErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(LayoutUploadCoverPictureErrorState());
    });
  }

  void updateUserInfo({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    emit(LayoutUpdateUserDataLoadingState());
    UserModel model = UserModel(
      name: name,
      bio: bio,
      phone: phone,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      isEmailVerified: userModel!.isEmailVerified,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(LayoutUpdateUserDataErrorState());
    });
  }

  bool? isEmpty = true;

  void onFieldFill(String? value) {
    if (value!.isNotEmpty) {
      isEmpty = false;
      emit(LayoutFieldFilledState());
    } else {
      isEmpty = true;
      emit(LayoutFieldEmptyState());
    }
  }

  File? postImage;
  String? postImageUrl;
  void getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(LayoutGetPostImageSuccessState());
    } else {
      print('No Image Selected.');
      emit(LayoutGetPostImageErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(LayoutUploadPostImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        emit(LayoutUploadPostImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(LayoutUploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());

      emit(LayoutUploadPostImageErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(LayoutRemovePostImageState());
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(LayoutCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      removePostImage();
      getHomePosts();
      emit(LayoutCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsIds = [];
  List<int> likes = [];
  List<int> comments = [];
  List<TextEditingController> controllers = [];

  void getHomePosts() {
    emit(LayoutGetPostsDataLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      posts = [];
      postsIds = [];
      likes = [];
      comments = [];
      controllers = [];
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          element.reference.collection('comments').get().then((value) {
            comments.add(value.docs.length);
            postsIds.add(element.id);
            controllers.add(TextEditingController());
            posts.add(PostModel.fromJson(element.data()));
            emit(LayoutGetPostsDataSuccessState());
          }).catchError((error) {
            print(error.toString());
            emit(LayoutGetPostsDataErrorState(error.toString()));
          });
        }).catchError((error) {
          print(error.toString());
          emit(LayoutGetPostsDataErrorState(error.toString()));
        });
      }
    }).catchError((error) {
      print(error.toString());
      emit(LayoutGetPostsDataErrorState(error.toString()));
    });
  }

  void like(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .get()
        .then((value) {
      if (value.exists) {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(userModel!.uId)
            .delete()
            .then((value) {
          getHomePosts();
        });
      } else {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(userModel!.uId)
            .set({'like': true}).then((value) {
          getHomePosts();
        }).catchError((error) {
          print(error.toString());
          emit(LayoutLikePostDataErrorState(error.toString()));
        });
      }
    }).catchError((error) {
      print(error.toString());
      emit(LayoutLikePostDataErrorState(error.toString()));
    });
  }

  void comment(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': comment}).then((value) {
      getHomePosts();
    }).catchError((error) {
      print(error.toString());
      emit(LayoutCommentOnPostDataErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    emit(LayoutGetUsersDataLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      users = [];
      for (var element in value.docs) {
        if (element.data()["uId"] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(LayoutGetUsersDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutGetUsersDataErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String modelId,
    required String content,
    required String dateTime,
  }) {
    emit(LayoutSendMessageLoadingState());

    MessageModel message = MessageModel(
      dateTime: dateTime,
      senderId: userModel!.uId,
      recieverId: modelId,
      content: content,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(modelId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(LayoutSendMessageSuccessState());
    }).catchError((error) {
      emit(LayoutSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(modelId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(LayoutSendMessageSuccessState());
    }).catchError((error) {
      emit(LayoutSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(LayoutGetMessagesSuccessState());
    });
  }
}
