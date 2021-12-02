import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/forecast/forecast_cubit.dart';
import 'package:nenda_invfest/data/model/forecast_model.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/presentation/widgets/content_loading_widgets.dart';
import 'package:nenda_invfest/utils/forecast_helper.dart';

class ForecastPendakianPage extends StatefulWidget {
  final JalurPendakian data;
  ForecastPendakianPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ForecastPendakianPage> createState() => _ForecastPendakianPageState();
}

class _ForecastPendakianPageState extends State<ForecastPendakianPage> {
  PageController _controller =
      PageController(viewportFraction: 1, initialPage: 0, keepPage: false);

  @override
  void initState() {
    print('${widget.data.lat!} - ${widget.data.lon!}');
    context
        .read<ForecastCubit>()
        .getForecastData(widget.data.lat!, widget.data.lon!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ForecastCubit, ForecastState>(
          builder: (context, state) {
            if (state is ForecastSuccess) {
              return ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(24),
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 8),
                      Text('Kembali', style: NendaStyles.fontMedium),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.data.namaJalur}',
                            style: NendaStyles.fontMedium,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.place,
                            size: 20,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${getCelcius(state.data.current!.temp!)} °C',
                        style: NendaStyles.fontDisplay,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            width: 48,
                            image: CachedNetworkImageProvider(
                                'http://openweathermap.org/img/wn/${state.data.current!.weather![0].icon}@2x.png'),
                          ),
                          Text(
                            '${state.data.current!.weather![0].main}',
                            style: NendaStyles.fontParagraph,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    children: [
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: kOrange,
                      ),
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, index) =>
                              _hourlyForecastItem(state.data.hourly![index]),
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: kOrange,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  for (int i = 0; i < state.data.daily!.length; i++)
                    _dailyForecastItem(state.data.daily![i])
                ],
              );
            } else if (state is ForecastError) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return ContentLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _dailyForecastItem(Daily data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(getFormattedDate(data.dt!)[0]),
        Image(
          width: 48,
          image: CachedNetworkImageProvider(
              'http://openweathermap.org/img/wn/${data.weather![0].icon}@2x.png'),
        ),
        Text(
          '${getCelcius(data.temp!.day!)} °C',
        ),
      ],
    );
  }

  Widget _hourlyForecastItem(Hourly data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(getFormattedDate(data.dt!)[1]),
          Image(
            width: 54,
            image: CachedNetworkImageProvider(
                'http://openweathermap.org/img/wn/${data.weather![0].icon}@2x.png'),
          ),
          Text('${getCelcius(data.temp!)} °C'),
        ],
      ),
    );
  }
}
