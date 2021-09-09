package ups.edu.ec.Pasantias.modelo;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Persona")
public class PersonaModelo {
	
	@Id
	@Column(name = "prs_cedula")
	private String cedula;
	
	@Column(name = "prs_nombres")
	private String nombres;
	
	@Column(name = "prs_apellidos")
	private String apellidos;
	
	@Column(name = "prs_fecha_nacimiento")
	private String fechaNacimiento;
	
	public String getCedula() {
		return cedula;
	}

	public void setCedula(String cedula) {
		this.cedula = cedula;
	}



	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public String getNombres() {
		return nombres;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public String getApellidos() {
		return apellidos;
	}

	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	

}

