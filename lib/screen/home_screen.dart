import 'package:bloc_pract/internet_bloc/internet_bloc.dart';
import 'package:bloc_pract/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocHomePage extends StatefulWidget {
  const BlocHomePage({super.key});

  @override
  State<BlocHomePage> createState() => _BlocHomePageState();
}

class _BlocHomePageState extends State<BlocHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bloc Home'), centerTitle: true),
      body: Center(
        child: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is InternetGainedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Internet Connected'),
                  backgroundColor: Colors.green,
                  elevation: 10,
                ),
              );
              // Delay to ensure dialog shows after frame is rendered
              Future.delayed(Duration(milliseconds: 100), () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 10), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Text('got Internet'),
                      icon: Icon(Icons.wifi),
                      iconColor: Colors.white,
                      backgroundColor: Colors.green,
                      elevation: 10,
                    );
                  },
                );
              });
            } else if (state is InternetLostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Internet Not Connected'),
                  backgroundColor: Colors.red,
                  elevation: 10,
                ),
              );
              Future.delayed(Duration(milliseconds: 100), () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 10), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Text('Internet Lost'),
                      icon: Icon(Icons.wifi_off_sharp),
                      iconColor: Colors.white,
                      backgroundColor: Colors.red,
                      elevation: 10,
                    );
                  },
                );
              });
            }
          },
          builder: (context, state) {
            if (state is InternetGainedState) {
              return Text('Connected');
            } else if (state is InternetLostState) {
              return Text('Not connected');
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}
