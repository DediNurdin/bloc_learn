import 'package:bloc_learn/blocs/login/login_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(UserRepository()),
        ),
        BlocProvider<NewsBloc>(
          create: (BuildContext context) => NewsBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('News')),
        body: blocBodyListNews(),
      ),
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
            return const Center(
              child: CircularProgressIndicator(),
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
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                  '${newsList[index].thumbnail}',
                                  fit: BoxFit.cover,
                                )),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${newsList[index].title}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${newsList[index].description}',
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
