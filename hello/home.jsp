<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
  </head>
  <body> 
    <% Integer userId =(Integer) session.getAttribute("userId");
    if(userId==null){ response.sendRedirect("login.jsp"); } String firstName =
    (String) session.getAttribute("firstName"); %>  
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
      <a class="navbar-brand">One More Bookshop</a>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="home.jsp">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="profile?userId=<%= userId%>">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="cart?userId==<%= userId%>">Cart</a>
          </li>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userservlet?action=logout">Logout</a>
        </li>
        </ul>
        <form class="d-flex" role="search">
          <input
            class="form-control me-2"
            type="search"
            placeholder="Search"
            aria-label="Search"
          />
          <button class="btn btn-outline-success" type="submit">
            Search
          </button>
        </form>
      </div>
    </div>
  </nav>

    <h2>Welcome, <%= firstName%>!</h2>
    <a href="querybookmv.html">Search for your favourite books Here!</a><br />
    <a href="wishlist?userId==<%= userId%>"> Wishlist</a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=1" role="button"
      >The Great Gatsby</a
    >
    <a class="btn btn-warning" href="bookservlet?book_id=3"
      >Harry Potter and the philospher's stone
    </a>
    <a class="btn btn-warning" href="bookservlet?book_id=4"> Dracula </a><br />

  </body>
</html>
