<%@ page
	import="java.util.List,
	ventaDeCoches.controladores.ClienteControlador,
	ventaDeCoches.Cliente"%>

<jsp:include page="cabecera.jsp" flush="true">
	<jsp:param name="tituloDePagina" value="Listado de clientes" />
</jsp:include>

<ul class="breadcrumb">
  <li class="breadcrumb-item"><a href="../index.html">MENU BASE DE DATOS</a></li>
  <li class="breadcrumb-item"><a href="menus/menuclientes.html">CLIENTES</a></li>
  <li class="breadcrumb-item active">Listado Clientes
</ul>

<%!
			public int getOffset(String param){
				int offset = Integer.parseInt(param);
				if(offset > 1){
					return 5 * offset;
				}
				else{
					return 0;
				}
				
			}
		%>
		<%! private int offset, paginationIndex; %>
		<% offset = getOffset(request.getParameter("idPag"));
			paginationIndex = Integer.parseInt(request.getParameter("idPag"));
		%>
		
<div class="container">
	<h1>Listado de Clientes</h1>
	<table class="table table-hover">
		<thead class="thead-dark">
			<tr>
				<th>Dni/Nie</th>
				<th>Nombre</th>
				<th>Apellidos</th>
				<th>Fecha de nacimiento</th>
				<th>Localidad</th>
				<th>Activo</th>
			</tr>
		</thead>
		<tbody>
			<%
			// Hasta la fila anterior ha llegado la primera fila de t�tulos de la tabla de cliente de la gesti�n de ventas
			// En las siguietnes l�neas se crea una fila "elemento <tr>" por cada fila de la tabla de BBDD "cliente"
			List<Cliente> clientes = ClienteControlador.getControlador().findAllLimited(5, offset);
			for (Cliente cliente : clientes) {
			%>
			<tr>
				<td><a
					href="fichaCliente.jsp?idCliente=<%=cliente.getId()%>"> <%=cliente.getDniNie()%>
				</a></td>
				<td><%=cliente.getNombre()%></td>
				<td><%=cliente.getApellidos()%></td>
				<td><%=cliente.getFechaNac()%></td>
				<td><%=cliente.getLocalidad()%></td>
				<td><%=cliente.getActivo()%></td>
			</tr>
			<%
				}
			// Al finalizar de exponer la lista de profesores termino la tabla y cierro el fichero HTML
			%>
		</tbody>
	</table>
	<p />
	<input type="submit" class="btn btn-primary" name="nuevo" value="Nuevo"
		onclick="window.location='fichaCliente.jsp?idCliente=0'" />
		
	  <ul class="pagination justify-content">
	  <li class="page-item"><a class="page-link" href="?idPag=<%= Math.round(1) %>">Primero</a></li>
	  <li class="page-item"><a class="page-link" href="?idPag=<%= paginationIndex-1 %>">Anterior</a></li>
	  <%
	  List<Cliente> c = ClienteControlador.getControlador().findAll();
	  double size = Math.ceil(c.size() / 5);
	  
	  if (paginationIndex > 1){
	  %> 
		  <li class="page-item"><a class="page-link" href="?idPag=<%= paginationIndex-1 %>" ><%= paginationIndex-1 %></a></li>
	  <%
	  }
	  %>
	  <li class="page-item active"><a class="page-link" href="?idPag=<%= paginationIndex %>" ><%= paginationIndex %></a></li>
	  <li class="page-item"><a class="page-link" href="?idPag=<%= paginationIndex+1 %>" ><%= paginationIndex+1 %></a></li>
	  <li class="page-item"><a class="page-link" href="?idPag=<%= paginationIndex+1 %>">Siguiente</a></li>
	  <li class="page-item"><a class="page-link" href="?idPag=<%= Math.round(size) %>">�ltimo</a></li>
	  
</div>
<%@ include file="pie.jsp"%>