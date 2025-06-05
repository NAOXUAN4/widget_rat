import '../../api/dataClass/Posts_List_data.dart';

class ComListState {
  final List<PostsListDataItem> postsList;
  final bool isLoading;

  ComListState({required this.postsList, this.isLoading = false});
}