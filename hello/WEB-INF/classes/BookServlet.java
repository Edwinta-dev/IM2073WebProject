import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.*; // Tomcat 10
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/bookservlet")
public class BookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve book ID from request
        String bookID = request.getParameter("book_id");
        if (bookID != null) {
            // Establish connection
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                // Querying for book
                String sql = "SELECT * FROM BOOKS WHERE BOOK_ID=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(bookID));

                ResultSet rs = stmt.executeQuery();
                // Set attributes for JSP to use
                if (rs.next()) {
                    request.setAttribute("book_id", rs.getInt("book_id"));
                    request.setAttribute("title", rs.getString("title"));
                    request.setAttribute("author_id", rs.getInt("author_id"));
                    request.setAttribute("genre", rs.getString("genre"));
                    request.setAttribute("price", rs.getBigDecimal("price"));
                    request.setAttribute("publication_date", rs.getDate("publication_date"));
                    request.setAttribute("stock_quantity", rs.getInt("stock_quantity"));
                    request.setAttribute("summary", rs.getString("summary"));
                    request.setAttribute("cover_image_url", rs.getString("cover_image_url"));

                }
                // Forward the request and response to the JSP
                RequestDispatcher dispatcher = request.getRequestDispatcher("book.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("bookerror.jsp");
            }
        } else {
            response.sendRedirect("bookError.jsp");
        }

    }
}