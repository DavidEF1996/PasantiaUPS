import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET JSESSIONID
  get id {
    return _prefs.getInt('id') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set id(int id) {
    _prefs.setInt('id', id);
  }

  get nombres {
    return _prefs.getString('nombre') ?? '';
  }

  set nombres(String nombres) {
    _prefs.setString('nombre', nombres);
  }
}
