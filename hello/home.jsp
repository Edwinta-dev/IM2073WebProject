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
    <% String email = (String) session.getAttribute("email"); if (email ==null){
    response.sendRedirect("login.jsp"); } %>
    <h2>Welcome, <%= email%>!</h2>
    <a href="querybookmv.html">Search for your favourite books Here!</a><br />
    <a href="wishlist.jsp"> Wishlist</a><br />
    <a href="cart.jsp">Cart</a><br />
    <a href="bookservlet?book_id=1">The Great Gatsby </a><br />

    <a href="userservlet?action=logout">Logout </a>
  </body>
</html>
