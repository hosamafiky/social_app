import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/bloc_observer.dart';
import 'package:social_app/shared/cubit/layout_cubit/cubit.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/style/style.dart';

import 'modules/login_module/login_screen.dart';

Future<void> firebaseInBackgroundMessageHandler(RemoteMessage message) async {
  print(message.data.toString());
  print("inBackgroundMessage");
}

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await CacheHelper.init();
      uId = CacheHelper.getData(key: 'uId') ?? '';
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);
      FirebaseMessaging.onBackgroundMessage(firebaseInBackgroundMessageHandler);
      FirebaseMessaging.onMessage.listen((event) {
        print(event.data.toString());
        print("onMessage");
      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(event.data.toString());
        print("onMessageOpenedApp");
      });
      runApp(MyApp(uId!));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this.uId, {Key? key}) : super(key: key);
  final String uId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit()
            ..getUserData()
            ..getHomePosts()
            ..getUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: uId == '' ? LoginScreen() : const SocialLayout(),
      ),
    );
  }
}
