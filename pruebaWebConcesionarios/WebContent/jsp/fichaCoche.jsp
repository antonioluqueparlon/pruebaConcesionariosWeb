<%@ page
	import="java.util.List, 
	java.util.HashMap,
	Utils.RequestUtils,
	ventaDeCoches.Fabricante,
	ventaDeCoches.Coche,
	ventaDeCoches.controladores.CocheControlador,
	ventaDeCoches.controladores.FabricanteControlador"%>

<jsp:include page="cabecera.jsp" flush="true">
	<jsp:param name="tituloDePagina" value="Ficha de Coches" />
</jsp:include>

<ul class="breadcrumb">
  <li class="breadcrumb-item"><a href="../index.html">MENU BASE DE DATOS</a></li>
  <li class="breadcrumb-item"><a href="menus/menucoches.html">COCHES</a></li>
  <li class="breadcrumb-item active">Ficha Coche
</ul>


<%
	// Obtengo una HashMap con todos los parámetros del request, sea este del tipo que sea;
HashMap<String, Object> hashMap = RequestUtils.requestToHashMap(request);
// Para plasmar la información de un profesor determinado utilizaremos un parámetro, que debe llegar a este Servlet obligatoriamente
// El parámetro se llama "idProfesor" y gracias a él podremos obtener la información del profesor y mostrar sus datos en pantalla
Coche coche = null;
// Obtengo el profesor a editar, en el caso de que el profesor exista se cargarán sus datos, en el caso de que no exista quedará a null
try {
	int idCoche = RequestUtils.getIntParameterFromHashMap(hashMap, "idCoche"); // Necesito obtener el id del profesor que se quiere editar. En caso de un alta
	// de profesor obtendríamos el valor 0 como idProfesor
	if (idCoche != 0) {
		coche = (Coche) CocheControlador.getControlador().find(idCoche);
	}
} catch (Exception e) {
	e.printStackTrace();
}
// Inicializo unos valores correctos para la presentación del profesor
if (coche == null) {
	coche = new Coche();
}
if (coche.getBastidor() == null)
	coche.setBastidor("");
if (coche.getFabricante() == null) 
	coche.setFabricante((Fabricante) FabricanteControlador.getControlador().find(1) );
if (coche.getColor() == null)
	coche.setColor("");
if (coche.getModelo() == null)
	coche.setModelo("");
// Ahora debo determinar cuál es la acción que este página debería llevar a cabo, en función de los parámetros de entrada al Servlet.
// Las acciones que se pueden querer llevar a cabo son tres:
//    - "eliminar". Sé que está es la acción porque recibiré un un parámetro con el nombre "eliminar" en el request
//    - "guardar". Sé que está es la acción elegida porque recibiré un parámetro en el request con el nombre "guardar"
//    - Sin acción. En este caso simplemente se quiere editar la ficha
// Variable con mensaje de información al usuario sobre alguna acción requerida
String mensajeAlUsuario = "";
// Primera acción posible: eliminar
if (RequestUtils.getStringParameterFromHashMap(hashMap, "eliminar") != null) {
	// Intento eliminar el registro, si el borrado es correcto redirijo la petición hacia el listado de profesores
	try {
		CocheControlador.getControlador().remove(coche);
		response.sendRedirect(request.getContextPath() + "/jsp/listadoCoches.jsp?idPag=1"); // Redirección del response hacia el listado
		mensajeAlUsuario="Eliminado Correctamente";
	} catch (Exception ex) {
		mensajeAlUsuario = "ERROR - Imposible eliminar. Es posible que existan restricciones.";
	}
	mensajeAlUsuario="Eliminado Correctamente";
}
// Segunda acción posible: guardar
if (RequestUtils.getStringParameterFromHashMap(hashMap, "guardar") != null) {
	// Obtengo todos los datos del profesor y los almaceno en BBDD
	try {
		coche.setBastidor(RequestUtils.getStringParameterFromHashMap(hashMap, "bastidor"));
		coche.setColor(RequestUtils.getStringParameterFromHashMap(hashMap, "color"));
		coche.setModelo(RequestUtils.getStringParameterFromHashMap(hashMap, "modelo"));
		coche.setFabricante((Fabricante) FabricanteControlador.getControlador().find(RequestUtils.getIntParameterFromHashMap(hashMap, "idFabricante")));
		
		byte[] posibleImagen = RequestUtils.getByteArrayFromHashMap(hashMap, "ficheroImagen");
		if (posibleImagen != null && posibleImagen.length > 0) {
			coche.setImagen(posibleImagen);
		}
		
		// Finalmente guardo el objeto de tipo profesor 
		FabricanteControlador.getControlador().save(coche);
		mensajeAlUsuario = "Guardado correctamente";
	} catch (Exception e) {
		throw new ServletException(e);
	}
}
// Ahora muestro la pantalla de respuesta al usuario
%>

<body>


<div class="container py-3">
	<%
		String tipoAlerta = "alert-success";
	if (mensajeAlUsuario != null && mensajeAlUsuario != "") {
		if (mensajeAlUsuario.startsWith("ERROR")) {
			tipoAlerta = "alert-danger";
		}
	%>
	<div class="alert <%=tipoAlerta%> alert-dismissible fade show">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<%=mensajeAlUsuario%>
	</div>
	<%
		}
	%>
	<div class="row">
		<div class="mx-auto col-sm-6">
			<!-- form user info -->
			<div class="card">
				<div class="card-header">
					<h4 class="mb-0">Ficha de coche</h4>
				</div>
				<div class="card-body">
						<a href="listadoCoches.jsp?idPag=1" class="btn btn-warning btn-sm" role="button">Ir al listado de Coche</a>					
						<form id="form1" name="form1" method="post" action="fichaCoche.jsp" enctype="multipart/form-data" class="form" role="form" autocomplete="off">
						<p />
						<img class="mx-auto d-block rounded-circle" src="../utils/DownloadImagenCoche?idCoche=<%=coche.getId()%>" width='100px' height='100px'/>
						<p />
						<input type="hidden" name="idCoche" value="<%=coche.getId()%>" />
							
							<div class="form-group row">
							<label class="col-lg-3 col-form-label form-control-label" for="ficheroImagen">Imagen:</label> 
							<div class="col-lg-9">
								<input name="ficheroImagen" class="form-control-file" type="file" id="ficheroImagen" />
							</div> 
						</div>
						<div class="form-group row">
							<label class="col-lg-3 col-form-label form-control-label"
								for="modelo">Modelo:</label>
							<div class="col-lg-9">
								<input name="modelo" class="form-control" type="text"
									id="modelo" value="<%=coche.getModelo()%>" />
							</div>
						</div>
						<div class="form-group row">
							<label class="col-lg-3 col-form-label form-control-label"
								for="color">Color:</label>
							<div class="col-lg-9">
								<input name="color" class="form-control" type="text"
									id="color" value="<%=coche.getColor()%>" />
							</div>
						</div>
						<div class="form-group row">
							<label class="col-lg-3 col-form-label form-control-label"
								for="bastidor">Bastidor:</label>
							<div class="col-lg-9">
								<input name="bastidor" class="form-control" type="text"
									id="nombre" value="<%=coche.getBastidor()%>" />
							</div>
						</div>
						<div class="form-group row">
					 	<label class="col-lg-3 col-form-label form-control-label" for="idFabricante">Fabricante:</label>
					 	<div class="col-lg-9">
					 		<select name="idFabricante" id="idFabricante"
									class="form-control">
									<%
										// Inserto los valores del fabricante y, si el registro tiene un valor concreto, lo establezco
									List<Fabricante> fabricantes = FabricanteControlador.getControlador().findAll();
									for (Fabricante fabricante : fabricantes) {
									%>
									<option value="<%=fabricante.getId()%>"
										<%=((fabricante.getId() == coche.getFabricante().getId()) ? "selected=\"selected\"" : "")%>><%=fabricante.getNombre()%></option>
									<% } %>
								</select>
					 	</div>
					 </div>
						<div class="form-group row">
							<div class="col-lg-94">
								<input type="submit" name="guardar" class="btn btn-primary"
									value="Guardar" /> <input type="submit" name="eliminar"
									class="btn btn-secondary" value="Eliminar" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="pie.jsp"%>