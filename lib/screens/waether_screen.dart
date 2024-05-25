import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherforecast/controllers/weather_controller.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String kGoogleApiKey = "AIzaSyAVQIV6VKriXRjoBg0Nzp8OpBzmZitvayM";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WheatherController>(context);

    var currTemp;
    var maxTemp;
    var minTemp;
    var placeMark;
    var main;
    if (provider.weatherModel != null) {
      currTemp = provider.weatherModel!.main!.temp; // current temperature
      maxTemp = provider.weatherModel!.main!.tempMax!; // today max temperature
      minTemp = provider.weatherModel!.main!.tempMin!; // today min temperature
      main = provider.weatherModel!.main!.temp;
      placeMark = provider.placemark;
    }

    Size size = MediaQuery.of(context).size;
    bool isDarkMode = false;
    return Scaffold(
      body: provider.loading == true
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Weather App',
                            style: GoogleFonts.questrial(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                        ),
                        child: placeMark == null
                            ? Container()
                            : Align(
                                child: Column(
                                  children: [
                                    Text(
                                      placeMark.country.toString(),
                                      style: GoogleFonts.questrial(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: size.height * 0.06,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      placeMark.locality.toString(),
                                      style: GoogleFonts.questrial(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: size.height * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.005,
                        ),
                        child: Align(
                          child: Text(
                            'Today', //day
                            style: GoogleFonts.questrial(
                              color:
                                  isDarkMode ? Colors.white54 : Colors.black54,
                              fontSize: size.height * 0.035,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                        ),
                        child: main == null
                            ? Container()
                            : Align(
                                child: Text(
                                  '${main!.toString()}˚C', //curent temperature
                                  style: GoogleFonts.questrial(
                                    color: currTemp! <= 0
                                        ? Colors.blue
                                        : currTemp > 0 && currTemp <= 15
                                            ? Colors.indigo
                                            : currTemp > 15 && currTemp < 30
                                                ? Colors.deepPurple
                                                : Colors.pink,
                                    fontSize: size.height * 0.10,
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.25),
                        child: Divider(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      provider.weatherModel == null
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.005,
                              ),
                              child: Align(
                                child: Text(
                                  '${provider.weatherModel!.weather!.first.description}',
                                  style: GoogleFonts.questrial(
                                    color: isDarkMode
                                        ? Colors.white54
                                        : Colors.black54,
                                    fontSize: size.height * 0.03,
                                  ),
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          bottom: size.height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            minTemp == null
                                ? Container()
                                : Text(
                                    '${minTemp.toString()} ˚C', // min temperature
                                    style: GoogleFonts.questrial(
                                      color: minTemp <= 0
                                          ? Colors.blue
                                          : minTemp > 0 && minTemp <= 15
                                              ? Colors.indigo
                                              : minTemp > 15 && minTemp < 30
                                                  ? Colors.deepPurple
                                                  : Colors.pink,
                                      fontSize: size.height * 0.03,
                                    ),
                                  ),
                            Text(
                              '/',
                              style: GoogleFonts.questrial(
                                color: isDarkMode
                                    ? Colors.white54
                                    : Colors.black54,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                            maxTemp == null
                                ? Container()
                                : Text(
                                    '${maxTemp.toString()} ˚C', //max temperature
                                    style: GoogleFonts.questrial(
                                      color: maxTemp <= 0
                                          ? Colors.blue
                                          : maxTemp > 0 && maxTemp <= 15
                                              ? Colors.indigo
                                              : maxTemp > 15 && maxTemp < 30
                                                  ? Colors.deepPurple
                                                  : Colors.pink,
                                      fontSize: size.height * 0.03,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'exmple: (1600 Amphiteatre Parkway, Mountain View)',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.withOpacity(.5)),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: addressController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 11),
                                hintText: 'Enter Address',
                                counterText: '',
                              ),
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'address is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // locator
                            //     .get<WheatherController>()
                            //     .getWeather(addressController.text);

                            bool success = await provider
                                .getWeather(addressController.text);
                            if (success == false) {
                              const snackBar = SnackBar(
                                content: Text('Cannot Find Location'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Weather retrived successfully'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40)),
                          child: Center(
                            child: Text(
                              'Change Location',
                              style: GoogleFonts.questrial(
                                color: Colors.white,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
