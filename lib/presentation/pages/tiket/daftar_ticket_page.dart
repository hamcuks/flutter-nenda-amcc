import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
import 'package:nenda_invfest/cubit/ticket/ticket_cubit.dart';
import 'package:nenda_invfest/data/model/ticket_model.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/presentation/pages/tiket/booked_ticket_page.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:nenda_invfest/presentation/widgets/content_loading_widgets.dart';

class DaftarTicketPage extends StatefulWidget {
  const DaftarTicketPage({Key? key}) : super(key: key);

  @override
  State<DaftarTicketPage> createState() => _DaftarTicketPageState();
}

class _DaftarTicketPageState extends State<DaftarTicketPage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 82),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket',
              style: NendaStyles.fontMedium,
            ),
            SizedBox(height: 16),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSignOut) {
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage.toString()),
                    backgroundColor: Colors.black,
                  ));
                } else if (state is AuthLoading) {
                } else if (state is AuthInitial) {
                  Navigator.pushNamed(context, '/login');
                }
              },
              builder: (context, state) {
                if (state is AuthSuccess) {
                  user = state.user;
                  context.read<TicketCubit>().getTickets(userId: user!.id);

                  return BlocBuilder<TicketCubit, TicketState>(
                    builder: (context, state) {
                      if (state is TicketSuccess) {
                        if (state.tickets!.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: state.tickets!.length,
                                itemBuilder: (context, index) =>
                                    _cardTicket(state.tickets![index])),
                          );
                        } else {
                          return Expanded(
                            child: Center(
                              child: Text(
                                'Opps, kamu belum punya ticket. Yuk booking tiketmu!',
                                style: NendaStyles.fontMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      } else if (state is TicketError) {
                        return Center(child: Text('${state.errorMessage}'));
                      } else {
                        return Expanded(child: ContentLoadingWidget());
                      }
                    },
                  );
                } else if (state is AuthLoading) {
                  return ContentLoadingWidget();
                } else {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Silahkan login terlebih dahulu untuk melihat ticket',
                            style: NendaStyles.fontMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          AppButton(
                            width: 145,
                            height: 52,
                            text: 'Login',
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/login'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardTicket(TicketModel data) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookedTicketPage(data: data))),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data.namaGunung}',
              style: NendaStyles.fontMedium,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Row(children: [
                  Icon(Icons.event_outlined),
                  SizedBox(width: 8),
                  Text('${data.tanggalNaik}'),
                ]),
                SizedBox(width: 24),
                Row(children: [
                  Icon((data.jumlahPendaki! > 1)
                      ? Icons.people_outline
                      : Icons.person_outline),
                  SizedBox(width: 8),
                  Text('${data.jumlahPendaki} Pendaki'),
                ]),
                // Text('${data.tanggalNaik} / ${data.jumlahPendaki} Pendaki'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
