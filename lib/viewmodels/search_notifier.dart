import 'package:itunes/helpers/services/api/api_repository.dart';
import 'package:itunes/helpers/services/api/api_response_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_notifier.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  late final ApiRepository _apiRepository;
  Map<String, List<String>> entitiesMap = {};
  @override
  ResponseState build() {
    _apiRepository = ApiRepository();
    return (ResponseState(isLoading: false, isError: false));
  }

  Future<void> getSearch({bool init = true, required String params}) async {
    try {
      state = state.copyWith(
          isLoading: init ? true : false, head: "search", isError: false);

      if (entitiesMap.isNotEmpty) {
        //params += "&media=${entitiesMap.keys.join(",")}";

        List<String> entitiesList = [];
        entitiesMap.forEach((key, value) {
          params += "&media=$key";
          entitiesList.addAll(value);
        });

        var seen = <String>{};
        List<String> uniquelist =
            entitiesList.where((values) => seen.add(values)).toList();
        params += "&entity=${uniquelist.join(",")}";

        // entitiesMap.forEach((key, value) {
        //   params += "&entity=";
        //   params += value.join(",");
        //   // for (int i = 0; i < value.length; i++) {
        //   //   params += "&entity=${value[i]}";
        //   // }
        // });
      }
      final result = await _apiRepository.fetchSearch(params: params);
      state =
          state.copyWith(response: result, isLoading: false, isError: false);
    } catch (e) {
      state = state.copyWith(
          errorMessage: e.toString(),
          isLoading: false,
          isError: true,
          response: []);
    }
  }
}
