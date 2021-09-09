package ups.edu.ec.Pasantias.on;

import javax.ejb.Stateless;
import javax.inject.Inject;

import ups.edu.ec.Pasantias.dao.UsuarioDao;
import ups.edu.ec.Pasantias.modelo.UsuarioModelo;

@Stateless
public class LoginOn {

	@Inject
	private UsuarioDao userDao;
	
	
	public UsuarioModelo login(String user, String password) throws Exception {
		System.out.println("llega al on");
		UsuarioModelo usuario = userDao.leerLogin(user, password);

		if (usuario != null) {

			return usuario;
		} else {
			return null;
		}

	}
	
	
	public UsuarioModelo login2(String user) throws Exception {
		System.out.println("llega al on");
		
		if(user.contains("@")) {
			UsuarioModelo usuario = userDao.leerLogin3(user);

			if (usuario != null) {

				return usuario;
			} else {
				return null;
			}
			
		}else {
			UsuarioModelo usuario = userDao.leerLogin2(user);

			if (usuario != null) {

				return usuario;
			} else {
				return null;
			}
			
		}
		

	}
	

	public boolean cambiarPassword(int codigoUsuario, String password) {
	UsuarioModelo usuario= null;
	System.out.println("Llegue al metodo cambiar contrasena");
	try {
		usuario = userDao.read(codigoUsuario);
		System.out.println("Llegue al metodo cambiar contrasena" + usuario.getCodigo());
		if (usuario != null) {
			usuario.setContrasena(password);
			usuario.setBandera(1);
			
			userDao.actualizarUsuario(usuario);
			return true;
		}else {
			return false;
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		return false;
	}


	
}
	
	
	public UsuarioModelo obtenerUsuariosCorreo(String usuario) {
		return userDao.obtenerUsuariosCorreo(usuario);
	}
}
