<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,
	ventaDeCoches.Fabricante,
	ventaDeCoches.controladores.FabricanteControlador"%>

<jsp:include page="cabecera.jsp" flush="true">
	<jsp:param name="tituloDePagina" value="Listado de fabricantes" />
</jsp:include>

<ul class="breadcrumb">
  <li class="breadcrumb-item"><a href="../index.html">MENU BASE DE DATOS</a></li>
  <li class="breadcrumb-item"><a href="menus/menufabricantes.html">FABRICANTES</a></li>
  <li class="breadcrumb-item active">Listado Fabricantes
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
	<h1>Listado de fabricantes</h1>
	<table class="table table-hover">
		<thead class="thead-dark">
			<tr>
				<th>Cif</th>
				<th>Nombre</th>
			</tr>
		</thead>
		<tbody>
			<%
			// Hasta la fila anterior ha llegado la primera fila de títulos de la tabla de fabricantes
			// En las siguietnes líneas se crea una fila "elemento <tr>" por cada fila de la tabla de BBDD "fabricante"
			List<Fabricante> fabricantes = FabricanteControlador.getControlador().findAllLimited(5, offset);
			for (Fabricante fabricante : fabricantes) {
			%>
			<tr>
				<td><a
					href="fichaFabricante.jsp?idFabricante=<%=fabricante.getId()%>"> <%=fabricante.getCif()%>
				</a></td>
				<td><%=fabricante.getNombre()%></td>
			</tr>
			<%
				}
			// Al finalizar de exponer la lista de fabricantes termino la tabla y cierro el fichero HTML
			%>
		</tbody>
	</table>
	<p />
	<input type="submit" class="btn btn-primary" name="nuevo" value="Nuevo"
		onclick="window.location='fichaFabricante.jsp?idFabricante=0'" />
	
	  <ul class="pagination justify-content">
	  <li class="page-item"><a class="page-link" href="?idPag=<%= Math.round(1) %>">Primero</a></li>
	  <li class="page-item"><a class="page-link" href="?idPag=<%= paginationIndex-1 %>">Anterior</a></li>
	  <%
	  List<Fabricante> c = FabricanteControlador.getControlador().findAll();
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
	  <li class="page-item"><a class="page-link" href="?idPag=<%= Math.round(size) %>">Último</a></li>
	  
</div>
	
<%@ include file="pie.jsp"%>