<%@ page import="java.sql.ResultSet" %> <%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<Header>
  <title>Search Results</title>
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
            <a class="nav-link active" aria-current="page" href="index.jsp"
              >Home</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link" href="login.jsp">Log in</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="signup.jsp">Sign up</a>
          </li>
        </ul>
        <form class="d-flex" role="search" action="bookSearch?">
          <input
            name="search"
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

  <h2>Search Results</h2>
  <% 
    ArrayList<List<Object>> searchItems = new ArrayList<List<Object>>(); 
    String search = new String(""); 
    searchItems = (ArrayList<List<Object>>)
    request.getAttribute("searchItems");
    search += (String) request.getAttribute("search"); 
    if (!searchItems.isEmpty()) { 
        for(List<Object> item : searchItems) {
  %>
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
                <div class="ms-3">
                  <h5 class="fw-bold"><%= item.get(0) %></h5>
                  <p class="text-danger fw-bold fs-5">$<%= item.get(1) %></p>
                  <a
                    href="bookservlet?book_id=<%=item.get(3)%>"
                    class="btn btn-warning btn-sm"
                    >View Details</a
                  >
                </div>
              </div>
            </div>
          </div>
          <%} }else {%>
          <h6>Your Search "<%=search%>" Yielded No Results.</h6>
          <br />
          <p>
            Check if you spelt your book correctly! Otherwise we may not have
            what you are looking for :(
          </p>
          <% } %>


</body>
