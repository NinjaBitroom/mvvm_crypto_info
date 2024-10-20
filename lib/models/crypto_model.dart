class CryptoModel {
  final String cryptoName;
  final double price;
  final String symbol;
  final String image;
  final int marketCap;
  final int volume;
  final String id;
  List<dynamic>? priceHistory;

  CryptoModel({
    required this.cryptoName,
    required this.price,
    required this.symbol,
    required this.image,
    required this.marketCap,
    required this.volume,
    required this.id,
    this.priceHistory,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      cryptoName: json['name'],
      price: json['current_price'].toDouble(),
      symbol: json['symbol'],
      image: json['image'],
      marketCap: json['market_cap'],
      volume: json['total_volume'],
      id: json['id'],
      priceHistory: json['price_history'],
    );
  }
}
