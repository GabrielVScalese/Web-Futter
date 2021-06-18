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
  List<charts.Series<Investment, String>> _seriesData;

  List<Coin> coins = [
    Coin('Dollar', 15),
    Coin('Pound', 20),
    Coin('Libra', 5),
    Coin('Real', 40)
  ];

  _generateData() {
    var data = [
      new Investment('Bank', 16),
      new Investment('Property', 23),
      new Investment('Action', 50)
    ];

    _seriesData.add(charts.Series<Investment, String>(
      id: 'Linear Sales',
      domainFn: (Investment sales, _) => sales.type,
      measureFn: (Investment sales, _) => sales.value,
      data: data,
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
    ));
  }

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _seriesData = List<charts.Series<Investment, String>>();
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
                _seriesData,
                animate: true,
                behaviors: [
                  new charts.DatumLegend(
                    showMeasures: true,
                    legendDefaultMeasure:
                        charts.LegendDefaultMeasure.firstValue,
                    // Optionally provide a measure formatter to format the measure value.
                    // If none is specified the value is formatted as a decimal.
                    measureFormatter: (num value) {
                      return value == null ? '-' : '${value}%';
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
              padding: EdgeInsets.only(right: 30),
              margin: EdgeInsets.only(left: 30),
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
