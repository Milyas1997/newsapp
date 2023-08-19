import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/common_widget/categoriesnews_builder.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/repository/get_headline.dart';
import 'package:news_app/screen/categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { arynews, bbcnews, independent, alJazerra, retures, cnn }

class _HomeScreenState extends State<HomeScreen> {
  final format = DateFormat('MMM dd,yyyy');
  FilterList? selectedMenu;
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            onSelected: (FilterList item) {
              if (FilterList.bbcnews.name == item.name) {
                name = 'bbc-news';
              }
              if (FilterList.arynews.name == item.name) {
                name = 'ary-news';
              }
              if (FilterList.cnn.name == item.name) {
                name = "cnn";
              }

              if (FilterList.alJazerra.name == item.name) {
                name = 'al-jazeera-english';
              }
              setState(() {});
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem(
                value: FilterList.bbcnews,
                child: Text("BBC news"),
              ),
              const PopupMenuItem(
                value: FilterList.arynews,
                child: Text("Ary news"),
              ),
              const PopupMenuItem(
                value: FilterList.alJazerra,
                child: Text("Aljazerra news"),
              ),
              const PopupMenuItem(
                value: FilterList.cnn,
                child: Text("Cnn news"),
              ),
            ],
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoriesScreen(),
              ),
            );
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            height: 25,
            width: 25,
          ),
        ),
        title: Text(
          'NEWS',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: double.infinity,
                child: FutureBuilder<NewsModel>(
                  future: GetHeadlineApi().getHeadline(name),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        final height = MediaQuery.sizeOf(context).height * 1;
                        final width = MediaQuery.sizeOf(context).width * 1;
                        final DateTime dateTime = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt
                              .toString(),
                        );

                        return Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: height * 0.5,
                              width: width * 0.9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  placeholder: (context, url) =>
                                      const SpinKitCircle(
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  errorWidget: ((context, url, error) =>
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      )),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 10,
                              right: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  //padding: const EdgeInsets.symmetric(horizontal: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: height * 0.22,
                                  width: width * 0.55,

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const CategoryiesNewsBuilder(
                selectCategory: 'General',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
