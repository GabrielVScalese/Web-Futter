import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Investment, String>> _investments;
  List<charts.Series<Gain, String>> _gains;

  List<Coin> coins = [
    Coin('Dollar', 15),
    Coin('Pound', 20),
    Coin('Libra', 5),
    Coin('Real', 40)
  ];

  getMonth(int number) {
    var months = ['January', 'February', 'March', 'April'];

    return months[number - 1];
  }

  _generateData() {
    var investmentsData = [
      new Investment('Bank', 16),
      new Investment('Property', 34),
      new Investment('Actions', 50)
    ];

    _investments.add(charts.Series<Investment, String>(
      id: 'Investments',
      domainFn: (Investment sales, _) => sales.type,
      measureFn: (Investment sales, _) => sales.value,
      data: investmentsData,
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
    ));

    var gainsData = [
      Gain(DateTime(2021, 1), 100000),
      Gain(DateTime(2021, 2), 110000),
      Gain(DateTime(2021, 3), 120000),
      Gain(DateTime(2021, 4), 130000),
    ];

    _gains.add(charts.Series<Gain, String>(
      id: 'Gains',
      domainFn: (Gain gains, _) => getMonth(gains.dt.month),
      measureFn: (Gain gains, _) => gains.value,
      data: gainsData,
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
    ));
  }

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _investments = List<charts.Series<Investment, String>>();
    // ignore: deprecated_member_use
    _gains = List<charts.Series<Gain, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                accountName: Text(
                  'Gabriel Scalese',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                accountEmail: Text(
                  'gabriel.scalese@hotmail.com',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1545167622-3a6ac756afa4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=6'),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Account',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Settings',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
            Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Your Wallet',
          style: GoogleFonts.inter(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 70, top: 10),
              width: 400,
              height: 400,
              child: charts.PieChart(
                _investments,
                animate: true,
                behaviors: [
                  new charts.DatumLegend(
                    showMeasures: true,
                    legendDefaultMeasure:
                        charts.LegendDefaultMeasure.firstValue,
                    measureFormatter: (num value) {
                      return value == null ? '-' : '$value%';
                    },
                  )
                ],
                animationDuration: Duration(seconds: 2),
              ),
            ),
            VerticalDivider(
              indent: 50,
              endIndent: 50,
            ),
            Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              height: 400,
              width: 400,
              child: ListView.builder(
                  itemCount: coins.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Card(
                          elevation: 10,
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 10, right: 20),
                                  child: Text(coins[index].name)),
                            ],
                          )),
                      margin: EdgeInsets.only(bottom: 30),
                    );
                  }),
            ),
            VerticalDivider(
              indent: 50,
              endIndent: 50,
            ),
            Container(
              width: 400,
              height: 400,
              padding: EdgeInsets.only(left: 30),
              child: charts.BarChart(
                _gains,
                animate: true,
                animationDuration: Duration(seconds: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Investment {
  String type;
  int value;

  Investment(this.type, this.value);
}

class Coin {
  String name;
  int appreciation;

  Coin(this.name, this.appreciation);
}

class Gain {
  DateTime dt;
  int value;

  Gain(this.dt, this.value);
}
