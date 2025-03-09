<!DOCTYPE html>
<Header>
  <title>User Profile</title>
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
  <h2>User Profile</h2>
  <h6>View and edit you information</h6>
  <div>
    <h6>
      <strong>First Name: </strong><%=request.getAttribute("first_name")%>
    </h6>
  </div>
  <br />
  <div>
    <h6><strong>Last Name: </strong><%=request.getAttribute("last_name")%></h6>
  </div>
  <br />
  <div>
    <h6><Strong>Birthdate: </Strong><%=request.getAttribute("birth_date")%></h6>
  </div>
  <br />
  <div>
    <h6><strong>Email: </strong><%=request.getAttribute("email")%></h6>
    <br />
    <p style="display: inline">Wrong email? Change it</p>
    <a href="detailChange.jsp">here!</a>
  </div>
  <br />
  <div>
    <h6 style="display: inline"><strong>Change your password </strong></h6>
    <a href="passwordChange.jsp">here!</a>
  </div>
  <br />
  <div>
    <h6><Strong>Phone: </Strong><%=request.getAttribute("phone")%></h6>
    <br />
    <h6 style="display: inline">Change your Phone number</h6>
    <a href="detailChange.jsp">here!</a>
  </div>
  <br />
  <div>
    <h6><Strong>Address: </Strong><%=request.getAttribute("address")%></h6>
    <br />
    <h6 style="display: inline">Change your Address</h6>
    <a href="detailChange.jsp">here!</a>
  </div>
  <br />
</body>
