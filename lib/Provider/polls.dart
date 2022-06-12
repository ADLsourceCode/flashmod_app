import 'package:flaskmob/DataModel/poll.dart';
import 'package:flaskmob/Home/Widgets/poll_item_line.dart';
import 'package:flaskmob/Services/PollService.dart';

import 'package:flutter/material.dart';

class Polls extends ChangeNotifier{

  late List<Poll>? data;
  List<Widget> widgetList = [];

  bool isLoading = true;

  List<String> isAnswered = [];


  addToAnswered(String id,int index,int optionIndex)
  {
    isAnswered.add(id);
    data![index].totalVotes = 1;
    data![index].options![optionIndex].count = 1;


    notifyListeners();
  }

  fetchData(context) async{

    data = await PollService().getAllPolls();


    if(data!=null)
    {


        isLoading = false;
        data!.forEach((element) {
          var index = data!.indexOf(element);
          widgetList.add(PollItemLine(element,index));
        });

        notifyListeners();

    }
    else{
      //Error

        isLoading = false;
        notifyListeners();

    }


  }

}