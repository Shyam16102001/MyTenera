import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';
import 'package:mytenera/screen/auction_page/auction_detail_page.dart';

Widget buildImage(
    BuildContext context,
    String id,
    String name,
    String description,
    String endDate,
    String endTime,
    String postedBy,
    String urlImage,
    String urlDocument,
    String startingPrice) {
  return InkWell(
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
                  startingPrice: int.parse(startingPrice),
                  urlDocument: urlDocument)));
    },
    borderRadius: BorderRadius.circular(25),
    splashColor: kSecondaryColor,
    child: Container(
      height: 400,
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              urlImage,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (name.length > 8) ? "${name.substring(0, 7)}..." : name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      (postedBy.length > 16)
                          ? "${postedBy.substring(0, 15)}..."
                          : postedBy,
                    ),
                  ],
                ),
                Text(
                  "₹ $startingPrice",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
