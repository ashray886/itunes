import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itunes/config/colors.dart';
import 'package:itunes/config/route_path.dart';
import 'package:itunes/views/results.dart';
import 'package:itunes/views/results_grid_view.dart';

class ResultsListViewScreen extends StatelessWidget {
  final List<ShowValuesWithHeader> valuesList;

  const ResultsListViewScreen({super.key, required this.valuesList});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView.builder(
        itemCount: valuesList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderWidget(header: valuesList[index].header),
              for (ValuesToShow values in valuesList[index].itemsList)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      context.pushNamed(RoutePath.description.name,
                          extra: values);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: values,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              height: screenSize.height * 0.15,
                              width: screenSize.width * 0.25,
                              fit: BoxFit.fitHeight,
                              imageUrl: values.image,
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ITunesColors.lightGreyColor,
                                ),
                                child: Image.asset(
                                  "assets/images/placeholder.png",
                                  color: ITunesColors.whiteColor,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ITunesColors.lightGreyColor,
                                ),
                                child: Image.asset(
                                    "assets/images/placeholder.png",
                                    color: ITunesColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                values.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                values.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          );
        });
  }
}
