import 'package:cramming_poems/Data/poem_list.dart';
import 'package:flutter/material.dart';
import 'package:cramming_poems/home.dart';

class FutureBuilderHome extends StatefulWidget {
  const FutureBuilderHome({super.key});

  @override
  State<FutureBuilderHome> createState() => _FutureBuilderHome();
}


class _FutureBuilderHome extends State<FutureBuilderHome> {
  Future<void> _loading () async{
    poemList = await PoemList.create();  // загрузка предыдущих стихов
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<void>(
        future: _loading(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = Home();
          } else if (snapshot.hasError) {
            children = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ],
              ),
            );
          } else {
            children = const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ],
              ),
            );
          }
          return children;
        },
      ),
    );
  }
}
