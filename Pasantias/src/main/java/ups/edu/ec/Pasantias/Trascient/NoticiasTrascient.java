package ups.edu.ec.Pasantias.Trascient;

import java.time.LocalDate;
import java.util.Date;

import ups.edu.ec.Pasantias.modelo.*;

public class NoticiasTrascient {
	
	private int idNoticia;
	private LocalDate fechaNoticia;
	private String tituloNoticia;
	private String imagen;
	private String contenidoNoticia;
	private String categoriaNoticia;
	private UsuarioModelo usuario;
	private String enlaces;
	public int getIdNoticia() {
		return idNoticia;
	}
	public void setIdNoticia(int idNoticia) {
		this.idNoticia = idNoticia;
	}

	public LocalDate getFechaNoticia() {
		return fechaNoticia;
	}
	public void setFechaNoticia(LocalDate fechaNoticia) {
		this.fechaNoticia = fechaNoticia;
	}
	public String getTituloNoticia() {
		return tituloNoticia;
	}
	public void setTituloNoticia(String tituloNoticia) {
		this.tituloNoticia = tituloNoticia;
	}
	public String getContenidoNoticia() {
		return contenidoNoticia;
	}
	public void setContenidoNoticia(String contenidoNoticia) {
		this.contenidoNoticia = contenidoNoticia;
	}
	public String getCategoriaNoticia() {
		return categoriaNoticia;
	}
	public void setCategoriaNoticia(String categoriaNoticia) {
		this.categoriaNoticia = categoriaNoticia;
	}
	public UsuarioModelo getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioModelo usuario) {
		this.usuario = usuario;
	}
	
	public String getImagen() {
		return imagen;
	}
	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	

	public String getEnlaces() {
		return enlaces;
	}
	public void setEnlaces(String enlaces) {
		this.enlaces = enlaces;
	}
	
	
	
}
