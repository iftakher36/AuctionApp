import 'dart:io';

import 'package:auction_app/model/product.dart';
import 'package:auction_app/viewmodel/dashboard_viewmodel.dart';
import 'package:auction_app/viewmodel/user_sign_in_out_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddProductViewModel with ChangeNotifier {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('AllUser');
  final ImagePicker _picker = ImagePicker();
  XFile? xFile;
  File? file;
  DateTime? selectedDate;

  pickImageAndConvertToFile(BuildContext context) async {
    xFile = await _picker.pickImage(source: ImageSource.gallery);
    file = File(xFile!.path);
    notifyListeners();
  }

  Future validationBeforeUploadToServer(
      {required BuildContext context,
      required String prdName,
      required String prdDetails,
      required String prdPrice}) async {
    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please pick an image")));
    } else if (prdName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please add a product name")));
    } else if (prdDetails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please add  product details")));
    } else if (prdPrice.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please add product price")));
    } else if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select end time")));
    } else {
      await uploadImageToCloudStorage(
          file!, context, prdName, prdDetails, prdPrice).then((value) {
            ///refreshing dashboard data
            Provider.of<DashboardViewModel>(context,listen: false).getAllDataOfAllUser();
            Provider.of<DashboardViewModel>(context,listen: false).getLoginUserData(context);
      });
    }
  }

  Future addToCloudFireStore(
      BuildContext context,
      String prdName,
      String prdDetails,
      String prdPrice,
      DateTime dateTime,
      String imgUrl) async {
    try {
      await collectionRef.doc(Provider.of<UserSignInOutViewModel>(context, listen: false)
          .currentUser!
          .uid).collection("AuctionProduct")
          .doc()
          .set(Product(
                  name: prdName,
                  details: prdDetails,
                  price: double.parse(prdPrice),
                  imageUrl: imgUrl,
                  endDate: dateTime.toIso8601String())
              .toJson())
          .then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Added Successfully")));
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  /// uploading image to firestore and after completion of upload adding product to firestore
  Future uploadImageToCloudStorage(File file, BuildContext context,
      String prdName, String prdDetails, String prdPrice) async {
    try {
      String folderName = "ProductImage/${DateTime.now()}";
      final ref = FirebaseStorage.instance.ref().child(folderName);
      final task = ref.putFile(file);
      await task.whenComplete(() async {
        /// while image uploaded adding whole data to firebase firestore
        addToCloudFireStore(context, prdName, prdDetails, prdPrice,
            selectedDate!, await task.snapshot.ref.getDownloadURL());
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///reset data while leaving the page
  resetData() {
    xFile = null;
    file = null;
    selectedDate = null;
  }
}
