import 'dart:io' show Platform;

import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'BRL';
  List<Widget> coinCards = [];

  @override
  void initState() {
    super.initState();

    updateUI(selectedCurrency);
  }

  void updateUI(String currency) async {
    List<Widget> cards = [];
    for (String coin in cryptoList) {
      var rate = await coinData.getExchangeRate(coin, currency);
      cards.add(coinCard(coin, currency, rate));
    }

    setState(() {
      selectedCurrency = currency;
      coinCards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: coinCards,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      items.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return DropdownButton(
      items: items,
      onChanged: (value) => updateUI(value),
      value: selectedCurrency,
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) =>
          updateUI(currenciesList[selectedIndex]),
      children: items,
    );
  }

  Widget coinCard(String coin, String currency, String rate) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coin = $rate $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
