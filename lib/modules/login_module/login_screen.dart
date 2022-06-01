// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../shared/cubit/login_cubit/cubit.dart';
import '../../shared/cubit/login_cubit/states.dart';
import '../register_module/register_screen.dart';

/* 
w100 Thin, the least thick
w200 Extra-light
w300 Light
w400 Normal / regular / plain
w500 Medium
w600 Semi-bold
w700 Bold
w800 Extra-bold
w900 Black, the most thick 
*/

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            print(state.uId);
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
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 14.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 34.0,
                        ),
                      ),
                      const SizedBox(height: 73.0),
                      CustomFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validateFunc: (value) {
                          if (value!.isEmpty) {
                            return 'Email Address is required.';
                          }
                          return null;
                        },
                        label: 'Email',
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
                      //const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Forgot your password?',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_right_alt,
                              color: kPrimaryColor,
                            ),
                            iconSize: 24,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => CustomButton(
                          text: 'Login'.toUpperCase(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          customTextButton(
                            text: 'REGISTER',
                            function: () =>
                                navigateTo(context, RegisterScreen()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
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
                                    image:
                                        AssetImage('assets/images/google.png'),
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
          );
        },
      ),
    );
  }
}
