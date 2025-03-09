<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<Header>
  <title>Wishlist</title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous"
  />
</Header>
<body>
  <% Integer userId =(Integer) session.getAttribute("userId");%>
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
          </li>
        </ul>
        <form class="d-flex" role="search">
          <input
            class="form-control me-2"
            type="search"
            placeholder="Search"
            aria-label="Search"
          />
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
      </div>
    </div>
  </nav>

  <h2>WISHLIST</h2>
  <h6>Seize the opportunity! Add these to your collection!</h6>
  <% 
  ArrayList<List<Object>> wishlistItems = new  ArrayList<List<Object>>();
  wishlistItems = (ArrayList<List<Object>>) request.getAttribute("wishlistItems");
  if (wishlistItems != null) {
      for (List<Object> item : wishlistItems) {%>
          <div class="wishlist-item">
              <div><strong><%= item.get(0) %></strong></div>
              <div>Price: $<%= item.get(1) %></div>
              <img src="<%= item.get(2) %>" alt="Book Cover"/>
              <form action="wishlist" , method="post">
                <input type="hidden" name="action" value="remove" />
                <input type="hidden" name="book_id" value="<%=item.get(3) %>" />
                <button type="submit" type="button" class="btn btn-warning">
                  Remove from wishlist
                </button>
              <button>Add to Cart!</button>
          </div><%  
      }
    } else {
%>
<p>Your Wishlist is empty.</p>
<%
  }
%>
</body>
