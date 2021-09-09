package ups.edu.ec.Pasantias.on;

import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;

import ups.edu.ec.Pasantias.modelo.*;
import ups.edu.ec.Pasantias.dao.*;
import ups.edu.ec.Pasantias.Trascient.*;


@Stateless
public class PersonaOn {

	
	@Inject
	private PersonaDao personaDao;
	
	@Inject
	private UsuarioDao usuarioDao;
	
	
	public LoginTrasient insertarUsuario(UsuarioPersonaTrascient objeto) throws Exception {
		LoginTrasient login  = new LoginTrasient();
		System.out.println("el usuario recibido es:" +objeto.getCodigoUsuario());
		login.setUser(objeto.getUsuario());
		login.setPassword(objeto.getContrasena());
		try {
			if (validarDoctor(objeto)) {
				System.out.println("llegue");
				return login;
				
			} 
		} catch (Exception e) {
			// TODO: handle exception
		throw new Exception("Error dado");
			
		}
		return null;
	
	
		

	}
	public boolean validarDoctor(UsuarioPersonaTrascient objeto) throws Exception {

		UsuarioModelo usuario = new UsuarioModelo();
		PersonaModelo persona = new PersonaModelo();


		persona.setCedula(objeto.getCedula());
		persona.setNombres(objeto.getNombres());
		persona.setApellidos(objeto.getApellidos());
		persona.setFechaNacimiento(objeto.getFechaNacimiento());

	
		//usuario.setCodigo(objeto.getCodigoUsuario());
		usuario.setUsuario(objeto.getUsuario());
		usuario.setContrasena(objeto.getContrasena());
		usuario.setTipoUsuario(objeto.getTipoUsuario());
		usuario.setToken(objeto.getToken());
		usuario.setCorreo(objeto.getCorreo());
		
		usuario.setBandera(0);
		
		
		

		//UsuarioModelo usuarioVerificacion = usuarioDao.leerUsuariosPorNombre(objeto.getCodigoUsuario());
		PersonaModelo personaVerificacion = personaDao.leerPersona(objeto.getCedula());
		//System.out.println("EL" + usuarioVerificacion.getUsuario());
		boolean respuesta = false;
		
		try {
if (personaVerificacion == null) {
				
				System.out.println("Creando usuario....");
				personaDao.insertarPersona(persona);
				usuario.setPersona(persona);
				usuarioDao.insertarUsuario(usuario);
			respuesta = true;
}
			
		} catch (Exception e) {
			respuesta=false;
		}
			/*if (usuarioVerificacion == null) {
				
				System.out.println("Creando usuario....");
				personaDao.insertarPersona(persona);
				usuario.setPersona(persona);
				usuarioDao.insertarUsuario(usuario);
			respuesta = true;
				
			}else {
				
				System.out.println("LLegue a donde no se crea el usuario ni nada" + usuarioVerificacion.getUsuario());
				respuesta = false;
				
			}*/
			return respuesta;
		}


	
	
	public List<UsuarioModelo> getNombres(String nombres) throws Exception{
		return usuarioDao.obtenerListaUsuarios(nombres);
	}
}
