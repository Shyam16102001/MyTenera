import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytenera/components/neumorphism_button.dart';
import 'package:mytenera/config/constants.dart';

class AddAuction extends StatefulWidget {
  const AddAuction({super.key});
  static String routeName = "/add_auction_page";

  @override
  State<AddAuction> createState() => _AddAuctionState();
}

class _AddAuctionState extends State<AddAuction> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  DateTime endDate = DateTime.now();
  TimeOfDay endTime = TimeOfDay.now();
  late String photo;
  late String document;
  late String price;
  String description = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post an Auction"),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    nameFormField(),
                    const SizedBox(height: 20),
                    dateTimeSelector(),
                    const SizedBox(height: 20),
                    priceFormField(),
                    const SizedBox(height: 20),
                    photoFormField(),
                    const SizedBox(height: 20),
                    documentFormField(),
                    const SizedBox(height: 20),
                    descriptionFormField(),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        if (_formKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection("Auction")
                              .doc()
                              .set({
                            "Name": name.toString(),
                            "EndDate":
                                DateFormat.yMMMd().format(endDate).toString(),
                            "EndTime": endTime.format(context).toString(),
                            "StartingPrice": price,
                            "Photo": photo.toString(),
                            "Document": document.toString(),
                            "Description": description,
                            "PostedBy":
                                FirebaseAuth.instance.currentUser!.email,
                            "DisplayName":
                                FirebaseAuth.instance.currentUser!.displayName
                          }).then((value) => Navigator.pop(context));
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? loading(context)
                          : neumorphismButton(context,
                              Icons.check_circle_outline_rounded, "Submit"),
                    )
                  ],
                ),
              )),
        ));
  }

  Container loading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                height: 30, width: 30, child: CircularProgressIndicator()),
            const SizedBox(width: 30),
            Text(
              "Loading ...",
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ));
  }

  Widget dateTimeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "End Date",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025));
                  if (newDate != null) {
                    setState(() {
                      endDate = newDate;
                    });
                  }
                },
                child: Text(
                  DateFormat.yMMMd().format(endDate),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "End Time",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              GestureDetector(
                onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (newTime != null) {
                    setState(() {
                      endTime = newTime;
                    });
                  }
                },
                child: Text(
                  endTime.format(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        name = newValue!;
      }),
      onChanged: (value) => setState(() {
        name = value;
      }),
      validator: (name) {
        if (name == null || name.isEmpty) {
          return "Please enter the Project Name";
        }
        return null;
      },
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration(
        hintText: "Name",
        labelText: "Enter the Project Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.construction_outlined,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget priceFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => setState(() {
        price = newValue!;
      }),
      onChanged: (value) => setState(() {
        price = value;
      }),
      validator: (price) {
        if (price == null || price.isEmpty) {
          return "Please enter the Starting Price";
        }
        return null;
      },
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration(
        hintText: "Enter the Starting Price",
        labelText: "Starting Price",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.request_quote_outlined,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget photoFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      onSaved: (newValue) => setState(() {
        photo = newValue!;
      }),
      onChanged: (value) => setState(() {
        photo = value;
      }),
      validator: (photo) {
        if (photo == null || photo.isEmpty) {
          return "Please enter the Photo Url";
        }
        return null;
      },
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration(
        hintText: "Enter the Photo Url",
        labelText: "Photo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.image_outlined,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget documentFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      onSaved: (newValue) => setState(() {
        document = newValue!;
      }),
      onChanged: (value) => setState(() {
        document = value;
      }),
      validator: (document) {
        if (document == null || document.isEmpty) {
          return "Please enter the Document Url";
        }
        return null;
      },
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration(
        hintText: "Enter the Document Url",
        labelText: "Tender Document",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.description_outlined,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField descriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => setState(() {
        description = newValue!;
      }),
      onChanged: (value) => setState(() {
        description = value;
      }),
      validator: (name) {
        if (name == null || name.isEmpty) {
          return "Please enter the Project Description";
        }
        return null;
      },
      maxLines: 5,
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration(
        hintText: "Enter the description",
        labelText: "Description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
