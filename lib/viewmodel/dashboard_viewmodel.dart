import 'dart:convert';

import 'package:auction_app/model/product.dart';
import 'package:auction_app/viewmodel/user_sign_in_out_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DashboardViewModel with ChangeNotifier {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('AllUser');
  List<Product> productByAllUser = [], productByLoginUser = [];

  getAllDataOfAllUser() async {
    productByAllUser = [];
    final documentFromAllUser = await _collectionReference.get();
    for (int i = 0; i < documentFromAllUser.size; i++) {
      final documentFromUserWiseAuctionProduct = await _collectionReference
          .doc(documentFromAllUser.docs[i].id)
          .collection("AuctionProduct")
          .get();
      for (int j = 0; j < documentFromUserWiseAuctionProduct.size; j++) {
        Product product = productFromJson(
            jsonEncode(documentFromUserWiseAuctionProduct.docs[j].data()));
        product.docId = documentFromUserWiseAuctionProduct.docs[j].id;
        productByAllUser.add(product);
      }
    }
    notifyListeners();
  }

  getLoginUserData(BuildContext context) async {
    productByLoginUser=[];
    final productOfSingleUSer = await _collectionReference
        .doc(Provider.of<UserSignInOutViewModel>(context, listen: false)
            .currentUser
            ?.uid)
        .collection("AuctionProduct")
        .get();
    for (int j = 0; j < productOfSingleUSer.size; j++) {
      Product product =
          productFromJson(jsonEncode(productOfSingleUSer.docs[j].data()));
      product.docId = productOfSingleUSer.docs[j].id;
      productByLoginUser.add(product);
    }
    print(productByLoginUser.length);
    notifyListeners();
  }
}
