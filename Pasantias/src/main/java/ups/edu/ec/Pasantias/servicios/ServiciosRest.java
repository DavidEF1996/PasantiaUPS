package ups.edu.ec.Pasantias.servicios;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import ups.edu.ec.Pasantias.Trascient.CorreoTrascient;
import ups.edu.ec.Pasantias.Trascient.LoginTrasient;
import ups.edu.ec.Pasantias.Trascient.NoticiaModeloTrascient;
import ups.edu.ec.Pasantias.Trascient.NoticiasTrascient;
import ups.edu.ec.Pasantias.Trascient.UsuarioPersonaTrascient;
import ups.edu.ec.Pasantias.Trascient.UsuarioTokenTrascient;
import ups.edu.ec.Pasantias.Trascient.ejemploTra;
import ups.edu.ec.Pasantias.modelo.ChangePass;
import ups.edu.ec.Pasantias.modelo.MensajeError;
import ups.edu.ec.Pasantias.modelo.NoticiaModelo;
import ups.edu.ec.Pasantias.modelo.UsuarioModelo;
import ups.edu.ec.Pasantias.on.CorreoOn;
import ups.edu.ec.Pasantias.on.LoginOn;
import ups.edu.ec.Pasantias.on.NoticiaOn;
import ups.edu.ec.Pasantias.on.PersonaOn;
import ups.edu.ec.Pasantias.on.UsuarioOn;


@Path("/pasantiaServicios")
public class ServiciosRest {
	

	@Inject
	private PersonaOn persona;
	
	@Inject
	private UsuarioOn usuarioOn;
	
	@Inject
	private NoticiaOn noticiaOn;
	
	@Inject
	private LoginOn lon;
	
	@Inject
	private MensajeError msg;
	
	@Inject
	private CorreoOn correo;
	
	@GET
	@Path("devolver/")
	public Response sayHello() {
		return Response.ok("Hello world", MediaType.APPLICATION_JSON).build();
	}

	
	
	
	@POST
	@Produces("application/json")
	@Consumes("application/json")
	@Path("/crear")
	public LoginTrasient insertarDoctor(UsuarioPersonaTrascient dpt) throws Exception {
		System.out.println("El objeto: " +dpt.toString());
		
		System.out.println(dpt.getCedula());
	
		try {
			return persona.insertarUsuario(dpt);
			// "Ingresado correctamente";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("Error dado: " + e.getMessage());
		}

	}
	
	
	@POST
	@Produces("application/json")
	@Consumes("application/json")
	@Path ("/probando")
	public ejemploTra ejemplo(ejemploTra dpt) throws Exception {
		System.out.println("llegue al servicio ejemplo");
		System.out.println(dpt.getNombre()+"");
	
		return dpt;

	}
	
	
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	@Path("/login")
	public UsuarioPersonaTrascient login(LoginTrasient credenciales) {
		System.out.println(credenciales.getUser() + " ");
		System.out.println(credenciales.getPassword() + " ");
		UsuarioPersonaTrascient usuario = new UsuarioPersonaTrascient();
		try {
			UsuarioModelo d = lon.login(credenciales.getUser(), credenciales.getPassword());

			if (d != null) {

				usuario.setNombres(d.getPersona().getNombres());
				System.out.println(usuario.getNombres());
				usuario.setApellidos(d.getPersona().getApellidos());
				usuario.setToken(d.getToken());
				usuario.setBandera(d.getBandera());
				usuario.setTipoUsuario(d.getTipoUsuario());
				usuario.setAcceso(true);
				usuario.setCodigoUsuario(d.getCodigo());
				return usuario;

			} else {

				usuario.setAcceso(false);
				return usuario;
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			usuario.setAcceso(false);
			return usuario;
		}

	}
	
	@POST
	@Produces("application/json")
	@Consumes("application/json")
	@Path("changePass/")
	public Response cambioPass(ChangePass cambio) {

		System.out.println(cambio.getCodigoUsuario());
		try {
			return Response.ok(lon.cambiarPassword(cambio.getCodigoUsuario(), cambio.getPassword()))
					.header("Access-Control-Allow-Origin", "*").build();
		} catch (Exception e) { // TODO
			return Response.ok(msg.mensaje()).header("Access-Control-Allow-Origin", "*").build();
		}
	}
	
	
	@POST
	@Produces("application/json")
	@Consumes("application/json")
	@Path("/crearNoticia")
	public NoticiasTrascient insertarNoticia(NoticiaModeloTrascient dpt) throws Exception {
		System.out.println("llegue");
		System.out.println(dpt.getFechaNoticia());
	
		try {
			return noticiaOn.insertarNoticia(dpt);
			// "Ingresado correctamente";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("Error: " + e.getMessage());
		}

	}
	
	@POST
	@Produces("application/json")
	@Consumes("application/json")
	@Path("/cambiarToken")
	public UsuarioTokenTrascient probando(UsuarioTokenTrascient dpt) throws Exception {
		System.out.println("llegue al servicio");
		System.out.println(dpt.getCodigoUsuario());
	
		try {
			return usuarioOn.actualizarToken(dpt);
			// "Ingresado correctamente";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("Error: " + e.getMessage());
		}
		

	}
	
	/*@POST
	@Produces("application/json")
	@Consumes("application/json")
	@Path("/notificar")
	public Response listar() {

		try {
			return  noticiaOn.notificacion("eNDvdsCwRDuzZOopdg6XOS:APA91bFXhLLB6eI1K3ZXg_SOkHNrlLTf7HSF4-MTrBdTE1619m7QqUBZXa23CmdpQJKnuMIREMSribBgdHIygx7Ji-RmCcOiMKg8qT5UUrnYOSr5cLQntC2j-qmW2ZQ_7y5914y0FIWM",
					"desde postamn","desde postman");
		} catch (Exception e) { // TODO
			//return Response.ok(msg.mensaje()).header("Access-Control-Allow-Origin", "*").build();
		}
		return null;
	}*/
	
	
	@GET
	@Produces("application/json")
	@Consumes("application/json")
	@Path("listaNoticias/{categoria}")
	public Response nombres(@PathParam("categoria") String categoria) {
		try {
			List<NoticiasTrascient> noticiasTras = new ArrayList<NoticiasTrascient>();
			List<NoticiaModelo> datos = noticiaOn.llistaFiltro(categoria);
			for (int i = 0; i < datos.size(); i++) {
				NoticiasTrascient noticia = new NoticiasTrascient();
				
				noticia.setIdNoticia(datos.get(i).getId());
				noticia.setFechaNoticia(datos.get(i).getFecha());
				noticia.setTituloNoticia(datos.get(i).getTitulo());
				noticia.setContenidoNoticia(datos.get(i).getContenido());
				noticia.setCategoriaNoticia(datos.get(i).getCategoria());
				noticia.setImagen(datos.get(i).getImagen());
				noticia.setEnlaces(datos.get(i).getEnlaces());
				noticiasTras.add(noticia);
				
				
			}

			return Response.ok(noticiasTras).header("Access-Control-Allow-Origin", "*").build();
		} catch (Exception e) { // TODO
			return Response.ok(msg.mensaje()).header("Access-Control-Allow-Origin", "*").build();
		}
	}
	
	@GET
	@Produces("application/json")
	@Consumes("application/json")
	@Path("listaGenerales")
	public Response nombres() {
		try {
			List<NoticiasTrascient> noticiasTras = new ArrayList<NoticiasTrascient>();
			List<NoticiaModelo> datos = noticiaOn.listarTodo();
			for (int i = 0; i < datos.size(); i++) {
				NoticiasTrascient noticia = new NoticiasTrascient();
				
				noticia.setIdNoticia(datos.get(i).getId());
				noticia.setFechaNoticia(datos.get(i).getFecha());
				noticia.setTituloNoticia(datos.get(i).getTitulo());
				noticia.setContenidoNoticia(datos.get(i).getContenido());
				noticia.setCategoriaNoticia(datos.get(i).getCategoria());
				noticia.setImagen(datos.get(i).getImagen());
				noticia.setEnlaces(datos.get(i).getEnlaces());
				noticiasTras.add(noticia);
				
				
			}

			return Response.ok(noticiasTras).header("Access-Control-Allow-Origin", "*").build();
		} catch (Exception e) { // TODO
			return Response.ok(msg.mensaje()).header("Access-Control-Allow-Origin", "*").build();
		}
	}
	
	
	
	@GET
	@Produces("application/json")
	@Consumes("application/json")
	@Path("obtenerUsuario/{usuario}")
	public Response obtenerUsuario(@PathParam("usuario") String usuario) {
		System.out.println(usuario);
		try {
	
			UsuarioModelo user = lon.obtenerUsuariosCorreo("davidFegas20");
			System.out.println(user.getCodigo());
		
			return Response.ok(user).header("Access-Control-Allow-Origin", "*").build();
		} catch (Exception e) { // TODO
			return Response.ok(msg.mensaje()).header("Access-Control-Allow-Origin", "*").build();
		}
	}
	
	
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	@Path("/login2")
	public UsuarioPersonaTrascient login2(LoginTrasient credenciales) {
		System.out.println(credenciales.getUser() + " ");
		System.out.println(credenciales.getPassword() + " ");
		UsuarioPersonaTrascient usuario = new UsuarioPersonaTrascient();
		try {
			UsuarioModelo d = lon.login2(credenciales.getUser());

			if (d != null) {

				usuario.setNombres(d.getPersona().getNombres());
				System.out.println(usuario.getNombres());
				usuario.setApellidos(d.getPersona().getApellidos());
				usuario.setToken(d.getToken());
				usuario.setBandera(d.getBandera());
				usuario.setTipoUsuario(d.getTipoUsuario());
				usuario.setAcceso(true);
				usuario.setCodigoUsuario(d.getCodigo());
				usuario.setContrasena(d.getContrasena());
				return usuario;

			} else {

				usuario.setAcceso(false);
				return usuario;
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			usuario.setAcceso(false);
			return usuario;
		}

	}
	
	
	
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	@Path("/correoElectronico")
	public Response correoElectronico(CorreoTrascient datos) {
		System.out.println(datos.getCorreo()+ " ");

		
		try {
			
			correo.sendMail(datos.getCorreo(), datos.getAsunto(), datos.getCuerpo());

			return null;


		} catch (Exception e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			 return null;
			
		}
		

	}
}
