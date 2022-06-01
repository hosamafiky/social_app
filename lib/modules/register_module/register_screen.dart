import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/login_module/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/register_cubit/cubit.dart';
import 'package:social_app/shared/cubit/register_cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../shared/components/constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              uId = state.uId;
              navigateAndFinish(context, const SocialLayout());
            });
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(height: 30.0),
                        CustomFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validateFunc: (value) {
                            if (value!.isEmpty) {
                              return 'Username is required.';
                            }
                            return null;
                          },
                          label: 'Username',
                          prefix: Icons.person_pin,
                        ),
                        const SizedBox(height: 15.0),
                        CustomFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validateFunc: (value) {
                            if (value!.isEmpty) {
                              return 'Email Address is required.';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 15.0),
                        CustomFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validateFunc: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short.';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          suffix: cubit.suffix,
                          onSuffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          isSecure: cubit.isPassword,
                        ),
                        const SizedBox(height: 15.0),
                        CustomFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validateFunc: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Number is required.';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => CustomButton(
                            text: 'Register'.toUpperCase(),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            customTextButton(
                              text: 'LOGIN',
                              function: () => navigateTo(
                                context,
                                LoginScreen(),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Or sign up with social account',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 92.0,
                                    height: 64.0,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/google.png'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 92.0,
                                    height: 64.0,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/facebook.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
