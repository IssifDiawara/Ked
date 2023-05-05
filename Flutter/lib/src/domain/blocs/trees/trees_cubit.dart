import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final TreesRepository _treesRepository;
  TreesCubit(this._treesRepository) : super(InitialState()) {
    getTreesInParis();
  }

  void getTreesInParis() async {
    try {
      emit(LoadingState());
      final DataSet trees = await _treesRepository.getTreesInParis();
      emit(LoadedState(trees));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
