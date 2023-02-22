import 'package:auction_app/viewmodel/add_product_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late final TextEditingController _textEditingControllerPrdName =
      TextEditingController();
  late final TextEditingController _textEditingControllerPrdDetails =
      TextEditingController();
  late final TextEditingController _textEditingControllerPrdBidPrice =
      TextEditingController();
  late AddProductViewModel _addProductViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addProductViewModel =
          Provider.of<AddProductViewModel>(context, listen: false);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingControllerPrdBidPrice.dispose();
    _textEditingControllerPrdDetails.dispose();
    _textEditingControllerPrdName.dispose();
    _addProductViewModel.resetData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add product"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 52,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: Provider.of<AddProductViewModel>(context,
                                        listen: true)
                                    .file !=
                                null
                            ? Image.file(Provider.of<AddProductViewModel>(context,
                                        listen: true)
                                    .file!)
                                .image
                            : null,
                        child: Provider.of<AddProductViewModel>(context,
                                        listen: true)
                                    .file ==
                                null
                            ? const Icon(
                                Icons.image,
                                size: 50,
                              )
                            : Container(),
                      ),
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                            onTap: () {
                              Provider.of<AddProductViewModel>(context,
                                      listen: false)
                                  .pickImageAndConvertToFile(context);
                            },
                            child: const Card(
                              child: Icon(Icons.add_circle_outline),
                            )))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
               TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: _textEditingControllerPrdName,
                decoration: InputDecoration(
                  hintText: "Product Name",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                controller: _textEditingControllerPrdDetails,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Product Description",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                minLines: 1,
                controller: _textEditingControllerPrdBidPrice,
                decoration: const InputDecoration(
                  hintText: "Product Bid Price",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Provider.of<AddProductViewModel>(context).selectedDate != null
                  ? const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Bid EndTime"),
                    )
                  : Container(),
              TextButton(
                  onPressed: () {
                    dateAndTimePicker(context);
                  },
                  child: Text(Provider.of<AddProductViewModel>(context)
                              .selectedDate !=
                          null
                      ? DateFormat('dd,MMM E AT hh:mm a').format(
                          Provider.of<AddProductViewModel>(context).selectedDate!)
                      : "Select Bid End Time")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<AddProductViewModel>(context, listen: false)
              .validationBeforeUploadToServer(
                  prdDetails: _textEditingControllerPrdDetails.text,
                  prdName: _textEditingControllerPrdName.text,
                  prdPrice: _textEditingControllerPrdBidPrice.text,
                  context: context);
        },
        label: const Text("Add For Auction"),
      ),
    );
  }

  void dateAndTimePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          SizedBox(
            height: 150,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime:
                  Provider.of<AddProductViewModel>(context).selectedDate ??
                      DateTime.now(),
              minimumYear: DateTime.now().year,
              onDateTimeChanged: (DateTime newDateTime) {
                _addProductViewModel.selectedDate = newDateTime;
                setState(() {});
              },
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
