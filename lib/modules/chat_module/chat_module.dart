import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/layout_cubit/cubit.dart';
import 'package:social_app/shared/cubit/layout_cubit/states.dart';
import 'package:social_app/shared/style/my_flutter_app_icons.dart';

import '../../models/message_model/message_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen(this.model, {Key? key}) : super(key: key);

  final UserModel model;
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        LayoutCubit.get(context).getMessages(receiverId: model.uId!);
        return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                titleSpacing: 0.0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(model.image!),
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                      model.name!,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_rounded),
                  ),
                ],
                elevation: 1.0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message = cubit.messages[index];
                          if (cubit.userModel!.uId == message.senderId) {
                            return buildSenderChatItem(message);
                          } else {
                            return buildReceiverChatItem(message);
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10.0),
                        itemCount: cubit.messages.length,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 40.0,
                              child: TextFormField(
                                controller: messageController,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Aa',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Container(
                            height: 40.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: IconButton(
                              onPressed: () => cubit.sendMessage(
                                modelId: model.uId!,
                                content: messageController.text,
                                dateTime: DateTime.now().toString(),
                              ),
                              icon: const Icon(
                                IconBroken.Send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildReceiverChatItem(MessageModel message) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 13.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(
            message.content!,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      );

  Widget buildSenderChatItem(MessageModel message) => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 13.0,
          ),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            message.content!,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
}
