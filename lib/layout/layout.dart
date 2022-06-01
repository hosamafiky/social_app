import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/addPost_module/addPost_module.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/layout_cubit/cubit.dart';
import 'package:social_app/shared/cubit/layout_cubit/states.dart';
import 'package:social_app/shared/style/my_flutter_app_icons.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is LayoutAddPostState) {
          navigateTo(context, AddPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currenIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currenIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => cubit.changeBNBIndex(index),
            currentIndex: cubit.currenIndex,
            items: cubit.bnbItems,
          ),
        );
      },
    );
  }
}
