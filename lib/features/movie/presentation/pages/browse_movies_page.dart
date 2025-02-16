import 'package:flutter/material.dart';

class BrowseMoviesPage extends StatelessWidget {
  const BrowseMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> movieList = List.generate(10, (int i) => "Movie $i");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: Text("Browse Movies"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Durations.long1);
        },
        child: ListView.builder(
          itemCount: movieList.length,
          prototypeItem: ListTile(title: Text(movieList.first)),
          itemBuilder: (context, index) {
            return ListTile(title: Text(movieList[index]));
          },
        ),
      ),
    );
  }
}
