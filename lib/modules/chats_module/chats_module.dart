import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/chat_module/chat_module.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/layout_cubit/cubit.dart';
import 'package:social_app/shared/cubit/layout_cubit/states.dart';

import '../../models/user_model/user_model.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildChatItem(
            context,
            cubit.users[index],
          ),
          separatorBuilder: (context, index) => divider(),
          itemCount: cubit.users.length,
        );
      },
    );
  }

  Widget buildChatItem(context, UserModel model) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
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
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
