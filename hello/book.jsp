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

    <form action="cartservlet" , method="post">
      <input type="hidden" name="action" value="cart" />
      <input type="hidden" name="book_id" value="<%=
      request.getParameter("book_id") %>" />
      <button type="submit " type="button" class="btn btn-warning">
        Add to Cart
      </button>
    </form>
    <br />
    <form action="'cartservlet" , method="post">
      <input type="hidden" name="action" value="wishlist" />
      <input type="hidden" name="book_id" value="<%=
      request.getParameter("book_id") %>" />
      <button type="submit" type="button" class="btn btn-warning">
        Add to Wishlist
      </button>
    </form>
  </div>
</Body>
