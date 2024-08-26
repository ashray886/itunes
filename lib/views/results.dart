import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:itunes/config/colors.dart';
import 'package:itunes/models/itunes_model.dart';
import 'package:itunes/viewmodels/search_notifier.dart';
import 'package:itunes/views/results_grid_view.dart';
import 'package:itunes/views/results_list_view.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  const ResultsScreen({super.key});

  @override
  ResultsScreenState createState() => ResultsScreenState();
}

class ResultsScreenState extends ConsumerState<ResultsScreen> {
  String selectedLayout = "grid";

  late ITunesModel model;
  List<ITunesResultsList>? results;
  List<ShowValuesWithHeader> valuesList = [];
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    model = ref.read(searchNotifierProvider).response;
    results = model.results;
    results!.sort((a, b) {
      int wrapperComparison = a.wrapperType!.compareTo(b.wrapperType!);
      if (wrapperComparison != 0) {
        return wrapperComparison;
      }
      return a.kind!.compareTo(b.kind!);
    });

    List<ValuesToShow> valuesToShowList = [];
    for (int i = 0; i < results!.length; i++) {
      if (i != results!.length - 1 &&
          results![i].kind == results![i + 1].kind) {
        valuesToShowList
            .add(addValuesToShowList(result: results![i], index: i));
      } else {
        valuesToShowList
            .add(addValuesToShowList(result: results![i], index: i));
        valuesList.add(ShowValuesWithHeader(
            header: toBeginningOfSentenceCase(results![i].kind!),
            itemsList: valuesToShowList));
        valuesToShowList = [];
      }
    }
  }

  ValuesToShow addValuesToShowList(
      {required ITunesResultsList result, required int index}) {
    String title = "";
    String description = "";
    String image = "";
    if (result.wrapperType != "artist" &&
        result.wrapperType != "collection" &&
        result.wrapperType != "audiobook") {
      title = result.trackName ?? "";
      description = result.artistName ?? "";
      image = result.artworkUrl100 ?? "";
    } else {
      title = result.artistName ?? "";
      image = result.artworkUrl100 ?? "";
    }
    return ValuesToShow(
        result: result, title: title, description: description, image: image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(("iTunes")),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: ITunesColors.darkGreyColor),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    key: const ValueKey("gridView"),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        backgroundColor: selectedLayout == "grid"
                            ? ITunesColors.lightGreyColor
                            : Colors.transparent),
                    onPressed: () {
                      setState(() {
                        selectedLayout = "grid";
                      });
                    },
                    child: const Text('Grid Layout'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    key: const ValueKey("listView"),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        backgroundColor: selectedLayout == "list"
                            ? ITunesColors.lightGreyColor
                            : Colors.transparent),
                    onPressed: () {
                      setState(() {
                        selectedLayout = "list";
                      });
                    },
                    child: const Text('List Layout'),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          if (selectedLayout == "grid")
            Expanded(
                child: ResultsGridViewScreen(
              valuesList: valuesList,
            )),
          if (selectedLayout == "list")
            Expanded(
                child: ResultsListViewScreen(
              valuesList: valuesList,
            ))
        ],
      ),
    );
  }
}

class ValuesToShow {
  final String title;
  final String description;
  final String image;
  final ITunesResultsList result;

  ValuesToShow(
      {required this.result,
      required this.title,
      this.description = '',
      this.image = ''});
}

class ShowValuesWithHeader {
  final String header;
  final List<ValuesToShow> itemsList;

  ShowValuesWithHeader({required this.header, required this.itemsList});
}
