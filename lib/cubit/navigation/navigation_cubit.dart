import 'package:bloc/bloc.dart';

enum Navigation { HOME, TICKET, SETTINGS }

class NavigationCubit extends Cubit<Navigation> {
  NavigationCubit() : super(Navigation.HOME);

  void setNavigation(Navigation navigation) {
    emit(navigation);
  }
}
