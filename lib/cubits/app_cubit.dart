import 'package:bloc/bloc.dart';
import 'package:news_app/services/news_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._newsServices) : super(const AppInitialState());

  final NewsService _newsServices;
}
