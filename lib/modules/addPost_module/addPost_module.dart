// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/layout_cubit/cubit.dart';
import 'package:social_app/shared/cubit/layout_cubit/states.dart';

import '../../shared/style/my_flutter_app_icons.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is LayoutCreatePostSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: customAppBar(
            context: context,
            text: 'Create Post',
            center: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
            actions: [
              !cubit.isEmpty!
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: customTextButton(
                        text: 'Post',
                        size: 16.0,
                        textColor: Colors.white,
                        function: () => cubit.postImage != null
                            ? cubit.uploadPostImage(
                                dateTime: DateTime.now().toString(),
                                text: postController.text,
                              )
                            : cubit.createPost(
                                dateTime: DateTime.now().toString(),
                                text: postController.text,
                              ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: customTextButton(
                        text: 'Post',
                        size: 16.0,
                        textColor: Colors.grey,
                        function: null,
                      ),
                    ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        cubit.userModel!.image!,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.userModel!.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.public,
                                        size: 13.0,
                                        color: Colors.black38,
                                      ),
                                      SizedBox(width: 2.0),
                                      Text(
                                        'Public',
                                        style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black38,
                                        size: 17.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        size: 13.0,
                                        color: Colors.black38,
                                      ),
                                      SizedBox(width: 2.0),
                                      Text(
                                        'Album',
                                        style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black38,
                                        size: 17.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: postController,
                        decoration: const InputDecoration(
                          hintText: 'What\'s on your mind?',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => cubit.onFieldFill(value),
                      ),
                      if (state is LayoutCreatePostLoadingState ||
                          state is LayoutUploadPostImageLoadingState)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 190.0,
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        right: 10.0,
                        child: CircleAvatar(
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => cubit.removePostImage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => cubit.getPostImage(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              IconBroken.Image,
                              color: Colors.greenAccent,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Photo/Video',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '#tags',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
