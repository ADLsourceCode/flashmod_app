import 'package:flaskmob/Home/feed.dart';
import 'package:flaskmob/Provider/polls.dart';
import 'package:flaskmob/Utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {

   runApp(Wrapper());

}



class Wrapper extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [ChangeNotifierProvider<Polls>(create: (_) => Polls())],
      child: MaterialApp(

            builder: (context, child) {

              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(textScaleFactor: AppDimensions.px1),
              );
            },
            home: Feed()
        ),
    );
  }
}