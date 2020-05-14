package ventaDeCoches.controladores;

import java.util.List;		

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;

import ventaDeCoches.Cliente;
import ventaDeCoches.Controlador;




public class ClienteControlador extends Controlador {

	private static ClienteControlador controlador = null;

	public ClienteControlador () {
		super(Cliente.class, "BaseDatosSwing");
	}
	
	/**
	 * 
	 * @return
	 */
	public static ClienteControlador getControlador () {
		if (controlador == null) {
			controlador = new ClienteControlador();
		}
		return controlador;
	}

	/**
	 *  
	 */
	public Cliente find (int id) {
		return (Cliente) super.find(id);
	}

	
	/**
	 * 
	 * @return
	 */
	public Cliente findFirst () {
		try {
			EntityManager em = getEntityManagerFactory().createEntityManager();
			Query q = em.createQuery("SELECT cli FROM Cliente cli order by cli.id", Cliente.class);
			Cliente resultado = (Cliente) q.setMaxResults(1).getSingleResult();
			em.close();
			return resultado;
		}
		catch (NoResultException nrEx) {
			return null;
		}
	}

	
	
	
	/**
	 * 
	 * @return
	 */
	public Cliente findLast () {
		try {
			EntityManager em = getEntityManagerFactory().createEntityManager();
			Query q = em.createQuery("SELECT cli FROM Cliente cli order by cli.id desc", Cliente.class);
			Cliente resultado = (Cliente) q.setMaxResults(1).getSingleResult();
			em.close();
			return resultado;
		}
		catch (NoResultException nrEx) {
			return null;
		}
	}

	
	
	
	/**
	 * 
	 * @return
	 */
	public Cliente findNext (Cliente cli) {
		try {
			EntityManager em = getEntityManagerFactory().createEntityManager();
			Query q = em.createQuery("SELECT cli FROM Cliente cli where cli.id > :idActual order by cli.id", Cliente.class);
			q.setParameter("idActual", cli.getId());
			Cliente resultado = (Cliente) q.setMaxResults(1).getSingleResult();
			em.close();
			return resultado;
		}
		catch (NoResultException nrEx) {
			return null;
		}
	}

	
	
	
	/**
	 * 
	 * @return
	 */
	public Cliente findPrevious (Cliente c) {
		try {
			EntityManager em = getEntityManagerFactory().createEntityManager();
			Query q = em.createQuery("SELECT c FROM Cliente c where c.id < :idActual order by c.id desc", Cliente.class);
			q.setParameter("idActual", c.getId());
			Cliente resultado = (Cliente) q.setMaxResults(1).getSingleResult();
			em.close();
			return resultado;
		}
		catch (NoResultException nrEx) {
			return null;
		}
	}

	
	
	
	public List<Cliente> findAll () {
		EntityManager em = getEntityManagerFactory().createEntityManager();
		Query q = em.createQuery("SELECT cli FROM Cliente cli", Cliente.class);
		List<Cliente> resultado = (List<Cliente>) q.getResultList();
		em.close();
		return resultado;
	}
	
	public List<Cliente> findAllLimited (int limit, int offset) {
		EntityManager em = getEntityManagerFactory().createEntityManager();
		Query q = em.createQuery("SELECT c FROM Cliente c", Cliente.class);
		q.setMaxResults(limit);
		q.setFirstResult(offset);
		List<Cliente> resultado = (List<Cliente>) q.getResultList();
		em.close();
		return resultado;
	}
	

	
	public static String toString (Cliente cliente) {
		return "Id: " + cliente.getId() + " - Nombre: " + cliente.getNombre() +
				" - CIF: " + cliente.getApellidos() + " - Localidad: " + cliente.getLocalidad() + " - dniNie: " + cliente.getFechaNac() +
				" - fechaNac: " + cliente.getFechaNac() + " - activo: " + cliente.getActivo(); 
	}

	
	
}
