import 'package:bitcoin_ticker/services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '';
const coinApiURL = 'https://rest.coinapi.io/v1';
const exchangeRateURL = '$coinApiURL/exchangerate';

class CoinData {
  Future<String> getExchangeRate(String coin, String currency) async {
    NetworkHelper networkHelper =
        NetworkHelper('$exchangeRateURL/$coin/$currency?apiKey=$apiKey');

    var exchangeData = await networkHelper.getData();
    if (exchangeData == null) {
      return '?';
    }
    double rate = exchangeData['rate'];
    return rate.toStringAsFixed(2);
  }
}
