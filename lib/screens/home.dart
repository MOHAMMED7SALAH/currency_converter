import 'package:exhange_rates_flutter/components/anyToAny.dart';
import 'package:exhange_rates_flutter/components/usdToAny.dart';
import 'package:exhange_rates_flutter/functions/fetchrates.dart';
import 'package:exhange_rates_flutter/models/ratesmodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Initial Variables

  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  //Getting RatesModel and All Currencies
  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        
        //Future Builder for Getting Exchange Rates
        body: Container(
          height: h,
          width: w,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/currency.jpeg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: h * 0.26),
                Form(
                  key: formkey,
                  child: FutureBuilder<RatesModel>(
                    future: result,
                    builder: (context, snapshot) {
                      if (snapshot.error != null)
                        return Text(
                          'please check connection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.green,
                          ),
                        );
                      else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Center(
                          child: FutureBuilder<Map>(
                              future: allcurrencies,
                              builder: (context, currSnapshot) {
                                if (currSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    UsdToAny(
                                      currencies: currSnapshot.data!,
                                      rates: snapshot.data!.rates,
                                    ),
                                    AnyToAny(
                                      currencies: currSnapshot.data!,
                                      rates: snapshot.data!.rates,
                                    ),
                                  ],
                                );
                              }),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
