class Currency {
  String? id;
  String? title;
  String? priceUSD; // Price in USD
  String? priceIRR; // Price in Iranian Rial
  String? changes;
  String? status;

  Currency({
    required this.id,
    required this.title,
    required this.priceUSD,
    this.priceIRR,
    required this.changes,
    required this.status,
  });

  // Get the appropriate price based on language
  String getPrice(bool isEnglish) {
    return isEnglish ? priceUSD ?? '' : priceIRR ?? '';
  }
}
