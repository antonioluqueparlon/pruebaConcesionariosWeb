package servlets;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utils.FormularioIncorrectoRecibidoException;
import Utils.RequestUtils;
import Utils.SuperTipoServlet;
import ventaDeCoches.Concesionario;
import ventaDeCoches.controladores.ConcesionarioControlador;


/**
 * Servlet implementation class PrimerServlet
 */
@WebServlet(description = "Ficha de Concesionario", urlPatterns = { "/servlets/Serv02_FichaConcesionario" })
public class Serv02_FichaConcesionario extends SuperTipoServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Serv02_FichaConcesionario() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HashMap<String, Object> hashMap = RequestUtils.requestToHashMap(request);
		Concesionario concesionario = new Concesionario();
		
		

// Para plasmar la información de un profesor determinado utilizaremos un parámetro, que debe llegar a este Servlet obligatoriamente
// El parámetro se llama "idProfesor" y gracias a él podremos obtener la información del profesor y mostrar sus datos en pantalla

// Obtengo el profesor a editar, en el caso de que el profesor exista se cargarán sus datos, en el caso de que no exista quedará a null
		try {
			int idConcesionario = RequestUtils.getIntParameterFromHashMap(hashMap, "idConcesionario"); // Necesito obtener el id del concesionario que se quiere editar en caso de un alto																								
			if (idConcesionario != 0) {
				concesionario = (Concesionario) ConcesionarioControlador.getControlador().find(idConcesionario);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (concesionario == null) {
			concesionario = new Concesionario();
		}
		
		if (concesionario.getCif() == null) concesionario.setCif("");
		if (concesionario.getNombre() == null) concesionario.setNombre("");
		if (concesionario.getLocalidad() == null) concesionario.setLocalidad("");

// Ahora debo determinar cuál es la acción que este página debería llevar a cabo, en función de los parámetros de entrada al Servlet.
// Las acciones que se pueden querer llevar a cabo son tres:
//    - "eliminar". Sé que está es la acción porque recibiré un un parámetro con el nombre "eliminar" en el request
//    - "guardar". Sé que está es la acción elegida porque recibiré un parámetro en el request con el nombre "guardar"
//    - Sin acción. En este caso simplemente se quiere editar la ficha

// Variable con mensaje de información al usuario sobre alguna acción requerida
		String mensajeAlUsuario = "";

// Primera acción posible: eliminar
		if (RequestUtils.getStringParameterFromHashMap(hashMap, "eliminar") != null) {
// Intento eliminar el registro, si el borrado es correcto redirijo la petición hacia el listado de concesionarios
			try {
				ConcesionarioControlador.getControlador().remove(concesionario);
				response.sendRedirect(request.getContextPath() + "/servlets/Serv01_ListadoConcesionarios");// Redirección del response al listado
			}catch (Exception e) {
				mensajeAlUsuario = "Imposible eliminar. Es posible que existan restricciones.";
			}
		}

// Segunda acción posible: guardar
		if (RequestUtils.getStringParameterFromHashMap(hashMap, "guardar") != null) {
// Obtengo todos los datos del profesor y los almaceno en BBDD
			try {
				concesionario.setNombre(RequestUtils.getStringParameterFromHashMap(hashMap, "nombre"));
				concesionario.setCif(RequestUtils.getStringParameterFromHashMap(hashMap, "cif"));
				concesionario.setLocalidad(RequestUtils.getStringParameterFromHashMap(hashMap, "localidad"));
				byte[] imagen = RequestUtils.getByteArrayFromHashMap(hashMap, "ficheroImagen");
				if (imagen != null && imagen.length > 0) concesionario.setImagen(imagen);

				ConcesionarioControlador.getControlador().save(concesionario);
				mensajeAlUsuario = "Guardado correctamente";
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}

		// Ahora muestro la pantalla de respuesta al usuario

		response.getWriter().append("<!DOCTYPE html PUBLIC \\\"-//W3C//DTD XHTML 1.0 Transitional//EN\\\" \\\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\\\">\r\n" +
		"<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n" +
		"<head>\r\n" +
		"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\r\n" +
		"<title>Ficha Concesionario</title>\r\n" +
		"</head>\r\n" +
		"<script> \r\n" +
		"function validateForm() {" +
		"var cif = document.forms[\"formulario\"][\"cif\"].value;" +
		"var nombre = document.forms[\"formulario\"][\"nombre\"].value;" +
		"var localidad = document.forms[\"formulario\"][\"localidad\"].value;" +
		"if (cif == \"\"){" +
		"alert (\"Introduce un CIF\");"+
		"return false;"+
		"}" +
		"if (nombre == \"\"){" +
		"alert (\"Introduce el campo nombre\");"+
		"return false;"+
		"}" +
		"if (localidad == \"\"){" +
		"alert (\"Introducido una localidad\");"+
		"return false;"+
		"}" +
		"}" +
		"</script>\r\n" +
		"\r\n" +
		"<body " +((mensajeAlUsuario != null && mensajeAlUsuario != "")? "onLoad=\"alert('" + mensajeAlUsuario + "');\"" : "")  + " >\r\n" +
		"<h1>Ficha de concesionario</h1>\r\n" +
		"<a href=\"Serv01_ListadoConcesionarios\">Ir al listado de concesionario</a>" +
		"<form id=\"formulario\" name=\"formulario\" method=\"post\" action=\"Serv02_FichaConcesionario\" enctype=\"multipart/form-data\" onsubmit=\"return validateForm()\" >\r\n" + // quitar el multipa funciona todo menos eso
		" <img src=\"../utils/DownloadImagenConcesionario?idConcesionario=" + concesionario.getId() + "\" width='100px' height='100px'/>" + //  Se ve el cuadro pero no me guarda en la bbdd la foto ni me la muestra, en el momento de meter el multipart peta
		" <input type=\"hidden\" name=\"idConcesionario\" value=\"" + ((concesionario != null)? concesionario.getId() : "") + "\"\\>" +
		"  <p>\r\n" + 
		"    <label for=\"ficheroImagen\">Imagen:</label>\r\n" + 
		"    <input name=\"ficheroImagen\" type=\"file\" id=\"ficheroImagen\" />\r\n" + 
		"  </p>\r\n" + 
		"  <p>\r\n" +
		"    <label for=\"cif\">CIF:</label>\r\n" +
		"    <input name=\"cif\" type=\"text\" id=\"cif\"  value=\"" + ((concesionario != null)? concesionario.getCif() : "") + "\" />\r\n" +
		"  </p>\r\n" +
		"  <p>\r\n" +
		"    <label for=\"nombre\">Nombre: </label>\r\n" +  
		"    <input name=\"nombre\" type=\"text\" id=\"nombre\" value=\"" + ((concesionario != null)? concesionario.getNombre() : "") + "\" />\r\n" +
		"  </p>\r\n" +
		"  <p>\r\n" +
		"    <label for=\"localidad\">Localidad: </label>\r\n" +
		"    <input name=\"localidad\" type=\"text\" id=\"localidad\" value=\"" + ((concesionario != null)? concesionario.getLocalidad() : "") + "\" />\r\n" +
		"  </p>\r\n" +
		"  <p>\r\n" +
		" <input type=\"submit\"  name=\"nuevo\" value=\"Nuevo\"  onclick=\"window.location='Serv02_FichaConcesionario?idConcesionario=0'\"/>" +
		"</body>\r\n" +
		"    <input type=\"submit\" name=\"guardar\" value=\"Guardar\" />\r\n" +
		"    <input type=\"submit\" name=\"eliminar\" value=\"Eliminar\" />\r\n" +
		"  </p>\r\n" +
		"</form>"); 
		response.getWriter().append(this.getPieHTML());
	}
	
	//enctype=\"multipart/form-data\"

}