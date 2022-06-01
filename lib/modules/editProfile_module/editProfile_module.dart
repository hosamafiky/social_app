// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/layout_cubit/cubit.dart';
import 'package:social_app/shared/cubit/layout_cubit/states.dart';
import 'package:social_app/shared/style/my_flutter_app_icons.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        var model = cubit.userModel!;
        nameController.text = model.name!;
        phoneController.text = model.phone!;
        nameController.text = model.name!;
        bioController.text = model.bio!;
        var profile = cubit.profileImage;
        var cover = cubit.coverImage;
        return Scaffold(
          appBar: customAppBar(
            context: context,
            text: 'Edit Profile',
            actions: [
              customTextButton(
                text: 'update',
                isUpper: true,
                function: () {
                  cubit.updateUserInfo(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                    image: cubit.profileImageUrl,
                    cover: cubit.coverImageUrl,
                  );
                },
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is LayoutUpdateUserDataLoadingState) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10.0),
                  ],
                  SizedBox(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    image: cover == null
                                        ? NetworkImage(model.cover!)
                                        : FileImage(cover) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (state is LayoutUploadCoverPictureLoadingState)
                                const SizedBox(
                                  height: 140.0,
                                  width: double.infinity,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                              Positioned(
                                bottom: 10.0,
                                right: 10.0,
                                child: CircleAvatar(
                                  radius: 16.0,
                                  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    onPressed: () => cubit.getCoverImage(),
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 57.0,
                                backgroundImage: profile == null
                                    ? NetworkImage(model.image!)
                                    : FileImage(profile) as ImageProvider,
                              ),
                            ),
                            if (state is LayoutUploadProfilePictureLoadingState)
                              const SizedBox(
                                height: 120.0,
                                width: 120.0,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            CircleAvatar(
                              radius: 16.0,
                              backgroundColor: Colors.grey,
                              child: IconButton(
                                onPressed: () => cubit.getProfileImage(),
                                icon: const Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required.';
                      }
                      return null;
                    },
                    label: 'Username',
                    prefix: IconBroken.Profile,
                  ),
                  const SizedBox(height: 20.0),
                  CustomFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return 'Bio is required.';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(height: 20.0),
                  CustomFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return 'phone is required.';
                      }
                      return null;
                    },
                    label: 'Phone Number',
                    prefix: Icons.phone,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
