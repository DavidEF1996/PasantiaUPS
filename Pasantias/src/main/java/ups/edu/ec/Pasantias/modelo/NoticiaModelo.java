package ups.edu.ec.Pasantias.modelo;



import java.time.LocalDate;
import java.util.Arrays;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="Noticias")
public class NoticiaModelo {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_noticia")
	private int id;
	
	@Column(name = "fecha_noticia")
	private LocalDate fecha;
	
	@Column (name = "imagen_noticia")
	private String imagen;
	
	@Column (name = "titulo_noticia")
	private String titulo;
	
	@Column (name = "contenido_noticia")
	private String contenido;
	
	@Column (name ="categoria_noticia")
	private String categoria;
	
	@Column (name ="enlace_noticia")
	private String enlaces;
	
	@ManyToOne
	private UsuarioModelo usuario;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}



	public LocalDate getFecha() {
		return fecha;
	}

	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
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

	public UsuarioModelo getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioModelo usuario) {
		this.usuario = usuario;
	}

	public String getEnlaces() {
		return enlaces;
	}

	public void setEnlaces(String enlaces) {
		this.enlaces = enlaces;
	}

	@Override
	public String toString() {
		return "NoticiaModelo [id=" + id + ", fecha=" + fecha + ", imagen=" + imagen + ", titulo=" + titulo
				+ ", contenido=" + contenido + ", categoria=" + categoria + ", enlaces=" + enlaces + ", usuario="
				+ usuario + "]";
	}


	
	
	

}
