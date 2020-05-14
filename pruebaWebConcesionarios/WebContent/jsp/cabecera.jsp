<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
  
  <% String tituloDePagina = request.getParameter("tituloDePagina"); %>
  <title><%= (tituloDePagina != null)? tituloDePagina : "Sin título" %></title>

</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top sticky-top">

	 <!-- Brand/logo -->
  <a class="navbar-brand" href="../index.html">
    <img src="ferrari.png" alt="logo" style="width:70px;">
  </a>
  

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
  <ul class="navbar-nav">
    <!-- Dropdown o desplegable -->
    <li class="nav-item dropdown" >
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Concesionarios
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="listadoConcesionarios.jsp?idPag=1">Lista de Concesionarios</a>
        <a class="dropdown-item" href="fichaConcesionario.jsp">Ficha de Concesionarios</a>
      </div>
    </li>
   <li class="nav-item dropdown" >
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Fabricantes
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="listadoFabricantes.jsp?idPag=1">Lista de Fabricantes</a>
        <a class="dropdown-item" href="fichaFabricante.jsp">Ficha de Fabricantes</a>
      </div>
    </li>
    <li class="nav-item dropdown" >
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Coches
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="listadoCoches.jsp?idPag=1">Lista de Coches</a>
        <a class="dropdown-item" href="fichaCoche.jsp">Ficha de Coches</a>
      </div>
    <li class="nav-item dropdown" >
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Clientes
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="listadoClientes.jsp?idPag=1">Lista de Clientes</a>
        <a class="dropdown-item" href="fichaCliente.jsp">Ficha de Clientes</a>
      </div>
    </li>
     <li class="nav-item dropdown" >
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Ventas
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="listadoVentas.jsp?idPag=1">Lista de Ventas</a>
        <a class="dropdown-item" href="fichaVenta.jsp">Ficha de Ventas</a>
      </div>
  </ul></div>
</nav>