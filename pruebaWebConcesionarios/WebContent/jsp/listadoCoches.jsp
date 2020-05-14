<%@ page
	import="java.util.List,
	ventaDeCoches.Coche,
	ventaDeCoches.controladores.CocheControlador"%>
	
	

<jsp:include page="cabecera.jsp" flush="true">
	<jsp:param name="tituloDePagina" value="Listado de coches" />
</jsp:include>


<ul class="breadcrumb">
  <li class="breadcrumb-item"><a href="../index.html">MENU BASE DE DATOS</a></li>
  <li class="breadcrumb-item"><a href="menus/menucoches.html">COCHES</a></li>
  <li class="breadcrumb-item active">Listado Coches
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
	<h1>Listado de coches</h1>
	<table id="tablaPaginacion" class="table table-hover">
		<thead class="thead-dark">
			<tr>
				<th>Bastidor</th>
				<th>Fabricante</th>
				<th>Color</th>
				<th>Modelo</th>
			</tr>
		</thead>
		<tbody>
			<%
				// Hasta la fila anterior ha llegado la primera fila de títulos de la tabla de coches
			// En las siguietnes líneas se crea una fila "elemento <tr>" por cada fila de la tabla de BBDD "coche"
			List<Coche> coches = CocheControlador.getControlador().findAllLimited(5,offset);
			for (Coche coche : coches) {
			%>
			<tr>
				<td><a
					href="fichaCoche.jsp?idCoche=<%=coche.getId()%>"> <%=coche.getBastidor()%>
				</a></td>
				<td><%=coche.getFabricante()%></td>
				<td><%=coche.getColor()%></td>
				<td><%=coche.getModelo()%></td>
			</tr>
			<%
				}
			// Al finalizar de exponer la lista de coches termino la tabla y cierro el fichero HTML
			%>
		</tbody>
	</table>
	<p />
		<input type="submit" class="btn btn-primary" name="nuevo" value="Nuevo"
		onclick="window.location='fichaCoche.jsp?idCoche=0'" />
		
	  <ul class="pagination justify-content">
	  <li class="page-item"><a class="page-link" href="?idPag=<%= Math.round(1) %>">Primero</a></li>
	  <li class="page-item"><a class="page-link" href="?idPag=<%= paginationIndex-1 %>">Anterior</a></li>
	  <%
	  List<Coche> c = CocheControlador.getControlador().findAll();
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