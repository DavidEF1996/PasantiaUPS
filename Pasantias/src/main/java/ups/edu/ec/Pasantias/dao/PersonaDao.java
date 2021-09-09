package ups.edu.ec.Pasantias.dao;

import java.util.List;

import javax.ejb.Stateless;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import ups.edu.ec.Pasantias.modelo.*;

@Stateless
public class PersonaDao {
	
	@PersistenceContext
	private EntityManager em;
	
	public void insertarPersona(PersonaModelo persona) throws Exception{
		em.persist(persona);
	}
	
	public void actualizarPersona(PersonaModelo persona) throws Exception{
		em.merge(persona);
	}
	
	public PersonaModelo leerPersona(String cedula) throws Exception{
		return em.find(PersonaModelo.class, cedula);
	}
	
	public PersonaModelo leerCorreoPersona (String correo) throws Exception{
		return em.find(PersonaModelo.class, correo);
	}
	
	public List<PersonaModelo> ObtenerPersonas()throws Exception{
		String jpql ="Select p from PersonaModelo p";
		Query query = em.createQuery(jpql, PersonaModelo.class);
		return query.getResultList();
	}

}
