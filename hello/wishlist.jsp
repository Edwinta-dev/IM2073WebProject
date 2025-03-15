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
            <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="profile?userId=<%= userId%>">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="cart?userId=<%= userId%>">Cart</a>
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

  <h2>WISHLIST</h2>
  <h6>Seize the opportunity! Add these to your collection!</h6>
  <% 
  ArrayList<List<Object>> wishlistItems = new  ArrayList<List<Object>>();
  wishlistItems = (ArrayList<List<Object>>) request.getAttribute("wishlistItems");
  if (wishlistItems != null) {
      for (List<Object> item : wishlistItems) {%>
        <div class="container mt-3" class="search-items">
          <div class="row">
            <!-- Book Item -->
            <div class="col-md-12 border-bottom pb-3 mb-3 d-flex">
              <!-- Image (Left) -->
              <div class="flex-shrink-0">
                <img
                  src="<%= item.get(2) %>"
                  alt="Book Cover Image"
                  class="img-fluid rounded"
                  style="width: 120px; height: 160px"
                />
              </div>

              <!-- Details (Right) -->
              <div class="ms-3 flex-grow-1">
                <h5 class="fw-bold"><%= item.get(0) %></h5>
                <p class="text-danger fw-bold fs-5">$<%= item.get(1) %></p>
                <a
                  href="bookservlet?book_id=<%=item.get(3)%>"
                  class="btn btn-warning btn-sm"
                  >View Details</a
                >
              </div>
              <!-- Buttons (Right - Always Aligned) -->
              <div class="d-flex flex-column align-items-end" style="margin-right: 10px;">
                <form action="wishlist" method="post">
                    <input type="hidden" name="action" value="remove" />
                    <input type="hidden" name="book_id" value="<%= item.get(3) %>" />
                    <button type="submit" class="btn btn-warning w-100 mb-2">
                        Remove from Wishlist
                    </button>
                </form>
            
                <form action="cart" method="post">
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="book_id" value="<%= item.get(3) %>" />
                    <button type="submit" class="btn btn-warning w-100">
                        Add to Cart
                    </button>
                </form>
            </div>
            
            </div>
                    </div>
                </div>
                        


        <%  
      }
    } else {
%>
<p>Your Wishlist is empty.</p>
<%
  }
%>


<%
    String message = (String) session.getAttribute("wishlistMessage");
    if (message != null) { 
        session.removeAttribute("wishlistMessage"); // Prevent showing the message again on refresh
%>
<div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Notification</strong>
      <small>Just now</small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      <%=message%>
    </div>
  </div>
</div>
<% } %>

<!-- Bootstrap JS (must be at the bottom) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

