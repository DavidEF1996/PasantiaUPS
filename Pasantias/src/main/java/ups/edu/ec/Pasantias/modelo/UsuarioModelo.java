package ups.edu.ec.Pasantias.modelo;


import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;


@Entity
@Table(name = "Usuario")
public class UsuarioModelo {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "codigo_usuario")
	private int codigo;
	
	@Column(name = "nombre_usuario")
	private String usuario;
	
	@Column(name = "contrasena_usuario")
	private String contrasena;
	
	@Column (name = "bandera_usuario")
	private int bandera;
	
	@Column(name = "tipo_usuario")
	private String tipoUsuario;
	
	@Column(name = "token_usuario")
	private String token;
	
	@Column(name = "correo_usuario")
	private String correo;
	

	@OneToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "persona_prs_cedula")
	private PersonaModelo persona;
	
	@OneToMany(cascade=CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "usuario_codigo_usuario")
	private List<NoticiaModelo> noticias;

	
	

	
	public int getCodigo() {
		return codigo;
	}





	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}





	public String getUsuario() {
		return usuario;
	}





	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}





	public String getContrasena() {
		return contrasena;
	}





	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}





	public int getBandera() {
		return bandera;
	}





	public void setBandera(int bandera) {
		this.bandera = bandera;
	}





	public String getTipoUsuario() {
		return tipoUsuario;
	}





	public void setTipoUsuario(String tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}





	public String getToken() {
		return token;
	}





	public void setToken(String token) {
		this.token = token;
	}





	public PersonaModelo getPersona() {
		return persona;
	}





	public void setPersona(PersonaModelo persona) {
		this.persona = persona;
	}





	public List<NoticiaModelo> getNoticia() {
		return noticias;
	}





	public void setNoticia(List<NoticiaModelo> noticia) {
		this.noticias = noticia;
	}





	public void addNoticia( NoticiaModelo noticia) {
		if(noticias == null)
			noticias = new ArrayList<NoticiaModelo>();
		noticias.add(noticia);
	}





	public String getCorreo() {
		return correo;
	}





	public void setCorreo(String correo) {
		this.correo = correo;
	}





	@Override
	public String toString() {
		return "UsuarioModelo [codigo=" + codigo + ", usuario=" + usuario + ", contrasena=" + contrasena + ", bandera="
				+ bandera + ", tipoUsuario=" + tipoUsuario + ", token=" + token + ", correo=" + correo + ", persona="
				+ persona + ", noticias=" + noticias + "]";
	}






	

}
