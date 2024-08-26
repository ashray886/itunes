import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:itunes/viewmodels/search_notifier.dart';

class EntitiesScreen extends ConsumerStatefulWidget {
  const EntitiesScreen({required this.media, super.key});
  final String media;

  @override
  EntitiesScreenState createState() => EntitiesScreenState();
}

class EntitiesScreenState extends ConsumerState<EntitiesScreen> {
  List<String> mediaMovieEntities = ["movieArtist", "movie"];
  List<String> mediaPodcastEntities = ["podcastAuthor", "podcast"];
  List<String> mediaMusicEntities = [
    "musicArtist",
    "musicTrack",
    "album",
    "musicVideo",
    "mix",
    "song"
  ];
  List<String> mediaMusicVideoEntities = ["musicArtist", "musicVideo"];
  List<String> mediaAudiobookEntities = ["audiobookAuthor", "audiobook"];
  List<String> mediaShortFilmEntities = ["shortFilmArtist", "shortFilm"];
  List<String> mediaTvShowEntities = ["tvEpisode", "tvSeason"];
  List<String> mediaEbookEntities = ["ebook"];

  List<String> mediaSoftwareEntities = [
    "software",
    "iPadSoftware",
    "macSoftware"
  ];
  List<String> mediaAllEntities = [
    "movie",
    "album",
    "allArtist",
    "podcast",
    "musicVideo",
    "mix",
    "audiobook",
    "tvSeason",
    "allTrack"
  ];
  List<String> selectedItems = [];
  List<String> items = [];
  bool isSelectedAll = false;
  @override
  void initState() {
    initializeValues();
    super.initState();
  }

  initializeValues() {
    Map<String, List<String>> map =
        ref.read(searchNotifierProvider.notifier).entitiesMap;
    setState(() {
      setItems();
      if (map.isNotEmpty) {
        if (map.containsKey(widget.media)) {
          selectedItems.addAll(map[widget.media]!);
          if (selectedItems.length == items.length) {
            isSelectedAll = true;
          }
        }
      }
    });
  }

  setItems() {
    String media = widget.media;
    return switch (media) {
      "movie" => items = mediaMovieEntities,
      "podcast" => items = mediaPodcastEntities,
      "music" => items = mediaMusicEntities,
      "musicVideo" => items = mediaMusicVideoEntities,
      "audiobook" => items = mediaAudiobookEntities,
      "shortFilm" => items = mediaShortFilmEntities,
      "tvShow" => items = mediaTvShowEntities,
      "software" => items = mediaSoftwareEntities,
      "ebook" => items = mediaEbookEntities,
      "all" => items = mediaAllEntities,
      String() => items = [],
    };
  }

  updateValues() {
    if (selectedItems.isNotEmpty) {
      ref.read(searchNotifierProvider.notifier).entitiesMap[widget.media] =
          selectedItems;
    } else {
      if (ref
          .read(searchNotifierProvider.notifier)
          .entitiesMap
          .containsKey(widget.media)) {
        ref
            .read(searchNotifierProvider.notifier)
            .entitiesMap
            .remove(widget.media);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        updateValues();
        context.pop(true);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              updateValues();
              context.pop(true);
            },
          ),
          title: Text(toBeginningOfSentenceCase(widget.media)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        isSelectedAll = !isSelectedAll;
                        selectedItems.clear();
                        if (isSelectedAll) {
                          selectedItems.addAll(items);
                        }
                      });
                    },
                    child:
                        Text("${isSelectedAll ? "Deselect" : "Select"} All")),
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 5),
                itemCount: items.length + 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    return Container();
                  }
                  return ListTile(
                      selected: selectedItems.contains(items[index]),
                      trailing: selectedItems.contains(items[index])
                          ? const Icon(Icons.check)
                          : null,
                      title: Text(toBeginningOfSentenceCase(items[index])),
                      onTap: () {
                        setState(() {
                          if (selectedItems.contains(items[index])) {
                            selectedItems.remove(items[index]);
                          } else {
                            selectedItems.add(items[index]);
                          }
                        });
                      });
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
