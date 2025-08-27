import 'dart:convert';

import 'package:currency/model/currency.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CryptoApiService {
  // Base URL for CoinGecko API
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  // Endpoint to get top cryptocurrencies with market data
  static const String coinsMarketsEndpoint = '/coins/markets';

  // Exchange rate API URL for USD to IRR conversion
  static const String exchangeRateApiUrl =
      'https://open.er-api.com/v6/latest/USD';

  // Fallback exchange rate in case API fails
  static const double fallbackUsdToIrrRate = 91000.0;

  // Current USD to IRR exchange rate
  double _usdToIrrRate = fallbackUsdToIrrRate;

  // Format currency with proper separators
  String _formatCurrency(double value, String currencySymbol) {
    final formatter = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  // Fetch the current USD to IRR exchange rate
  Future<double> _fetchExchangeRate() async {
    try {
      final response = await http.get(Uri.parse(exchangeRateApiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Check if the response contains IRR rate
        if (data['rates'] != null && data['rates']['IRR'] != null) {
          return data['rates']['IRR'].toDouble();
        }
      }
      // Return fallback rate if API call fails
      return fallbackUsdToIrrRate;
    } catch (e) {
      print('Error fetching exchange rate: $e');
      return fallbackUsdToIrrRate;
    }
  }

  // Fetch top 10 cryptocurrencies
  Future<List<Currency>> getTopCryptocurrencies() async {
    try {
      // First, update the exchange rate
      _usdToIrrRate = await _fetchExchangeRate();

      // Parameters for the API request
      final queryParams = {
        'vs_currency': 'usd', // Currency to compare against (USD)
        'order': 'market_cap_desc', // Order by market cap
        'per_page': '10', // Limit to 10 results
        'page': '1',
        'sparkline': 'false',
        'price_change_percentage': '24h' // Include 24h price change
      };

      // Construct the URL with query parameters
      final uri = Uri.parse('$baseUrl$coinsMarketsEndpoint').replace(
        queryParameters: queryParams,
      );

      // Make the HTTP request
      final response = await http.get(uri);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> data = json.decode(response.body);

        // Convert the data to a list of Currency objects
        return data.map((crypto) {
          // Determine status based on price change
          String status = 'neutral';
          if (crypto['price_change_percentage_24h'] != null) {
            status = crypto['price_change_percentage_24h'] > 0
                ? 'up'
                : crypto['price_change_percentage_24h'] < 0
                    ? 'down'
                    : 'neutral';
          }

          // Format the price change to show only 2 decimal places
          String priceChange = '0';
          if (crypto['price_change_percentage_24h'] != null) {
            priceChange =
                crypto['price_change_percentage_24h'].toStringAsFixed(2);
            // Add + sign for positive changes
            if (crypto['price_change_percentage_24h'] > 0) {
              priceChange = '+$priceChange';
            }
          }

          // Get the price in USD and format it
          double priceInUsd = crypto['current_price'].toDouble();
          String formattedUsdPrice = _formatCurrency(priceInUsd, "\$");

          // Convert to IRR and format it
          double priceInIrr = priceInUsd * _usdToIrrRate;
          String formattedIrrPrice =
              NumberFormat('#,###').format(priceInIrr.round()) + ' ریال';

          return Currency(
            id: crypto['id'],
            title: crypto['name'],
            priceUSD: formattedUsdPrice,
            priceIRR: formattedIrrPrice,
            changes: priceChange,
            status: status,
          );
        }).toList();
      } else {
        // If the request failed, throw an exception
        throw Exception(
            'Failed to load cryptocurrencies: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching cryptocurrencies: $e');
      return [];
    }
  }
}
