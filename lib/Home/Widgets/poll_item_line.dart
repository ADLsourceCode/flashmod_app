import 'package:flaskmob/DataModel/poll.dart';
import 'package:flaskmob/Provider/polls.dart';
import 'package:flaskmob/Services/PollService.dart';
import 'package:flaskmob/Utils/app_colors.dart';
import 'package:flaskmob/Utils/app_dimensions.dart';
import 'package:flaskmob/Utils/progress_dialog.dart';
import 'package:flaskmob/Utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';







class PollItemLine extends StatefulWidget {
  Poll data;
  int index;



  PollItemLine(this.data,this.index);

  @override
  _PollItemLineState createState() => _PollItemLineState();
}

class _PollItemLineState extends State<PollItemLine> {

  List<String>? isAnswered = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Polls>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      color: AppColors.grey200,
      padding: EdgeInsets.all(AppDimensions.px20),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(widget.data!.creatorName?[0]??'-',style: AppTextStyle.default_normal,),
              Text(widget.data!.totalVotes?.toString() ??'0',style: AppTextStyle.default_normal)

            ],
          ),

          Text(widget!.data!.questionText?[0]??'-',style: AppTextStyle.default_normal_bold,textAlign: TextAlign.center,),

      StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing:20,
        crossAxisSpacing: 20,
        children:  widget!.data!.options!.map((e) {

            int index = widget.data!.options!.indexOf(e);

          return InkWell(
            onTap: () async {
              if(!providerData.isAnswered!.contains(widget.data!.id!)) {

                ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
                pr.style(
                    message: 'Please wait...',
                    borderRadius: 10.0,
                    backgroundColor: Colors.white,
                    progressWidget: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoActivityIndicator(),
                    ),
                    elevation: 10.0,
                    insetAnimCurve: Curves.easeInOut,
                    progress: 0.0,
                    maxProgress: 100.0,
                    progressTextStyle: TextStyle(
                        color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                    messageTextStyle: TextStyle(
                        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
                );
                await pr.show();
                Poll? res = await PollService().postResult(e!.id!, widget.data!
                    .id!);
                if (res != null) {


                      providerData.addToAnswered(widget.data!.id!,widget.index,index);

                    await pr.hide();

                }
                else {
                  await pr.hide();
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.45,
              height: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(color: AppColors.white,borderRadius: BorderRadius.all(Radius.circular(AppDimensions.px10))),
              child: Center(child:

              providerData.isAnswered!.contains(widget.data!.id!)?
              Text(widget.data!.totalVotes == 0?'0%':((e!.count! / widget.data!.totalVotes! )*100).toStringAsFixed(0)+"%" ?? '0%', textAlign: TextAlign.center,):
              Text(e!.text?[0] ?? '-', textAlign: TextAlign.center,),),),
          );

        }).toList()
      )
        ],
      )

    );
  }
}
