import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/layout_cubit/cubit.dart';
import 'package:social_app/shared/cubit/layout_cubit/states.dart';
import 'package:social_app/shared/style/my_flutter_app_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty && cubit.userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: const [
                      SizedBox(
                        height: 200.0,
                        width: double.infinity,
                        child: Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/smiling-businessman-welcoming-new-partner-group-meeting-with-handshake_1163-4627.jpg?t=st=1651063174~exp=1651063774~hmac=a9ecc5f68da106573a30c7983638b6e8a449f2e20956ffafad43583c724bad01&w=996',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Connect with other people.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildPostItem(
                    context,
                    cubit,
                    cubit.posts[index],
                    cubit.postsIds[index],
                    cubit.likes[index],
                    cubit.comments[index],
                    cubit.controllers[index],
                  ),
                  itemCount: cubit.posts.length,
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(
    BuildContext context,
    LayoutCubit cubit,
    PostModel model,
    String postId,
    int likes,
    int comments,
    TextEditingController controller,
  ) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      model.image!,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            const Icon(
                              Icons.check_circle_rounded,
                              color: kPrimaryColor,
                              size: 14.0,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          model.dateTime!,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_rounded),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                model.text!,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Container(
              //           height: 20.0,
              //           padding: const EdgeInsets.only(right: 6.0),
              //           child: MaterialButton(
              //             padding: EdgeInsets.zero,
              //             minWidth: 1.0,
              //             onPressed: () {},
              //             child: Text(
              //               '#software',
              //               style:
              //                   Theme.of(context).textTheme.caption!.copyWith(
              //                         color: kPrimaryColor,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 20.0,
              //           padding: const EdgeInsets.only(right: 6.0),
              //           child: MaterialButton(
              //             padding: EdgeInsets.zero,
              //             minWidth: 1.0,
              //             onPressed: () {},
              //             child: Text(
              //               '#software_development',
              //               style:
              //                   Theme.of(context).textTheme.caption!.copyWith(
              //                         color: kPrimaryColor,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 20.0,
              //           padding: const EdgeInsets.only(right: 6.0),
              //           child: MaterialButton(
              //             padding: EdgeInsets.zero,
              //             minWidth: 1.0,
              //             onPressed: () {},
              //             child: Text(
              //               '#flutter_development',
              //               style:
              //                   Theme.of(context).textTheme.caption!.copyWith(
              //                         color: kPrimaryColor,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 20.0,
              //           padding: const EdgeInsets.only(right: 6.0),
              //           child: MaterialButton(
              //             padding: EdgeInsets.zero,
              //             minWidth: 1.0,
              //             onPressed: () {},
              //             child: Text(
              //               '#mobile_applications',
              //               style:
              //                   Theme.of(context).textTheme.caption!.copyWith(
              //                         color: kPrimaryColor,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 20.0,
              //           padding: const EdgeInsets.only(right: 6.0),
              //           child: MaterialButton(
              //             padding: EdgeInsets.zero,
              //             minWidth: 1.0,
              //             onPressed: () {},
              //             child: Text(
              //               '#IT',
              //               style:
              //                   Theme.of(context).textTheme.caption!.copyWith(
              //                         color: kPrimaryColor,
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(model.postImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              size: 18.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '$likes',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              size: 18.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '$comments comments',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage:
                              NetworkImage(cubit.userModel!.image!),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            onFieldSubmitted: (value) =>
                                cubit.comment(postId, value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write a public comment...',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => cubit.like(postId),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 18.0,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                'Like',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Arrow___Up_Circle,
                                size: 18.0,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                'Share',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
