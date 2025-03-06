<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<Header>
  <title>Cart</title>
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
  <h2>CART</h2>
  <h6>These books are flying off the shelves !! Make them yours today!</h6>

  <% 
  ArrayList<List<Object>> cartItems = new  ArrayList<List<Object>>();
  cartItems = (ArrayList<List<Object>>) request.getAttribute("cartItems");
  if (cartItems != null) {
      for (List<Object> item : cartItems) {
%>
          <div class="cart-item">
              <div><strong><%= item.get(0) %></strong></div>
              <div>Price: $<%= item.get(1) %></div>
              <div>Qty: <%= item.get(2) %></div>
              <div>Total: $<%= (Double) item.get(1) * (Integer) item.get(2) %></div>
              <img src="<%= item.get(3) %>" alt="Book Cover"/>
              <button>Remove from cart</button>
          </div>
<%  
      }%>

      <p>
        <a
          href="checkout.jsp"
          class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover"
          class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
          >CHECK OUT NOW!!!!!!!</a
        >
      </p>
<%  } else {
%>
      <p>Your cart is empty.</p>
<%
  }
%>
</body>
