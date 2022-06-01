import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/editProfile_module/editProfile_module.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/my_flutter_app_icons.dart';

import '../../shared/cubit/layout_cubit/cubit.dart';
import '../../shared/cubit/layout_cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        var model = cubit.userModel!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              model.cover!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 57.0,
                        backgroundImage: NetworkImage(
                          model.image!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                model.name!,
                style: const TextStyle(
                  fontSize: 20.0,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                model.bio!,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18.0,
                                    ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Posts',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '245',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18.0,
                                    ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Videos',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '10k',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18.0,
                                    ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Followers',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '34',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18.0,
                                    ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Following',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Add a photo.'),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  OutlinedButton(
                    onPressed: () => navigateTo(context, EditProfileScreen()),
                    child: const Icon(IconBroken.Edit),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
