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
