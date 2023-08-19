import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../common_widget/categoriesnews_builder.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final format = DateFormat('MMM dd,yyyy');
  List categoriesList = [
    'General',
    'Health',
    'Sports',
    'Entertainment',
    'Business',
    'Technology'
  ];
  String selectedCategory = 'General';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedCategory = categoriesList[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: selectedCategory == categoriesList[index]
                                  ? Colors.blue
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Center(
                                child: Text(
                                  categoriesList[index],
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CategoryiesNewsBuilder(
                selectCategory: selectedCategory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
