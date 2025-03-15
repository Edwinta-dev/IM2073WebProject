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
    <!--Setting Up Nav bar on top of the screen-->
    <% Integer userId =(Integer) session.getAttribute("userId");
    if(userId==null){%> 
      <!--When user is not logged in-->
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
                <a class="nav-link active" aria-current="page" href="index.jsp"
                  >Home</a
                >
              </li>
              <li class="nav-item">
                <a class="nav-link" href="login.jsp">Log in</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="signup.jsp">Sign up</a>
              </li>
            </ul>
            <form class="d-flex" role="search" action="bookSearch?">
              <input
                name="search"
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
      <h2>Welcome!</h2>
    <%} else{String firstName =(String) session.getAttribute("firstName"); %>  
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
            <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="profile?userId=<%= userId%>">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="cart?userId=<%= userId%>">Cart</a>
          </li>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="wishlist?userId=<%= userId%>">Wishlist</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="orders?action=pending">Orders</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userservlet?action=logout">Logout</a>
        </li>
        </ul>
        <form class="d-flex" role="search" action ="bookSearch?">
          <input
            name="search"
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
  <%}%>
    <a class="btn btn-warning" href="bookservlet?book_id=1">The Great Gatsby</a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=3">Harry Potter and the philospher's stone</a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=4"> Dracula </a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=5"> The Pschology of Money </a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=6"> The Hunger Games </a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=7"> Catching Fire </a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=8"> MockingJay </a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=9"> The Ballad of SongBirds and Snakes </a><br />
    <a class="btn btn-warning" href="bookservlet?book_id=10"> Sunrise on the Reaping </a><br />
    
    </div>
  </body>
</html>
