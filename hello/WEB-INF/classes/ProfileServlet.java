import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.*; // Tomcat 10
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve email from request
        String userId = request.getParameter("userId");
        if (userId != null) {
            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                // Query for user
                String sql = "SELECT * FROM USERS WHERE USER_ID = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                int userID = Integer.parseInt(userId);
                stmt.setInt(1, userID);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("first_name", rs.getString("first_name"));
                    request.setAttribute("last_name", rs.getString("last_name"));
                    request.setAttribute("email", rs.getString("email"));
                    request.setAttribute("address", rs.getString("address"));
                    request.setAttribute("phone", rs.getString("phone"));
                    request.setAttribute("birth_date", rs.getString("birth_date"));
                } else {
                    response.sendRedirect("userNotFound.jsp");
                }
                // Forwarding request to Profile.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("userNotFound.jsp");
            }
        }
    }
}