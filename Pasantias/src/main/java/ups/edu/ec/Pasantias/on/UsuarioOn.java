package ups.edu.ec.Pasantias.on;

import javax.ejb.Stateless;
import javax.inject.Inject;

import ups.edu.ec.Pasantias.Trascient.NoticiaModeloTrascient;
import ups.edu.ec.Pasantias.Trascient.NoticiasTrascient;
import ups.edu.ec.Pasantias.Trascient.UsuarioPersonaTrascient;
import ups.edu.ec.Pasantias.Trascient.UsuarioTokenTrascient;
import ups.edu.ec.Pasantias.dao.UsuarioDao;
import ups.edu.ec.Pasantias.modelo.UsuarioModelo;

@Stateless
public class UsuarioOn {
	
	@Inject
	private UsuarioDao usuarioDao;
	
	
	
	/*public NoticiasTrascient actualizar(NoticiaModeloTrascient objeto) throws Exception {
		
		NoticiasTrascient noticia = new NoticiasTrascient();
		
		noticia.setIdNoticia(objeto.getId());
		if (validarNoticia(objeto)) {
			System.out.println("llegue a validar noticia");
			return noticia;
		}else {
			throw new Exception("Error");
		}
		
		
	}*/
	
	public UsuarioTokenTrascient actualizarToken(UsuarioTokenTrascient usuario) {
	
		UsuarioModelo aux= usuarioDao.read(usuario.getCodigoUsuario());
		try {	
			if(aux!= null) {
					
					aux.setToken(usuario.getToken()+"");
					usuarioDao.actualizarUsuario(aux);
					
				
			}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return usuario;
		}


}
