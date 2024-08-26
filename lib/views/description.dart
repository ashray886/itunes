import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itunes/config/colors.dart';
import 'package:itunes/helpers/common_helpers.dart';
import 'package:itunes/views/results.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DescriptionScreen extends StatelessWidget {
  final ValuesToShow values;

  const DescriptionScreen({super.key, required this.values});

  onButtonPressed(context) {
    String url = '';
    if (values.result.trackViewUrl != null) {
      url = values.result.trackViewUrl!;
    } else if (values.result.collectionViewUrl != null) {
      url = values.result.collectionViewUrl!;
    } else if (values.result.artistLinkUrl != null) {
      url = values.result.artistLinkUrl!;
    }
    openUrl(Uri.parse(url), context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(("Description")),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                          child: Image.asset("assets/images/placeholder.png",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          values.result.primaryGenreName ??
                              values.result.genres!.take(2).join(" , "),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ITunesColors.yellowColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                                label: const Text("Preview"),
                                onPressed: () {
                                  onButtonPressed(context);
                                },
                                iconAlignment: IconAlignment.end,
                                icon: const Icon(
                                  Icons.explore_outlined,
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (values.result.previewUrl != null)
              WebViewScren(
                url: values.result.previewUrl!,
              ),
            if (values.result.description != null ||
                values.result.longDescription != null)
              DescriptionWidget(
                description: values.result.description ??
                    values.result.longDescription ??
                    "",
              )
          ]),
        ));
  }
}

class WebViewScren extends StatefulWidget {
  final String url;
  const WebViewScren({super.key, required this.url});
  @override
  State<WebViewScren> createState() => WebViewScrenState();
}

class WebViewScrenState extends State<WebViewScren> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ITunesColors.darkGreyColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (url) {
            _controller.runJavaScript("""
              document.querySelectorAll('video, audio').forEach(media => {
                media.pause();
                media.removeAttribute('autoplay');
              });
            """);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Preview",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                  height: 200, child: WebViewWidget(controller: _controller))),
        ],
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String description;
  const DescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            "Description",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ]));
  }
}
