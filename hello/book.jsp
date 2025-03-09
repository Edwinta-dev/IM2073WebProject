<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ page
language="java" %>
<!DOCTYPE html>
<Header>
  <title><%= request.getAttribute("title") %></title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous"
  />
</Header>
<Body>
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
  <div>
    <h1><Strong><%= request.getAttribute("title") %></Strong></h1>
    <br />
    <h6><Strong>Author: </Strong><%=request.getAttribute("author_id")%></h6>
    <br />
    <img src="<%= request.getAttribute("cover_image_url") %>" alt="Book Cover"
    class="book-cover" />
    <p>
      <Strong> Description: </Strong>
      <%= request.getAttribute("summary") %>
    </p>
    <br />
    <p>
      <Strong> Price: </Strong>
      <%= request.getAttribute("price") %>
    </p>
    <br />
    <p>
      <Strong> Genre </Strong>
      <%= request.getAttribute("genre") %>
    </p>
    <br />
    <p>
      <Strong> Stock: </Strong>
      <%= request.getAttribute("stock_quantity") %>
    </p>
    <br />
    <p>
      <strong>Publication Date:</strong>
      <%= request.getAttribute("publication_date") %>
    </p>
    <br />

    <form action="cart" , method="post">
      <input type="hidden" name="action" value="add" />
      <input type="hidden" name="book_id" value="<%=
      request.getAttribute("book_id") %>" />
      <button type="submit " type="button" class="btn btn-warning">
        Add to Cart
      </button>
    </form>
    <br />
    <form action="wishlist" , method="post">
      <input type="hidden" name="action" value="add" />
      <input type="hidden" name="book_id" value="<%=
      request.getAttribute("book_id") %>" />
      <button type="submit" type="button" class="btn btn-warning">
        Add to Wishlist
      </button>
    </form>
  </div>
</Body>
