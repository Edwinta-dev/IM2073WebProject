<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <HEAD>
    <TITLE>Sign Up</TITLE>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
  </HEAD>
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
            <button class="btn btn-outline-success" type="submit">
              Search
            </button>
          </form>
        </div>
      </div>
    </nav>
    <h2>Sign Up</h2>
    <form action="userservlet" method="post">
      <input type="hidden" name="action" value="register" />
      <div class="mb-3">
        <label for="email" class="form-label">Email address</label>
        <input
          name="email"
          class="form-control"
          id="email"
          aria-describedby="emailHelp"
        />
        <div id="emailHelp" class="form-text">
          We'll never share your email with anyone else.
        </div>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input
          name="password"
          type="password"
          class="form-control"
          id="password"
        />
      </div>
      <div class="mb-3">
        <label for="first name" class="form-label">First Name</label>
        <input name="first_name" class="form-control" id="first name" />
      </div>
      <div class="mb-3">
        <label for="last name" class="form-label">Last Name</label>
        <input name="last_name" class="form-control" id="last name" />
      </div>
      <div class="mb-3">
        <label for="phone" class="form-label">Phone Number</label>
        <input name="phone" class="form-control" id="phone" />
      </div>
      <div class="mb-3">
        <label for="address" class="form-label">Address</label>
        <input type="text" name="address" class="form-control" id="address" />
      </div>
      <div class="mb-3">
        <label for="birthdate" class="form-label">Birth date</label>
        <input name="birthdate" class="form-control" id="address" />
      </div>
      <button type="submit" class="btn btn-primary">Register!</button>
    </form>
    <p>
      <a
        href="login.jsp"
        class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover"
        class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
        >Already have an account? Log in Here!</a
      >
    </p>
  </body>
</html>
