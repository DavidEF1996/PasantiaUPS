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
  get codigoUsuario {
    return _prefs.getInt('codigoUsuario') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set codigoUsuario(int codigoUsuario) {
    _prefs.setInt('codigoUsuario', codigoUsuario);
  }

  get nombres {
    return _prefs.getString('nombre') ?? '';
  }

  set nombres(String nombres) {
    _prefs.setString('nombre', nombres);
  }
}
