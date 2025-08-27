import 'package:currency/model/currency.dart';
import 'package:currency/services/crypto_api_service.dart';
import 'package:get/get.dart';

class CryptoController extends GetxController {
  // Observable list of cryptocurrencies
  final RxList<Currency> cryptocurrencies = <Currency>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Error state
  final RxString error = ''.obs;

  // API service
  final CryptoApiService _apiService = CryptoApiService();

  @override
  void onInit() {
    super.onInit();
    // Fetch cryptocurrencies when controller is initialized
    fetchCryptocurrencies();
  }

  // Fetch cryptocurrencies from API
  Future<void> fetchCryptocurrencies() async {
    try {
      // Set loading state
      isLoading.value = true;
      error.value = '';

      // Fetch data from API
      final cryptos = await _apiService.getTopCryptocurrencies();

      // Update cryptocurrencies list
      cryptocurrencies.value = cryptos;
    } catch (e) {
      // Handle error
      error.value = 'Failed to fetch cryptocurrencies: $e';
      print(error.value);
    } finally {
      // Set loading state to false
      isLoading.value = false;
    }
  }

  // Refresh cryptocurrency data
  Future<void> refreshCryptocurrencies() async {
    await fetchCryptocurrencies();
  }
}
