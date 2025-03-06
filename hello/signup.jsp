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
