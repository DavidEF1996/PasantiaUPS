package ups.edu.ec.Pasantias.dao;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;


import ups.edu.ec.Pasantias.modelo.NoticiaModelo;
import ups.edu.ec.Pasantias.modelo.UsuarioModelo;

@Stateless
public class NoticiaDao {

	@PersistenceContext
	private EntityManager em;
	
	
	public void insertarNoticia(NoticiaModelo noticia) throws Exception {
		em.persist(noticia);
	}
	
	public NoticiaModelo leerNoticias(int id) {
		return em.find(NoticiaModelo.class, id);
	}
	

	public List<NoticiaModelo> listaNoticias(String categoria) throws Exception {
		
		String jpql = "SELECT p FROM NoticiaModelo p WHERE p.categoria LIKE :categoria  order by p.id desc";
		TypedQuery<NoticiaModelo> query = em.createQuery(jpql, NoticiaModelo.class);
		query.setParameter("categoria", categoria);
		return query.getResultList();
	}

	
	public List<NoticiaModelo> listarTodo() throws Exception {
		
		String jpql = "SELECT p FROM NoticiaModelo p  order by p.id desc";
		TypedQuery<NoticiaModelo> query = em.createQuery(jpql, NoticiaModelo.class);	
		return query.getResultList();
	}



}
