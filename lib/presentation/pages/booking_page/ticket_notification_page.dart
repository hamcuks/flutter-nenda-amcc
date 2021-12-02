import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/ticket/ticket_cubit.dart';
import 'package:nenda_invfest/data/model/ticket_model.dart';
import 'package:nenda_invfest/presentation/pages/tiket/booked_ticket_page.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:nenda_invfest/presentation/widgets/content_loading_widgets.dart';

class TicketNotifiactionPage extends StatelessWidget {
  final TicketModel data;
  const TicketNotifiactionPage({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TicketCubit, TicketState>(
        listener: (context, state) {
          if (state is TicketError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage.toString()),
              backgroundColor: Colors.black,
            ));
          }
        },
        builder: (context, state) {
          if (state is TicketSuccess) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/booking-success.png',
                    scale: 4,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Booking Sukses!',
                    style: NendaStyles.fontBold,
                  ),
                  SizedBox(height: 16),
                  AppButton(
                    text: 'Lihat Ticket',
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookedTicketPage(data: data)),
                        (route) => false),
                  )
                ],
              ),
            );
          } else if (state is TicketError) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            return Center(
              child: ContentLoadingWidget(),
            );
          }
        },
      ),
    );
  }
}
