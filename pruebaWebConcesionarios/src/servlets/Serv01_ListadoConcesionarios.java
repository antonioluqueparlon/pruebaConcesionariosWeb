package servlets;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ventaDeCoches.Concesionario;
import ventaDeCoches.controladores.ConcesionarioControlador;




/**
 * Servlet implementation class PrimerServlet
 */
@WebServlet(description = "Listado de Concesionarios", urlPatterns = { "/servlets/Serv01_ListadoConcesionarios" })
public class Serv01_ListadoConcesionarios extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Serv01_ListadoConcesionarios() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n" + 
				"<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n" + 
				"<head>\r\n" + 
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\r\n" + 
				"</head>\r\n" + 
				"\r\n" + 
				"<body>\r\n" + 
				"<h1>Listado de Concesionarios</h1>\r\n" + 
				"<table width=\"95%\" border=\"1\">\r\n" + 
				"  <tr>\r\n" +  
				"    <th scope=\"col\">CIF</th>\r\n" + 
				"    <th scope=\"col\">Nombre</th>\r\n" + 
				"    <th scope=\"col\">Localidad</th>\r\n" +
				"  </tr>\r\n");
		// Hasta la fila anterior ha llegado la primera fila de títulos de la tabla de concesionares 
		// En las siguietnes líneas se crea una fila "elemento <tr>" por cada fila de la tabla de BBDD "concesionario"
		List<Concesionario> concesionarios = ConcesionarioControlador.getControlador().findAll();
		for (Concesionario concesionario : concesionarios) {
			response.getWriter().append("" +
				"  <tr>\r\n" + 
				"    <td><a href=\"Serv02_FichaConcesionario?idConcesionario=" + concesionario.getId() + "\">" + concesionario.getCif() + "</a></td>\r\n" + 
				"    <td>" + concesionario.getNombre() + "</td>\r\n" + 
				"    <td>" + concesionario.getLocalidad() + "</td>\r\n" + 
				"  </tr>\r\n");
		}
		// Al finalizar de exponer la lista de concesionarios termino la tabla y cierro el fichero HTML
		response.getWriter().append("" + 
		"</table>\r\n" + 
		"<p/><input type=\"submit\"  name=\"nuevo\" value=\"Nuevo\"  onclick=\"window.location='Serv02_FichaConcesionario?idConcesionario=0'\"/>" + 
		"</body>\r\n" + 
		"</html>\r\n" + 
		"");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
