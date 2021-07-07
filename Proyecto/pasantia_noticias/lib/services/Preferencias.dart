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
    return _prefs.getString('id') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set id(String id) {
    _prefs.setString('id', id);
  }

  get nombres {
    return _prefs.getString('nombre') ?? '';
  }

  set nombres(String nombres) {
    _prefs.setString('nombre', nombres);
  }

  get roles {
    return _prefs.getString('rol') ?? '';
  }

  set roles(String roles) {
    _prefs.setString('rol', roles);
  }

  get idNoticias {
    return _prefs.getString('idNoticias') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set idNoticias(String idNoticias) {
    _prefs.setString('idNoticias', idNoticias);
  }

  get categorias {
    return _prefs.getString('categoria') ?? '';
  }

  set categorias(String categorias) {
    _prefs.setString('categoria', categorias);
  }

  get numeroNoticia {
    return _prefs.getInt('numeroNoticia') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set numeroNoticia(int numeroNoticia) {
    _prefs.setInt('numeroNoticia', numeroNoticia);
  }

  get noticia1 {
    return _prefs.getInt('noticia1') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set noticia1(int noticia1) {
    _prefs.setInt('noticia1', noticia1);
  }

  get noticia2 {
    return _prefs.getInt('noticia2') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set noticia2(int noticia2) {
    _prefs.setInt('noticia2', noticia2);
  }

  get noticia3 {
    return _prefs.getInt('noticia3') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set noticia3(int noticia3) {
    _prefs.setInt('noticia3', noticia3);
  }

  get noticia4 {
    return _prefs.getInt('noticia4') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set noticia4(int noticia4) {
    _prefs.setInt('noticia4', noticia4);
  }

  get contadorGenerales {
    return _prefs.getInt('contadorGenerales') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set contadorGenerales(int contadorGenerales) {
    _prefs.setInt('contadorGenerales', contadorGenerales);
  }
}
