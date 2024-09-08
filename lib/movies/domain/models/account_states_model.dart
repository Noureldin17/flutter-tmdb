class AccountStates {
  late int id;
  late bool favorite;
  late Rated? rated;
  late bool watchlist;

  AccountStates(
    this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  );

  AccountStates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favorite = json['favorite'];
    rated = json['rated'] != false ? Rated.fromJson(json['rated']) : null;
    watchlist = json['watchlist'];
  }
}

class Rated {
  num? value;

  Rated({this.value});

  Rated.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }
}
