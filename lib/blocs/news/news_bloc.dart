import 'package:bloc_learn/blocs/news/news_event.dart';
import 'package:bloc_learn/blocs/news/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/repositories.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final UserRepository _newsRepository;

  NewsBloc(this._newsRepository) : super(NewsLoadingState()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final news = await _newsRepository.getNews();
        emit(NewsLoadedState(news));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
