import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';
import 'package:nenda_invfest/services/pendakian_service.dart';

part 'pendakian_state.dart';

class PendakianCubit extends Cubit<PendakianState> {
  PendakianCubit() : super(PendakianInitial());

  void fetchPendakian() async {
    try {
      emit(PendakianLoading());
      List<PendakianModel> _data = await PendakianService().fetchPendakian();
      emit(PendakianSuccess(_data));
    } catch (e) {
      emit(PendakianError(e.toString()));
    }
  }
}
