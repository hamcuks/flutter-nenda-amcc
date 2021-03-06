import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';
import 'package:nenda_invfest/services/pendakian_service.dart';

part 'pendakian_state.dart';

class PendakianCubit extends Cubit<PendakianState> {
  PendakianCubit() : super(PendakianInitial());

  List<PendakianModel> _pendakian = [];

  void fetchPendakian() async {
    try {
      emit(PendakianLoading());
      _pendakian = await PendakianService().fetchPendakian();
      emit(PendakianSuccess(pendakian: _pendakian));
    } catch (e) {
      emit(PendakianError(e.toString()));
    }
  }

  void searchPendakian(String keyword) async {
    try {
      emit(PendakianLoading());
      List<PendakianModel> _filteredData = _pendakian
          .where((element) =>
              element.namaGunung!.toLowerCase().contains(keyword) ||
              element.lokasiGunung!.toLowerCase().contains(keyword))
          .toList();
      emit(PendakianSuccess(
          pendakian: _pendakian, searchPendakan: _filteredData));
    } catch (e) {
      emit(PendakianError(e.toString()));
    }
  }
}
