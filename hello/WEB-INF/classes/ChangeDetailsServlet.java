import java.io.*;
import java.sql.*;
import jakarta.servlet.*; // Tomcat 10
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/changedetails") // Configure the request URL for this servlet (Tomcat 7/Servlet 3.0 upwards)
public class ChangeDetailsServlet extends HttpServlet {

    @Override
    // Updating details to database and directing back to profile
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String password = (String) request.getParameter("password");
        String action = (String) request.getParameter("action");
        String newdetail = (String) request.getParameter("Newaction");
        System.out.println(userId);
        System.out.println(action);
        System.out.println(newdetail);
        if (userId != null && action != null) {
            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                String passwordAuth = "SELECT * FROM USERS WHERE PASSWORD_HASH =? AND USER_ID =?";
                PreparedStatement passwordAuthstmt = conn.prepareStatement(passwordAuth);
                passwordAuthstmt.setString(1, password);
                passwordAuthstmt.setInt(2, userId);
                ResultSet rs = passwordAuthstmt.executeQuery();
                if (rs.next()) {
                    String detailString = "UPDATE USERS SET ";
                    detailString += action;
                    detailString += " = ";
                    detailString += "? WHERE USER_ID=?";
                    System.out.println(detailString);
                    PreparedStatement detailStringstmt = conn.prepareStatement(detailString);
                    detailStringstmt.setString(1, newdetail);
                    detailStringstmt.setInt(2, userId);
                    detailStringstmt.executeUpdate();
                    System.out.println("Information updated");
                    System.out.println(detailStringstmt);
                    String redirectpage = "profile?userId=" + userId;
                    response.sendRedirect(redirectpage);
                } else {
                    String message = "Password wrong! Please try again";
                    request.setAttribute("message", message);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("changedetail.jsp?action=" + action);
                    dispatcher.forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}