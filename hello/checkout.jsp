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
<h2>Checkout</h2>
<h6>Your order is being processed.</h6>
<h6>View your order here!</h6>
<table class = table>
<tr>
  <th>Title</th>
  <th>Price</th>
  <th>Quantity</th>
</tr>
<% 
  ArrayList<List<Object>> Order = new  ArrayList<List<Object>>();
  Order = (ArrayList<List<Object>>) request.getAttribute("Order");
  if (Order != null) {
    %>
    <%for (List<Object> bookOrder : Order) {%>
    <tr>
      <td><%=bookOrder.get(3)%></td>
      <td><%=bookOrder.get(2)%></td>
      <td><%=bookOrder.get(1)%></td>
    </tr>
<%
        }
      }

%>
</table>
    <h6>Total price is <%=request.getAttribute("totalPrice")%></h6>
  </body>
</html>