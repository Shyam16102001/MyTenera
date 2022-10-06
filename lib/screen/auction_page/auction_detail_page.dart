import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class AuctionDetailPage extends StatelessWidget {
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                urlImage,
                height: 350,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      "by $postedBy",
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
                      description,
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
                    onTap: () =>
                        openFile(url: urlDocument, fileName: "$id.pdf"),
                    child: button(context, "Document",
                        Icons.file_download_outlined, false),
                  ),
                  button(context, "Place a bid", Icons.gavel, true),
                ],
              ),
              const SizedBox(height: 20),
            ],
          )),
    );
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$name");
    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    OpenFilex.open(file.path);
    // final Uri uri = Uri.file(file.path);
    // await launchUrl(uri);
    // if (!File(uri.toFilePath()).existsSync()) {
    //   throw '$uri does not exist!';
    // }
    // if (!await launchUrl(uri)) {
    //   throw 'Could not launch $uri';
    // }
  }

  Widget button(BuildContext context, String text, IconData icon, bool dark) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 175,
      decoration: BoxDecoration(
        color: dark ? kPrimaryColor : kBackgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          const BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1),
          BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: dark ? kBackgroundColor : kPrimaryColor,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: dark
                ? Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .merge(const TextStyle(color: kBackgroundColor))
                : Theme.of(context).textTheme.titleLarge!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
