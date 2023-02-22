import 'package:auction_app/utils/constant.dart';
import 'package:auction_app/viewmodel/add_product_viewmodel.dart';
import 'package:auction_app/viewmodel/dashboard_viewmodel.dart';
import 'package:auction_app/viewmodel/user_sign_in_out_viewmodel.dart';
import 'package:auction_app/views/SignInPage.dart';
import 'package:auction_app/views/add_productPage.dart';
import 'package:auction_app/views/dashboardPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => UserSignInOutViewModel()),
          ChangeNotifierProvider(create: (ctx) => AddProductViewModel()),
          ChangeNotifierProvider(create: (ctx) => DashboardViewModel()),
        ],
        child: MaterialApp(
          title: 'Auction App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            Constant.signInPage: (ctx) => const SignInPage(),
            Constant.dashBoardPage: (ctx) => const MyDashBoard(),
            Constant.addProductPage: (ctx) => const AddProductPage(),
          },
        ));
  }
}
