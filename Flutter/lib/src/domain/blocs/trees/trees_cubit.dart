import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_it/src/domain/blocs/geo_location/geo_location_cubit.dart';
import 'package:green_it/src/domain/models/trees_model.dart';
import 'package:green_it/src/domain/repositories/trees_repository.dart';
import 'package:injectable/injectable.dart';

abstract class TreeState extends Equatable {}

class InitialState extends TreeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends TreeState {
  @override
  List<Object> get props => [];
}

class LoadedState extends TreeState {
  final DataSet trees;

  LoadedState(this.trees);

  @override
  List<Object> get props => [trees];
}

class ErrorState extends TreeState {
  @override
  List<Object> get props => [];
}

@injectable
class TreesCubit extends Cubit<TreeState> {
  final GeoLocationCubit _geoLocation;
  final TreesRepository _treesRepository;
  TreesCubit(this._treesRepository, @factoryParam this._geoLocation) : super(InitialState()) {
    getTreesInParis();
  }

  void getTreesInParis() async {
    try {
      emit(LoadingState());
      final DataSet trees = await _treesRepository.getTreesInParis();
      emit(LoadedState(trees));
      _geoLocation.getCurrentLocation();
    } catch (e) {
      emit(ErrorState());
    }
  }
}
