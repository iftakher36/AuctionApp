import 'package:auction_app/viewmodel/user_sign_in_out_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late UserSignInOutViewModel _signInOutViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _signInOutViewModel =
          Provider.of<UserSignInOutViewModel>(context, listen: false);
      _signInOutViewModel.checkIfCurrentlyAnyOneLogin(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _signInOutViewModel.resetData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Auction",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const Text(
                "Find your best product",
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Provider.of<UserSignInOutViewModel>(context, listen: false)
                        .signInToGoogleGmail();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "asset/google.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Sign In With Gmail",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
