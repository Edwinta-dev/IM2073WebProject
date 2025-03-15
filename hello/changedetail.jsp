<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%String action = request.getParameter("action");%>
<!DOCTYPE html>
<html>
  <head>
    <title>Change your details here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
  </head>
  <body>
    <h2>Change your <%=action%> here</h2>
    <br />
    <form action="changedetails?action=<%=action%>" method="post">
      <input type="hidden" name="action" />
      <div class="mb-3">
        <label for="exampleInputPassword1" class="form-label">Password</label>
        <input
          name="password"
          type="password"
          class="form-control"
          id="exampleInputPassword1"
        />
        <div class="mb-3">
          <label for="New detail" class="form-label">New <%=action%>:</label>
          <input name="Newaction" class="form-control" id="New detail" />
        </div>
        <% String message = (String) request.getAttribute("message"); if
        (message != null) { %>
        <div>
          <h6 style="color: var(--bs-danger)"><%=message%></h6>
        </div>
        <%}%>
      </div>
      <button type="submit" class="btn btn-primary">Update!</button>
    </form>
  </body>
</html>
