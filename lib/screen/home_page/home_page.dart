import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytenera/components/build_image.dart';
import 'package:mytenera/components/neumorphism_button.dart';
import 'package:mytenera/data_service/database_manager.dart';
import 'package:mytenera/screen/add_auction_page/add_auction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String routeName = "/home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              autionList.isEmpty
                  ? Column(
                      children: const [
                        SizedBox(height: 200),
                        CircularProgressIndicator(),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text("  Trending",
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(width: 10),
                            SvgPicture.asset("assets/icons/fire.svg",
                                height: 30),
                          ],
                        ),
                        const SizedBox(height: 25),
                        CarouselSlider.builder(
                            itemCount: autionList.length,
                            itemBuilder: (context, index, realIndex) {
                              final id = autionList[index]["ID"];
                              final name = autionList[index]["Name"];
                              final description =
                                  autionList[index]["Description"];
                              final endDate = autionList[index]["EndDate"];
                              final endTime = autionList[index]["EndTime"];
                              final postedBy = autionList[index]["DisplayName"];
                              final urlImage = autionList[index]["Photo"];
                              final urlDocument = autionList[index]["Document"];
                              final startingPrice =
                                  autionList[index]["StartingPrice"];

                              return buildImage(
                                  context,
                                  id,
                                  name,
                                  description,
                                  endDate,
                                  endTime,
                                  postedBy,
                                  urlImage,
                                  urlDocument,
                                  startingPrice);
                            },
                            options: CarouselOptions(
                              height: 400,
                              viewportFraction: .85,
                              autoPlay: true,
                            )),
                      ],
                    ),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AddAuction.routeName),
                child: neumorphismButton(
                    context, Icons.add_circle_outline, "Post an Auction"),
              ),
              const SizedBox(height: 50),
            ],
          )),
    );
  }
}
