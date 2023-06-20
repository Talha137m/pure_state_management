import 'package:flutter/material.dart';

import 'album_api_provider.dart';
import 'album_model.dart';


@immutable
abstract class AlbumState {}
@immutable
class AlbumInitialState extends AlbumState {}
@immutable
class AlbumLoadingState extends AlbumState {}
@immutable
class AlbumLoadedState extends AlbumState {
  final List<AlbumModelClass> albums;
  AlbumLoadedState({
    required this.albums,
  });
}

class AlbumErrorState extends AlbumState {
  final String message;
  AlbumErrorState({
    required this.message,
  });
}

class AlbumData extends ValueNotifier<AlbumState> {
  AlbumData():super(AlbumInitialState());
   Future<dynamic> albumsFetch() async {
    AlbumProvider albumProvider = AlbumProvider();
    try {
      value = AlbumLoadingState();
      var data = await albumProvider.fetchAlbums();
      value = AlbumLoadedState(albums: data);
    } catch (e) {
      value = AlbumErrorState(
        message: e.toString(),
      );
    }
  }
}




class IncrementValue extends ValueNotifier<int> {
  IncrementValue():super(0);
  void increment(){
    value++;
    print(value);
  }
}