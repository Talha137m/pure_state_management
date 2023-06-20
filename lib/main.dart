import 'package:flutter/material.dart';
import 'package:pure_state_management/value_notifier.dart';

import 'album_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AlbumData albumData=AlbumData();

  void _incrementCounter() {
    albumData.albumsFetch();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(valueListenable: albumData, builder: (context, value, child) {
        if (value is AlbumInitialState) {
          return const InitialStatePage();
        }
        else if(value is AlbumLoadingState){
          return const LoadingStatePage();
        }
        else if(value is AlbumLoadedState){
          return LoadedStatePage(list: value.albums);
        }
        else{
          return ErrorStatePage(message: (value as AlbumErrorState).message);
        }
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}




class InitialStatePage extends StatelessWidget {
  const InitialStatePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
           Text('click here to load data'),
        ],
      ),
    );
  }
}

class LoadingStatePage extends StatelessWidget {
  const LoadingStatePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }
}


class LoadedStatePage extends StatelessWidget {
  const LoadedStatePage({super.key, required this.list});
  final List<AlbumModelClass> list;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Text(
              list[index].id.toString(),
            ),
            title: Text(
              list[index].title.toString(),
            ),
            trailing: Text(
              list[index].userId.toString(),
            ),
          ),
        );
      },
    );
  }
}

class ErrorStatePage extends StatelessWidget {
  const ErrorStatePage({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        child: Text(message),
      ),
    );
  }
}