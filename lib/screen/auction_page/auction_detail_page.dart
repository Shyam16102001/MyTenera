import 'package:flutter/material.dart';
import 'package:mytenera/components/button.dart';
import 'package:mytenera/config/constants.dart';
import 'package:mytenera/data_service/file_download.dart';

class AuctionDetailPage extends StatefulWidget {
  AuctionDetailPage({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.endDate,
    required this.endTime,
    required this.postedBy,
    required this.urlImage,
    required this.startingPrice,
    required this.urlDocument,
  }) : super(key: key);

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

  @override
  State<AuctionDetailPage> createState() => _AuctionDetailPageState();
}

class _AuctionDetailPageState extends State<AuctionDetailPage> {
  late TextEditingController controller;
  late double amount;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              height: MediaQuery.of(context).size.height - 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.urlImage,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
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
                  Text(
                    "  Current Bids",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                      height: 80,
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          Container(
                            height: 50,
                            color: Colors.amber[600],
                            child: const Center(child: Text('Entry A')),
                          ),
                          Container(
                            height: 50,
                            color: Colors.amber[500],
                            child: const Center(child: Text('Entry B')),
                          ),
                          Container(
                            height: 50,
                            color: Colors.amber[100],
                            child: const Center(child: Text('Entry C')),
                          ),
                        ],
                      )),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        splashColor: kSecondaryColor,
                        onTap: () => openFile(
                            url: widget.urlDocument,
                            fileName: "${widget.id}.pdf"),
                        child: button(context, "Document",
                            Icons.file_download_outlined, false),
                      ),
                      InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: kPrimaryLightColor,
                          // onTap: () {
                          //   showBanner("error");
                          // },

                          onTap: () async {
                            final value = await popUpDialog(context);

                            if (value == null || value.isEmpty) return;
                            try {
                              amount = double.parse(value);
                              print("sdfsf $amount");
                              if (amount < widget.startingPrice) {
                                showBanner(
                                    "Enter the amount greater than the starting price");
                              }
                            } catch (e) {
                              showBanner("Please Enter only numbers");
                            }
                          },
                          child: button(
                              context, 'Place a bid', Icons.gavel, true)),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )),
    );
  }

  void showBanner(String error) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            height: 50,
            child: Column(
              children: [
                Text(
                  "Oh snap!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .merge(TextStyle(color: kBackgroundColor)),
                ),
                Spacer(),
                Text(
                  error,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFFC72C41),
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
