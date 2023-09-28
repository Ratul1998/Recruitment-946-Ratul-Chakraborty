import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/api_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ApiService {
  bool loading = true;

  late WeatherModel weatherModel;

  @override
  void initState() {
    getWeatherData();

    super.initState();
  }

  void getWeatherData() {
    getWeatherModel().then((value) => setState(() {
          loading = false;

          weatherModel = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: weatherModel.daily?.time?.length ?? 0,
                        itemBuilder: (context, index) {
                          String time =
                              weatherModel.daily?.time?.elementAt(index) ?? '';
                          double min = weatherModel.daily?.temperature2mMin
                                  ?.elementAt(index) ??
                              0;
                          double max = weatherModel.daily?.temperature2mMax
                                  ?.elementAt(index) ??
                              0;

                          return ListTile(
                            title: Text(time),
                            subtitle: Text(
                                '$min ${weatherModel.dailyUnits?.temperature2mMin} - $max ${weatherModel.dailyUnits?.temperature2mMin}'),
                          );
                        }))
              ],
            ),
      floatingActionButton: Visibility(
        visible: !loading,
        child: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () => setState(() {
            loading = true;
          }),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
