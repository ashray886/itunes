import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_grid_view/group_grid_view.dart';
import 'package:itunes/config/colors.dart';
import 'package:itunes/config/route_path.dart';
import 'package:itunes/views/results.dart';

class ResultsGridViewScreen extends StatelessWidget {
  final List<ShowValuesWithHeader> valuesList;

  const ResultsGridViewScreen({super.key, required this.valuesList});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GroupGridView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 30,
            childAspectRatio: 0.6),
        sectionCount: valuesList.length,
        headerForSection: (section) =>
            HeaderWidget(header: valuesList[section].header),
        itemInSectionBuilder: (_, indexPath) {
          final data = valuesList[indexPath.section].itemsList[indexPath.index];
          return InkWell(
            key: ValueKey("grid_item_${indexPath.index}"),
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              context.pushNamed(RoutePath.description.name, extra: data);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: data,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      height: screenSize.height * 0.14,
                      fit: BoxFit.fitHeight,
                      imageUrl: data.image,
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
                        child: Image.asset("assets/images/placeholder.png",
                            color: ITunesColors.whiteColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
          );
        },
        itemInSectionCount: (section) => valuesList[section].itemsList.length);
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.header,
  });

  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ITunesColors.darkGreyColor,
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 15),
        child: Text(header,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600)));
  }
}
