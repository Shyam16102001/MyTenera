import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';
import 'package:mytenera/data_service/database_manager.dart';
import 'package:mytenera/screen/auction_page/auction_detail_page.dart';

class AuctionPage extends StatefulWidget {
  const AuctionPage({super.key});
  static String routeName = "/aution_page";

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  List autionList = [];

  @override
  void initState() {
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic result = await DataBaseManager().getAuctionList();
    result.removeWhere(
        (item) => item["PostedBy"] == FirebaseAuth.instance.currentUser!.email);

    if (result == null) {
    } else {
      setState(() {
        autionList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: autionList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetchDatabaseList();
                });
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.80,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 16),
                itemCount: autionList.length,
                itemBuilder: (context, index) {
                  final id = autionList[index]["ID"];
                  final name = autionList[index]["Name"];
                  final description = autionList[index]["Description"];
                  final endDate = autionList[index]["EndDate"];
                  final endTime = autionList[index]["EndTime"];
                  final postedBy = autionList[index]["DisplayName"];
                  final urlImage = autionList[index]["Photo"];
                  final urlDocument = autionList[index]["Document"];
                  final startingPrice =
                      int.parse(autionList[index]["StartingPrice"]);

                  return buildList(context, id, name, description, endDate,
                      endTime, postedBy, urlImage, urlDocument, startingPrice);
                },
              ),
            ),
    ));
  }

  Widget buildList(
      BuildContext context,
      String id,
      String name,
      String description,
      String endDate,
      String endTime,
      String postedBy,
      String urlImage,
      String urlDocument,
      int startingPrice) {
    return Ink(
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
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        enableFeedback: true,
        highlightColor: kPrimaryLightColor,
        splashColor: Colors.indigo,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AuctionDetailPage(
                      id: id,
                      name: name,
                      description: description,
                      endDate: endDate,
                      endTime: endTime,
                      postedBy: postedBy,
                      urlImage: urlImage,
                      startingPrice: startingPrice,
                      urlDocument: urlDocument)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(
                  urlImage,
                  width: 175,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                postedBy,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(color: kSecondaryColor),
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "$endDate $endTime",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .merge(const TextStyle(color: kBackgroundColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
