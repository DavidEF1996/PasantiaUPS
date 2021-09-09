package ups.edu.ec.Pasantias.modelo;

import javax.ejb.Stateless;

@Stateless
public class MensajeError {
	
	public String mensaje() {
		return"Usuario inválido";
	}

}
