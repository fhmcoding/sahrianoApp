import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/modeles/onbordngModel.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({Key key}) : super(key: key);

  @override
  _OnbordingScreenState createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  String firstName = Cachehelper.getData(key: "firstName");
  String lastName = Cachehelper.getData(key: "lastName");
  String phone = Cachehelper.getData(key: "phone");

  List<OnbordingModel> onbording = [
    OnbordingModel(
        image: 'assets/sahariano.png',
        title: 'El Sahariano Travel',
        body: 'Travel flexibly and book your ticket with confidence'),
        OnbordingModel(
        image: 'assets/reservation.png',
        title: 'Reservation',
        body: 'Book your hotel at the best price only with Elsahariano Travel'),
         OnbordingModel(
        image: 'assets/hotel.png',
        title: 'You have a question',
        body: 'We are at your disposal by phone:+212528999999 or By chat via the *chate*option found in the application'),
    OnbordingModel(
        image: 'assets/kreina.png',
        title: 'Kreina',
        body: 'the 1st travel agency to set up a loyalty called kreina'),
    OnbordingModel(
        image: 'assets/consultation.png',
        title: 'Consultation',
        body: 'Check your flight status qnd check if the flight is on time'),
  ];
  var bordingController = PageController();
  bool islast = false;
  void submit() {
   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:0)), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
        builder: (context,state){
          return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: bordingController,
                        onPageChanged: (int index) {
                          if (index == onbording.length - 1) {
                            setState(() {
                              islast = true;
                            });
                          } else {
                            setState(() {
                              islast = false;
                            });
                          }
                        },
                        itemCount: onbording.length,
                        itemBuilder: (context, index) =>
                            buildOnbordingItem(onbording[index]))),
                SizedBox(height: 35),
                SmoothPageIndicator(
                  controller: bordingController,
                  count: onbording.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Color(0xFF7B919D),
                    activeDotColor: Color(0xFFf37021),
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    islast == true
                        ? SizedBox(
                            height: 0,
                          )
                        : TextButton(
                            onPressed: () {
                            
                              submit();
                            },
                            child: Text(
                              'SKIP',
                              style: TextStyle(fontSize: 17),
                            )),
                    TextButton(
                        onPressed: () {
                          if (islast == true) {
                            submit();
                           

                          }
                          bordingController.nextPage(
                              duration: Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF7B919D),
                                  blurRadius: 10,
                                  offset: Offset(0.0, 5))
                            ],
                            color: Color(0xFFf37021),
                          ),
                          height: 30,
                          width: 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'NEXT',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
        },
      ),
    );
  }

  Widget buildOnbordingItem(OnbordingModel onbording) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Center(
                  child: Image(
            image: AssetImage('${onbording.image}'),
            height: 240,
          ))),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Text(
                '${onbording.title}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFf37021),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: Container(
              child: Text(
                '${onbording.body}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF173242),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      );
}
