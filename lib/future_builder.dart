import 'package:cramming_poems/Data/poem_list.dart';
import 'package:flutter/material.dart';
import 'package:cramming_poems/home.dart';

class FutureBuilderHome extends StatefulWidget {
  const FutureBuilderHome({super.key});

  @override
  State<FutureBuilderHome> createState() => _FutureBuilderHome();
}

// класс для ожидания загрузки стихов из памяти (можно грузить что угодно до основного экрана)
class _FutureBuilderHome extends State<FutureBuilderHome> {
  Future<bool> _loading () async{
    poemList = await PoemList.create();  // загрузка предыдущих стихов
    //await Future.delayed(Duration(seconds: 5));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<bool>(
        future: _loading(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
                    child: Text('Ошибка: ${snapshot.error}'),
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
                    child: Text('Загрузка стихов...'),
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
