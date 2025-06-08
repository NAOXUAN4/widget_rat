import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/pages/HomePage/model.dart';


final homePageNotifierProvider = StateNotifierProvider<homePageNotifier,HomePageState>(
    (ref) => homePageNotifier(),
);


class homePageNotifier extends StateNotifier<HomePageState>{
  homePageNotifier() : super(HomePageState(
    isLoading: true
  ));

}


