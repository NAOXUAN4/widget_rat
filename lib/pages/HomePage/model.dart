class HomePageState{
  final bool isLoading;

  HomePageState({
    this.isLoading = true
  });

  HomePageState copyWith({bool? isLoading}){
    return HomePageState(
      isLoading: isLoading ?? this.isLoading
    );
  }
}