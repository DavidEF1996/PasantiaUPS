package ups.edu.ec.Pasantias.Trascient;

import java.time.LocalDate;
import java.util.Date;

import ups.edu.ec.Pasantias.modelo.UsuarioModelo;

public class NoticiaModeloTrascient {
	
	private int id;
	private LocalDate fechaNoticia;
	private String imagen;
	private String titulo;
	private String contenido;
	private String categoria;
	private int codigoUsuario;
	private String enlaces;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	public LocalDate getFechaNoticia() {
		return fechaNoticia;
	}
	public void setFechaNoticia(LocalDate fechaNoticia) {
		this.fechaNoticia = fechaNoticia;
	}


	public String getImagen() {
		return imagen;
	}
	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getContenido() {
		return contenido;
	}
	public void setContenido(String contenido) {
		this.contenido = contenido;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public int getCodigoUsuario() {
		return codigoUsuario;
	}
	public void setCodigoUsuario(int codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}
	public String getEnlaces() {
		return enlaces;
	}
	public void setEnlaces(String enlaces) {
		this.enlaces = enlaces;
	}

	
	
	

	
	
	
	
	
	
}
