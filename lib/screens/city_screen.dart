import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_clone/utils/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String city;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: kTransparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: kTransparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kBlack,
                size: kIconSize,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  onChanged: (value) {
                    city = value;
                  },
                  style: const TextStyle(color: kBlack),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: kWhite,
                    icon: Icon(
                      Icons.location_city,
                      color: kBlack,
                    ),
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, city);
                  },
                  child: const Text(
                    'Get Weather',
                    style: TextStyle(
                      fontSize: kIconSize,
                      color: kWhite,
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
