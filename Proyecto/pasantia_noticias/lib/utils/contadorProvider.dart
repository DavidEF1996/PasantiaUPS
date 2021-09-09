class Counter {
  int _count = 0;
  int get count => _count;
  //notifyListeners();

  set count(int value) {
    _count = value;
    //  notifyListeners();
  }
}
