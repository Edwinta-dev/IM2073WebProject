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
              <button>Remove from WishList</button>
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
