import 'package:bloc_learn/blocs/news/news_bloc.dart';
import 'package:bloc_learn/blocs/news/news_event.dart';
import 'package:bloc_learn/blocs/news/news_state.dart';
import 'package:bloc_learn/model/news_model.dart';
import 'package:bloc_learn/repository/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: blocBodyListNews(),
    );
  }

  Widget blocBodyListNews() {
    return BlocProvider(
      create: (context) => NewsBloc(
        UserRepository(),
      )..add(LoadNewsEvent()),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade800,
              ),
            );
          }
          if (state is NewsLoadedState) {
            List<News> newsList = state.news;
            return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                        color: Colors.blue.shade800,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        '${newsList[index].thumbnail}',
                                      ))),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${newsList[index].title}',
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${newsList[index].description}',
                                  maxLines: 3,
                                  style: const TextStyle(color: Colors.yellow),
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                });
          }
          if (state is NewsErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
