package ups.edu.ec.Pasantias.on;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.ws.rs.core.Response;



import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import ups.edu.ec.Pasantias.Trascient.NoticiaModeloTrascient;
import ups.edu.ec.Pasantias.Trascient.NoticiasTrascient;
import ups.edu.ec.Pasantias.dao.NoticiaDao;
import ups.edu.ec.Pasantias.dao.PersonaDao;
import ups.edu.ec.Pasantias.dao.UsuarioDao;
import ups.edu.ec.Pasantias.modelo.NoticiaModelo;
import ups.edu.ec.Pasantias.modelo.PersonaModelo;
import ups.edu.ec.Pasantias.modelo.UsuarioModelo;

@Stateless
public class NoticiaOn {
	
	@Inject
	private NoticiaDao noticiaDao;
	
	@Inject
	private PersonaDao personaDao;
	
	@Inject
	private UsuarioDao userDao;
	
	
		public NoticiasTrascient insertarNoticia(NoticiaModeloTrascient objeto) throws Exception {
			
			NoticiasTrascient noticia = new NoticiasTrascient();
			
			noticia.setIdNoticia(objeto.getId());
			if (validarNoticia(objeto)) {
				System.out.println("llegue a validar noticia");
				return noticia;
			}else {
				throw new Exception("Error");
			}
			
			
		}
		
		
		public boolean validarNoticia(NoticiaModeloTrascient objeto) throws Exception {
			NoticiaModelo noticia = new NoticiaModelo();
			UsuarioModelo usuario = userDao.read(objeto.getCodigoUsuario());
			
			//System.out.println("El codigo que se pasa del objeto es: " +objeto.getCodigoUsuario());
			System.out.println("El codigo que se pasa del objeto es: " +objeto.getId());
			
			System.out.println("La lectura del usuario es: " + usuario.getTipoUsuario());
			//PersonaModelo persona = personaDao.leerPersona(objeto.getCedula());
			
			//noticia.setId(objeto.getId());
			//noticia.set
			
			noticia.setFecha(objeto.getFechaNoticia());
			//noticia.setImagen(objeto.getImagen());
			System.out.println("La fecha es: " +objeto.getFechaNoticia());
			noticia.setImagen(objeto.getImagen());
			noticia.setTitulo(objeto.getTitulo());
			noticia.setContenido(objeto.getContenido());
			noticia.setCategoria(objeto.getCategoria());
			noticia.setEnlaces(objeto.getEnlaces());
			usuario.addNoticia(noticia);
			
			
			//NoticiaModelo noticiaVerificar = noticiaDao.leerNoticias(objeto.getId());
			//System.out.println("La noticia verificada es: " + noticiaVerificar.getTitulo());
			
			//if (noticiaVerificar!=null) {
				//throw new Exception("La noticia ya existe");

			//}else {
			noticiaDao.insertarNoticia(noticia);
			List<UsuarioModelo> recibir = userDao.listaUsuariosCategoria("usuarios");
			
			
			
			
			for (int i = 0; i < recibir.size(); i++) {
				System.out.println("los datos son: " + recibir.get(i).getToken());
				notificacion(recibir.get(i).getToken(), noticia.getCategoria().toUpperCase(), noticia.getTitulo(), noticia.getImagen(), noticia.getId());
			}
				
				
				return true;
			//}
			
		
		}
		
		
		
		public Response notificacion (String apiCodigo, String categoria, String titulo, String urlImage, int contenido) throws IOException {
			final String apiKey = "AAAAo88Ijfw:APA91bE5tH-mwLbP5yijQIyIdY_iU9k_8xS1Pqn5vw1cbGtFY6Y6isLjW6QnmqkMNWo4TSPIJvWgib3cpURQbaFukaMMWTW2Dc2ApaFdzzEGBtsHkS37KpP6AYGfr_56Gbdy0w9uAo5n";
			URL url = new URL("https://fcm.googleapis.com/fcm/send");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Authorization", "key=" + apiKey);
			//String apiCodigo="chtVY6_tRTmEytBagiFZG3:APA91bFugWDZI5G7osSEgMAdP3UqYWTgXihLIv4dxb7i-s_gJ5E0jG_zTJ6OR12W_oxeGVQN3uHI8y6hGyaryF428TVU1qDaXWyq8z_Nzqdo-bArizoHKMA7xKNlw9_Mv7HS7TGJKGbm";
			String codigoEnviar = "\"".concat(apiCodigo).concat("\"");
			String categoriaEnviar = "\"".concat(categoria).concat("\"");
			String tituloEnviar = "\"".concat(titulo).concat("\"");
			String contenidoEnviar = "\"".concat(contenido+"").concat("\"");
			String urlEnviar = "\"".concat(urlImage).concat("\"");
			conn.setDoOutput(true);

			String input = "{\"notification\" : {\"title\" :" +categoriaEnviar +" ,\"body\": "+tituloEnviar +", \"image\": " + urlEnviar +" }, "
					+ "\"data\" : {\"categoria\" : " + categoriaEnviar + ",\"contenido\":" + tituloEnviar +"}, "				
					+ "\"to\":"
					+ codigoEnviar+"}";

			OutputStream os = conn.getOutputStream();
			os.write(input.getBytes());
			os.flush();
			os.close();

			int responseCode = conn.getResponseCode();
			System.out.println("\nSending 'POST' request to URL : " + url);
			System.out.println("Post parameters : " + input);
			System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
			    response.append(inputLine);
			}
			in.close();

			// print result
			System.out.println(response.toString());
			return null;
		}
		
		public List<NoticiaModelo> llistaFiltro(String categoria)throws Exception{
			System.out.println("la categoria"+categoria);
			return noticiaDao.listaNoticias(categoria);
		}
		
		
		public List<NoticiaModelo> listarTodo()throws Exception{
			return noticiaDao.listarTodo();
		}
}
