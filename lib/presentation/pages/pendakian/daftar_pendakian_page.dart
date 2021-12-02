import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/pendakian/pendakian_cubit.dart';
import 'package:nenda_invfest/presentation/widgets/app_search_bar_widget.dart';
import 'package:nenda_invfest/presentation/widgets/card_mountain_widget.dart';
import 'package:nenda_invfest/presentation/widgets/content_loading_widgets.dart';

class DaftarPendakianPage extends StatefulWidget {
  const DaftarPendakianPage({Key? key}) : super(key: key);

  @override
  State<DaftarPendakianPage> createState() => _DaftarPendakianPageState();
}

class _DaftarPendakianPageState extends State<DaftarPendakianPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<PendakianCubit>().fetchPendakian();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        titleSpacing: -8,
        title: Text(
          'Pendakian',
          style: NendaStyles.fontBold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24, top: 16, right: 24),
        child: Column(
          children: [
            AppSearchBar(
              controller: _searchController,
              hintText: 'Cari Gunung',
              onChanged: (String keyword) {
                context.read<PendakianCubit>().searchPendakian(keyword);
              },
            ),
            SizedBox(height: 32),
            BlocConsumer<PendakianCubit, PendakianState>(
              listener: (context, state) {
                if (state is PendakianError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage.toString()),
                    backgroundColor: Colors.black,
                  ));
                }
              },
              builder: (context, state) {
                if (state is PendakianSuccess) {
                  var data = state.searchPendakan ?? state.pendakian;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (contex, index) => Container(
                        margin: EdgeInsets.only(bottom: 32),
                        child: CardMountain(data: data[index]),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: ContentLoadingWidget(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
