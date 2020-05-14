<%@ page
	import="java.util.List, 
	java.util.HashMap,
	Utils.RequestUtils,
	java.util.Date,
	java.text.SimpleDateFormat,
	ventaDeCoches.Coche,
	ventaDeCoches.Venta,
	ventaDeCoches.Concesionario,
	ventaDeCoches.Cliente,
	ventaDeCoches.controladores.ClienteControlador,
	ventaDeCoches.controladores.ConcesionarioControlador,
	ventaDeCoches.controladores.VentaControlador,
	ventaDeCoches.controladores.CocheControlador"%>
	
<jsp:include page="cabecera.jsp" flush="true">
	<jsp:param name="tituloDePagina" value="Ficha de venta" />
</jsp:include>

<ul class="breadcrumb">
  <li class="breadcrumb-item"><a href="../index.html">MENU BASE DE DATOS</a></li>
  <li class="breadcrumb-item"><a href="menus/menuventas.html">VENTAS</a></li>
  <li class="breadcrumb-item active">Ficha Venta
</ul>

<% 
SimpleDateFormat sdfFecha = new SimpleDateFormat("dd/MM/yyyy");
	// Obtengo un HashMap con todos los par�metros del request, sea del tipo que sea;
HashMap<String, Object> hashMap = RequestUtils.requestToHashMap(request);
	// Para plasmar la informaci�n de una venta determinada utilizaremos un par�metro que debe llegar al Servlet obligatoriamente
	// El par�metro se llama "idVenta" y gracias a �l podremos obtener la info de la venta y mostrar sus datos por pantalla
	
Venta venta = null;
	// Obtengo la venta a editar, en el caso de que la venta ya exista se cargar�n los datos, y si no, quedar� a null
try {
	int idVenta = RequestUtils.getIntParameterFromHashMap(hashMap, "idVenta"); // Necesito obtener el id de la venta que se quiere editar
	// Si la venta es nueva, el valor del id ser� 0
	if (idVenta != 0){
		venta = (Venta) VentaControlador.getControlador().find(idVenta);
	}
} catch (Exception e){
	e.printStackTrace();
}
// Inicio la carga de los valores de un coche
if (venta == null){
	venta = new Venta();
}
if(venta.getConcesionario() == null) venta.setConcesionario((Concesionario) ConcesionarioControlador.getControlador().find(1));
if(venta.getCliente() == null) venta.setCliente((Cliente) ClienteControlador.getControlador().find(1));
if(venta.getCoche() == null) venta.setCoche((Coche) CocheControlador.getControlador().find(1));
if(venta.getPrecioVenta() == 0f) venta.setPrecioVenta(0f);
if(venta.getFecha() == null) venta.setFecha(null);
// En funci�n de los par�metros de entrada del Servlet, debemos determinar qu� se har� seg�n 3 acciones:
// - "eliminar" sabemos que es esta opci�n porque recibe un par�metro con el nombre "elimiar" en el request
// - "guardar" sabemos que es esta opci�n porque recibe un par�metro con el nombre "guardar" en el request
// - Sin acci�n. En este caso, s�lo se quiere editar
// Variable con mensaje de informaci�n al usuario sobre alguna acci�n requerido
String mensajeAlUsuario = "";
// Primera acci�n posible: eliminar
if (RequestUtils.getStringParameterFromHashMap(hashMap, "eliminar") != null){
	// Intento elimiar un registro, si he ejecuta volvemos a la pantalla del listado
	try{
		VentaControlador.getControlador().remove(venta);
		response.sendRedirect(request.getContextPath() + "jsp/listadoVentas.jsp?idPag=1"); // Redirecci�n al listado
	} catch (Exception ex){
		mensajeAlUsuario = "ERROR - Imposible eliminar. Es posible que exitan restricciones.";
	}
	mensajeAlUsuario="Eliminado Correctamente";
}
// Segunda acci�n posible: guardar
if (RequestUtils.getStringParameterFromHashMap(hashMap, "guardar") != null){
	// Obtengo todos los datos del concesionario y los guardo en la BBDD
	try{
		venta.setConcesionario((Concesionario) ConcesionarioControlador.getControlador().find(RequestUtils.getIntParameterFromHashMap(hashMap, "idConcesionario")));
		venta.setCliente((Cliente) ClienteControlador.getControlador().find(RequestUtils.getIntParameterFromHashMap(hashMap, "idCliente")));
		venta.setCoche((Coche) CocheControlador.getControlador().find(RequestUtils.getIntParameterFromHashMap(hashMap, "idCoche")));
		venta.setPrecioVenta(Float.parseFloat(RequestUtils.getStringParameterFromHashMap(hashMap, "precioVenta")));
		try {
			venta.setFecha(sdfFecha.parse(RequestUtils.getStringParameterFromHashMap(hashMap, "fechaNac")));
		}
		catch (Exception e) {
			e.printStackTrace();
 		}
		//Finalmente guardo el objeto de tipo venta
		VentaControlador.getControlador().save(venta);
		mensajeAlUsuario = "Guardado correctamente";
	} catch (Exception e){
		throw new ServletException(e);
	}
}
// Ahora mustro la pantalla de respuesta al usuario
%>

<div class="container py-3">
	<%
		String tipoAlerta = "alert-success";
	if (mensajeAlUsuario != null && mensajeAlUsuario != ""){
		if(mensajeAlUsuario.startsWith("ERROR")){
			tipoAlerta = "alert-danger";
		}
	
	%>
	<div class="alert <%=tipoAlerta %> alert-dismissible fade show">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<%=mensajeAlUsuario %>
	</div>
	<%
	}
	%>
	<div class="row">
		<div class="mx-auto col-sm-6">
			<!-- form user info -->
			<div class="card">
				<div class="card-header">
					<h4 class="mb-0">Ficha de venta</h4>
				</div>
				<div class="card-body">
					<a href="listadoVentas.jsp?idPag=1" class="btn btn-warning btn-sm" role="button">Ir al listado de Ventas</a>
					<form id="form1" name="form1" method="post" 
					action="fichaVenta.jsp" enctype="multipart/form-data"
					class="form" role="form" autocomplete="off">
					<p />
					 <input type="hidden" name="idVenta" value="<%=venta.getId()%>"/>
					 <div class="form-group row">
					 	<label class="col-lg-4 col-form-label form-control-label" for="idConcesionario">Concesionario:</label>
					 	<div class="col-lg-8">
					 		<select name="idConcesionario" id="idConcesionario"
									class="form-control">
									<%
										// Inserto los valores del concesionario y, si el registro tiene un valor concreto, lo establezco
									List<Concesionario> concesionarios = ConcesionarioControlador.getControlador().findAll();
									for (Concesionario concesionario : concesionarios) {
									%>
									<option value="<%=concesionario.getId()%>"
										<%=((concesionario.getId() == venta.getConcesionario().getId()) ? "selected=\"selected\"" : "")%>><%=concesionario.getNombre()%></option>
									<% } %>
								</select>
					 	</div>
					 </div>
					 <div class="form-group row">
					 	<label class="col-lg-3 col-form-label form-control-label" for="idCliente">Cliente:</label>
					 	<div class="col-lg-9">
					 		<select name="idCliente" id="idCliente"
									class="form-control">
									<%
										// Inserto los valores del cliente y, si el registro tiene un valor concreto, lo establezco
									List<Cliente> clientes = ClienteControlador.getControlador().findAll();
									for (Cliente cliente : clientes) {
									%>
									<option value="<%=cliente.getId()%>"
										<%=((cliente.getId() == venta.getConcesionario().getId()) ? "selected=\"selected\"" : "")%>><%=cliente.getApellidos()%></option>
									<% } %>
								</select>
					 	</div>
					 </div>
					  <div class="form-group row">
					 	<label class="col-lg-3 col-form-label form-control-label" for="idCoche">Coche:</label>
					 	<div class="col-lg-9">
					 		<select name="idCoche" id="idCoche"
									class="form-control">
									<%
										// Inserto los valores del coche y, si el registro tiene un valor concreto, lo establezco
									List<Coche> coches = CocheControlador.getControlador().findAll();
									for (Coche coche : coches) {
									%>
									<option value="<%=coche.getId()%>"
										<%=((coche.getId() == venta.getCoche().getId()) ? "selected=\"selected\"" : "")%>><%=coche.getBastidor()%></option>
									<% } %>
								</select>
					 	</div>
					 </div>
					  <div class="form-group row">
					 	<label class="col-lg-4 col-form-label form-control-label" for="fecha">Fecha de Venta:</label>
					 	<div class="col-lg-8">
					 		<input name="fecha" class="form-control" type="text" 
					 		id="fecha" value="<%= ((venta.getFecha() != null) ? sdfFecha.format(venta.getFecha()) : "") %>" />
					 	</div>
					 </div>
					 <div>
					  <div class="form-group row">
					   <label class="col-lg-4 col-form-label form-control-label" for="precioVenta">Precio de venta</label>
					   <div class="col-lg-8">
					   		<input name="precioVenta" class="form-control" type="text" id="precioVenta" value="<%=venta.getPrecioVenta() %>" />
					   </div>
					  </div>
					 </div>
					 <div class="form-group row">
							<div class="col-lg-9">
								<input type="submit" name="guardar" class="btn btn-primary" value="Guardar" /> 
								<input type="submit" name="eliminar" class="btn btn-secondary" value="Eliminar" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="pie.jsp"%>