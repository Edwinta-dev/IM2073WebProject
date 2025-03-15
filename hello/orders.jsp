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
<h2>Orders</h2>
<h6>View all your orders here!</h6>
<%String status = (String) request.getAttribute("status");%>
<div class="d-flex gap-2">
    <form action ="orders" method="get">
        <input type="hidden" name="action" value="pending" />
        <%if ("pending".equals(status)||status==null){%>
            <button class="btn btn-secondary" type="submit">
                Pending Orders
              </button>
        <%}else{%>
            <button class="btn btn-outline-secondary" type="submit">
                Pending Orders
              </button>
        <%}%>
    </form>
    <form action ="orders" method="get">
        <input type="hidden" name="action" value="completed" />
        <%if ("completed".equals(status)){%>
        <button class="btn btn-secondary" type="submit">
          Completed Orders
        </button>
        <%}else{%>
        <button class="btn btn-outline-secondary" type="submit">
            Completed Orders
        </button>       
        <%}%>
    </form>
    <form action ="orders" method="get">
        <input type="hidden" name="action" value="cancelled" />
        <%if ("cancelled".equals(status)){%>
        <button class="btn btn-secondary" type="submit">
          Cancelled Orders
        </button>
        <%}else{%>
        <button class="btn btn-outline-secondary" type="submit">
                Cancelled Orders
        </button>    
        <%}%>
    </form>
</div>
    <% 
        ArrayList<List<Object>> orderList = new  ArrayList<List<Object>>();
        ArrayList<List<Object>> orderItemList = new  ArrayList<List<Object>>();
        orderItemList = (ArrayList<List<Object>>) request.getAttribute("orderItemList");
        orderList = (ArrayList<List<Object>>) request.getAttribute("ordersList");
        if (orderList != null && orderItemList != null && !orderList.isEmpty() && !orderItemList.isEmpty()){
        %>
            <%for (List<Object> orders : orderList) {%>
                <div>
                <h6>Order ID: <%=orders.get(0)%></h6>
                <h6>Price: $<%=orders.get(1)%></h6>
                <h6>Date: <%=orders.get(2)%></h6>
                    <table class="table">
                        <tr>
                            <th>Title</th>
                            <th>Quantity</th>
                            <th>Price</th>
                        </tr>
                        <%for (List<Object> orderItem : orderItemList){
                            if (orders.get(0)==orderItem.get(0)){%>
                                <tr>
                                    <td><%=orderItem.get(1)%></td>
                                    <td>$ <%=orderItem.get(2)%></td>
                                    <td><%=orderItem.get(3)%></td>
                                </tr>
                            <%}
                        }%>
                    </table>
                    <%if (status.equals("pending")){%>
                        <form action ="orders" method="post">
                            <input type="hidden" name="action" value="received" />
                            <input type="hidden" name="order_id" value="<%=orders.get(0)%>"/>
                            <button class="btn btn-outline-success" type="submit">
                                Order Received
                            </button>
                        </form>
                        <form action ="orders" method="post">
                            <input type="hidden" name="action" value="cancel" />
                            <input type="hidden" name="order_id" value="<%=orders.get(0)%>"/>
                            <button class="btn btn-outline-danger" type="submit">
                                Cancel Order                                  
                            </button>
                        </form>
                        <%}else{%>
                        <form action ="orders" method="post">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="order_id" value="<%=orders.get(0)%>"/>
                            <input type="hidden" name="status" value="<%=status%>"/>
                            <button class="btn btn-outline-danger" type="submit">
                                Delete Order Entry                                
                            </button>
                        </form>
                        <%}
            }
        }else{
            if (status==null||status.equals("pending")||status.equals("completed")){%>
              <br>
                <div class="d-grid gap-2">
                  <a href="index.jsp" class="btn btn-outline-secondary" type="button">Your order list is lonely, would you like to buy some books to change that?</a>
                </div>
            <%}else {%>
                <h6>Shoo! Nothing to see here!</h6>
            <%}
        }%>
  </body>
</html>