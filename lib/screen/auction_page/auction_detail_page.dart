import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytenera/components/button.dart';
import 'package:mytenera/config/constants.dart';
import 'package:mytenera/config/size_config.dart';
import 'package:mytenera/data_service/database_manager.dart';
import 'package:mytenera/data_service/file_download.dart';

class AuctionDetailPage extends StatefulWidget {
  AuctionDetailPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.description,
      required this.endDate,
      required this.endTime,
      required this.postedBy,
      required this.urlImage,
      required this.startingPrice,
      required this.urlDocument,
      required this.self})
      : super(key: key);

  static String routeName = "/auction_details";
  String id;
  String name;
  String description;
  String endDate;
  String endTime;
  String postedBy;
  String urlImage;
  int startingPrice;
  String urlDocument;
  bool self;

  @override
  State<AuctionDetailPage> createState() => _AuctionDetailPageState();
}

class _AuctionDetailPageState extends State<AuctionDetailPage> {
  late TextEditingController controller;
  late double amount;
  List bidList = [];

  @override
  void initState() {
    controller = TextEditingController();
    fetchBiddingList();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  fetchBiddingList() async {
    var result = await DataBaseManager().getBiddingList(widget.id);
    if (result == null) {
    } else {
      setState(() {
        bidList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  size: 32,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              // height: MediaQuery.of(context).size.height - 30,
              height: getProportionateScreenHeight(785),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.urlImage,
                    height: getProportionateScreenHeight(350),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          "by ${widget.postedBy}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(12),
                        vertical: getProportionateScreenWidth(3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Desciption",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "  Current Bids",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  bidList.isEmpty
                      ? Center(
                          child: Text(
                          "You are the first one to place the bid.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ))
                      : SizedBox(
                          height: getProportionateScreenHeight(90),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              setState(() {
                                fetchBiddingList();
                              });
                            },
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: bidList.length,
                                itemBuilder: (context, index) => currentBidList(
                                    context,
                                    bidList[index]["Email"],
                                    bidList[index]["Name"],
                                    bidList[index]["Amount"].toInt())),
                          ),
                        ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  widget.self
                      ? Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: kSecondaryColor,
                            onTap: () => openFile(
                                url: widget.urlDocument,
                                fileName: "${widget.id}.pdf"),
                            child: button(context, "Document",
                                Icons.file_download_outlined, false, 300),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: kSecondaryColor,
                              onTap: () => openFile(
                                  url: widget.urlDocument,
                                  fileName: "${widget.id}.pdf"),
                              child: button(context, "Document",
                                  Icons.file_download_outlined, false, 175),
                            ),
                            InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: kPrimaryLightColor,
                                onTap: () async {
                                  final value = await popUpDialog(context);

                                  if (value == null || value.isEmpty) {
                                    showBanner("Enter the amount");
                                    return;
                                  }
                                  try {
                                    amount = double.parse(value);

                                    if (amount < widget.startingPrice) {
                                      showBanner(
                                          "Enter the amount greater than the starting price");
                                      return;
                                    }
                                    if (amount > 100000000) {
                                      showBanner(
                                          "The amount entered is too large");
                                      return;
                                    }
                                    FirebaseFirestore.instance
                                        .collection("Auction")
                                        .doc(widget.id)
                                        .collection("Bidding")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .set({
                                      "Name": FirebaseAuth
                                          .instance.currentUser!.displayName,
                                      "Email": FirebaseAuth
                                          .instance.currentUser!.email,
                                      "Amount": amount,
                                    }).then((value) => fetchBiddingList());
                                    // }).then((value) => Navigator.pop(context));
                                  } catch (e) {
                                    showBanner("Please Enter only numbers");
                                    return;
                                  }
                                },
                                child: button(context, 'Place a bid',
                                    Icons.gavel, true, 175)),
                          ],
                        ),
                  SizedBox(height: getProportionateScreenHeight(45)),
                ],
              ),
            ),
          )),
    );
  }

  Widget currentBidList(
      BuildContext context, String email, String name, int amount) {
    // print(data);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      // color: kSecondaryColor,
      decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade600,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1),
          ]),
      // height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                email.length > 30 ? "${email.substring(0, 20)}..." : email,
              ),
            ],
          ),
          Text(
            "₹ $amount",
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }

  void showBanner(String error) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
            height: 50,
            child: Column(
              children: [
                Text(
                  "Oh snap!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .merge(const TextStyle(color: kBackgroundColor)),
                ),
                const Spacer(),
                Text(
                  error,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFFC72C41),
        elevation: 0,
      ));

  Future<String?> popUpDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Enter your bid amount"),
              icon: const Icon(Icons.gavel),
              content: TextField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  prefix: Text("₹ "),
                ),
                keyboardType: TextInputType.number,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineSmall,
                onSubmitted: (_) => submit(),
              ),
              actions: [
                TextButton(onPressed: submit, child: const Text("Submit")),
              ],
            ));
  }

  void submit() {
    Navigator.pop(context, controller.text);
    controller.clear();
  }
}
