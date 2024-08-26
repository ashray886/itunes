import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:itunes/config/colors.dart';
import 'package:itunes/config/route_path.dart';
import 'package:itunes/helpers/common_helpers.dart';
import 'package:itunes/helpers/services/api/api_response_state.dart';
import 'package:itunes/viewmodels/search_notifier.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  String searchDescription =
      "Search for a variety of content from the iTunes store including iBooks, movies, podcast,"
      "music, music videos, and audiobooks.";
  String parametedDescription =
      "Specify the parameter for the content to be searched.";
  List<String> selectedParameters = [];
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  onButtonPressed({required BuildContext context}) {
    if (_formKey.currentState!.validate()) {
      String params = "term=${Uri.encodeFull(searchController.text)}";
      ref.read(searchNotifierProvider.notifier).getSearch(params: params);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ref.listen<ResponseState>(searchNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.head == "search") {
        if (next.isLoading!) {
          showProgress(context);
        } else if (next.isError! && !next.isLoading!) {
          Navigator.pop(context);
          showMessage(context, next.errorMessage!);
        } else {
          Navigator.pop(context);
          context.pushNamed(RoutePath.results.name);
        }
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: screenSize.height * 0.12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: screenSize.width * 0.3,
                      color: ITunesColors.whiteColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  searchDescription,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  key: const ValueKey("search"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field can't be empty!";
                    } else {
                      return null;
                    }
                  },
                  controller: searchController,
                  decoration: const InputDecoration(
                      hintText: "Search",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  parametedDescription,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: ITunesColors.darkGreyColor),
                  padding: const EdgeInsets.all(10),
                  child: const ParameterFilters(),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  key: const ValueKey("submit"),
                  onPressed: () {
                    onButtonPressed(context: context);
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ParameterFilters extends ConsumerStatefulWidget {
  const ParameterFilters({super.key});
  @override
  ParameterFiltersState createState() => ParameterFiltersState();
}

class ParameterFiltersState extends ConsumerState<ParameterFilters> {
  List<String> selectedParameters = [];
  List<String> parametersList = [
    "all",
    "movie",
    "podcast",
    "music",
    "musicVideo",
    "audiobook",
    "shortFilm",
    "tvShow",
    "software",
    "ebook"
  ];

  @override
  void initState() {
    initializeValues();
    super.initState();
  }

  initializeValues() {
    selectedParameters.clear();
    Map<String, List<String>> map =
        ref.read(searchNotifierProvider.notifier).entitiesMap;
    setState(() {
      if (map.isNotEmpty) {
        selectedParameters.addAll(map.keys);
      }
    });
  }

  onPressed({required String media}) async {
    var res = await context.pushNamed(RoutePath.entities.name, extra: media);
    if (res != null) {
      initializeValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 12, alignment: WrapAlignment.center, children: [
      for (String item in parametersList)
        FilterChip(
          showCheckmark: false,
          labelPadding: const EdgeInsets.symmetric(horizontal: 3),
          labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: selectedParameters.contains(item)
                  ? FontWeight.w600
                  : FontWeight.w500,
              color: selectedParameters.contains(item)
                  ? ITunesColors.blackColor
                  : ITunesColors.whiteColor),
          label: Text(toBeginningOfSentenceCase(item)),
          onSelected: (val) {
            onPressed(media: item);
          },
          selected: selectedParameters.contains(item),
        )
    ]);
  }
}
