class Scheme {
  int sl, installmentno, duration;
  double prinamount,
      servicecharge,
      dailyprofit,
     installmentamount
      ;
  String name;
  bool filterFn(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
  Scheme(
      {required this.sl,
      required this.installmentno,
      required this.duration,
      required this.prinamount,
      required this.servicecharge,
      required this.dailyprofit,
      required this.installmentamount,
      required this.name});
}
