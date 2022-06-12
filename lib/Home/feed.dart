import 'package:flaskmob/DataModel/poll.dart';
import 'package:flaskmob/Home/Widgets/poll_item_line.dart';
import 'package:flaskmob/Provider/polls.dart';
import 'package:flaskmob/Services/PollService.dart';
import 'package:flaskmob/Utils/app_dimensions.dart';
import 'package:flaskmob/Utils/app_colors.dart';
import 'package:flaskmob/Utils/strings.dart';
import 'package:flaskmob/Utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {


  final CarouselController _controller = CarouselController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async{



    // data= await PollService().getAllPolls();
    final providerData = Provider.of<Polls>(context, listen: false);
    providerData.fetchData(context);

  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Polls>(context);
    return Scaffold(

      appBar: AppBar(title: Text(Strings.feed,style: AppTextStyle.default_normal,),backgroundColor: AppColors.white,elevation:AppDimensions.px0 ,),
      body:Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          child: providerData.isLoading?

          Center(child:CupertinoActivityIndicator()):
          providerData.data==null?
          Center(child:Text(Strings.error,style: AppTextStyle.default_normal,)):
          providerData.data!.length==0?
          Center(child:Text(Strings.no_polls_found,style: AppTextStyle.default_normal,)):
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              aspectRatio: 2.0,
              enableInfiniteScroll: false,

              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              scrollDirection: Axis.vertical,
              autoPlay: false,
              reverse: false,

            ),
            items: providerData.widgetList,
          ))
    );
  }
}
