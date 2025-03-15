<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
  </head>
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
    <h2>Login</h2>
    <!-- Original form format before bootstrap
    <form action="userservlet" method="post">
      <input type="hidden" name="action" value="login" />
      Email: <input type="text" name="email" required /><br />
      Password: <input type="password" name="password" required /><br />
      <button type="Submit">Login</button>
    </form> 
    -->

    <form action="userservlet" method="post">
      <input type="hidden" name="action" value="login" />
      <div class="mb-3">
        <label for="exampleInputEmail1" class="form-label">Email address</label>
        <input
          type="email"
          name="email"
          class="form-control"
          id="exampleInputEmail1"
          aria-describedby="emailHelp"
        />
        <div id="emailHelp" class="form-text">
          We'll never share your email with anyone else.
        </div>
      </div>
      <div class="mb-3">
        <label for="exampleInputPassword1" class="form-label">Password</label>
        <input
          name="password"
          type="password"
          class="form-control"
          id="exampleInputPassword1"
        />
      </div>
      <button type="submit" class="btn btn-primary">Login!</button>
    </form>
    <p>
      <a
        href="signup.jsp"
        class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover"
        class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
        >Don't have an account yet? Sign Up Now</a
      >
    </p>
  </body>
</html>
