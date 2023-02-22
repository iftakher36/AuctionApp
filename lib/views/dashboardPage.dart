import 'package:auction_app/utils/constant.dart';
import 'package:auction_app/viewmodel/dashboard_viewmodel.dart';
import 'package:auction_app/viewmodel/user_sign_in_out_viewmodel.dart';
import 'package:auction_app/views/tab%20item/auction_gallery.dart';
import 'package:auction_app/views/tab%20item/my_posted_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({Key? key}) : super(key: key);

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabController = TabController(length: 2, vsync: this);
      setState(() {
      });
      Provider.of<DashboardViewModel>(context, listen: false)
          .getLoginUserData(context);
      Provider.of<DashboardViewModel>(context, listen: false)
          .getAllDataOfAllUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(
                Provider.of<UserSignInOutViewModel>(context)
                    .currentUser!
                    .photoURL!),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Provider.of<UserSignInOutViewModel>(context)
                  .currentUser!
                  .displayName!,
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              Provider.of<UserSignInOutViewModel>(context)
                  .currentUser!
                  .email!,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TabBar(
              controller: tabController, tabs: const [
            Tab(
              child: Text(
                "Auction Gallery",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
                child: Text("My Posted Items",
                    style: TextStyle(color: Colors.black))),
          ]),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: const [AuctionGallery(), MyPostedItem()],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Constant.addProductPage);
        },
      ),
    );
  }
}
