import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/repository/get_headline.dart';

class CategoryiesNewsBuilder extends StatefulWidget {
  const CategoryiesNewsBuilder({super.key, required this.selectCategory});
  final String selectCategory;

  @override
  State<CategoryiesNewsBuilder> createState() => _CategoryiesNewsBuilderState();
}

class _CategoryiesNewsBuilderState extends State<CategoryiesNewsBuilder> {
  final format = DateFormat('MMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: GetHeadlineApi().getCategory(widget.selectCategory),
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
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.articles!.length,
            itemBuilder: (context, index) {
              final DateTime dateTime = DateTime.parse(
                  snapshot.data!.articles![index].publishedAt.toString());
              final height = MediaQuery.sizeOf(context).height * 1;
              final width = MediaQuery.sizeOf(context).width * 1;

              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: height * 0.18,
                    width: width * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!.articles![index].urlToImage
                            .toString(),
                        placeholder: (context, url) => const SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                        errorWidget: ((context, url, error) => const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            )),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: height * 0.18,
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!.articles![index].title.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.articles![index].source!.name
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                format.format(dateTime).toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            },
          );
        }),
      ),
    );
  }
}
