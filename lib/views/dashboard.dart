import 'package:auction_app/viewmodel/user_sign_in_out_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({Key? key}) : super(key: key);

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(
                Provider.of<UserSignInOutViewModel>(context, listen: true)
                    .currentUser!
                    .photoURL!),
          ),
        ),
        title:     Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Provider.of<UserSignInOutViewModel>(context, listen: true)
                .currentUser!
                .displayName!,style: TextStyle(fontSize: 15),),
            Text(Provider.of<UserSignInOutViewModel>(context, listen: true)
                .currentUser!
                .email!,style: const TextStyle(fontSize: 12),),
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
