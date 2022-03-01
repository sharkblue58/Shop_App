import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/component/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class BoardingModel{

late final String image;
late final String title;
late final String body;
BoardingModel({required this.image,required this.title,required this.body});

}

class  OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller =PageController();

List<BoardingModel>Boarding=[
  BoardingModel(
    image: 'assets/images/shop2.jpg',
    body: 'On board 1 body',
    title: 'On board 1 title',
  ),
  BoardingModel(
    image: 'assets/images/shop2.jpg',
    body: 'On board 2 body',
    title: 'On board 2 title',
  ),
  BoardingModel(
    image: 'assets/images/shop2.jpg',
    body: 'On board 3 body',
    title: 'On board 3 title',
  ),
];
bool islast=false ;
void submit(){
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if (value)
    {
      nevigateAndFinish(context, ShopLoginScreen());
    }
  } );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      actions: [
        defulttextbutton(function: (){submit();},text:'SKIP' ),
      ],
    ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  itemBuilder: (context,index)=>buildBoardingItem(Boarding[index]),
                  itemCount:Boarding.length,
                  controller: boardcontroller,
                  physics:BouncingScrollPhysics(),
                  onPageChanged:(int index){
                    if(index==Boarding.length-1)
                      {
                        setState(() {
                          islast=true;
                        });
                      }else{
                      islast=false;
                    }
                  },
                )
            ),
            SizedBox(height:40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller:boardcontroller,
                  count: Boarding.length ,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight:10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed:()=>{
                    if(islast)
                      {
                        submit()
                      }else{
                      boardcontroller.nextPage(duration: Duration(milliseconds:750),
                          curve: Curves.fastLinearToSlowEaseIn
                      )
                    }

                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),

          ],
        ),
      ),
    );


  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Expanded(child: Image(image: AssetImage('${model.image}',),)),
      SizedBox(height:30,),
      Text('${model.title}',
        style: TextStyle(
          fontSize: 24.0,fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height:15,),
      Text('${model.body}',
        style: TextStyle(
          fontSize: 14.0,fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height:30,),

    ],
  );
}
