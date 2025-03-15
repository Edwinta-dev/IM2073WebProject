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
<body>  <% Integer userId =(Integer) session.getAttribute("userId");%>
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

  <h2>CART</h2>
  <h6>These books are flying off the shelves !! Make them yours today!</h6>

  <% 
  ArrayList<List<Object>> cartItems = new  ArrayList<List<Object>>();
  cartItems = (ArrayList<List<Object>>) request.getAttribute("cartItems");
  if (cartItems != null) {
      for (List<Object> item : cartItems) {
%>
          <div class="cart-item">
              <div class="container mt-3" class="Cart-items">
                <div class="row">
                  <!-- Book Item -->
                  <div class="col-md-12 border-bottom pb-3 mb-3 d-flex">
                    <!-- Image (Left) -->
                    <div class="flex-shrink-0">
                      <img
                        src="<%= item.get(3) %>"
                        alt="Book Cover Image"
                        class="img-fluid rounded"
                        style="width: 120px; height: 160px"
                      />
                    </div>
      
                    <!-- Details (Right) -->
                    <div class="ms-3 flex-grow-1">
                      <h5 class="fw-bold"><%= item.get(0) %></h5>
                      <div><h6><strong>Price: </strong></h6> <h6>$<%= item.get(1) %></h6></div>
                      <div><h6><strong>Quantity: </strong></h6> <h6><%= item.get(2) %></h6></div>
                      <h6><strong>Total Price:</strong></h6>
                      <h6 class="text-danger fw-bold fs-5">$<%= (Double) item.get(1) * (Integer) item.get(2) %></h6>
                      <a
                        href="bookservlet?book_id=<%=item.get(4)%>"
                        class="btn btn-warning btn-sm"
                        >View Details</a>
                    </div>
                    <div>
                      </form>
                      <form action="cart" , method="post">
                        <input type="hidden" name="action" value="remove" />
                        <input type="hidden" name="book_id" value="<%=item.get(4) %>" />
                        <button type="submit " type="button" class="btn btn-warning">
                          Remove from cart
                        </button>
                      </form>
                  </div>
                  
                </div>
              </div>
            </div>
          </div>
                            

              
              
<%  
      }%>

      <p>
        <form action="checkout" method="post">
          <input type="hidden" name="action" />
          <button type="submit" class="btn btn-primary">Checkout!</button>
        </form>
        
      </p>
<%  } else {
%>
      <p>Your cart is empty.</p>
<%
  }
%>
</body>
