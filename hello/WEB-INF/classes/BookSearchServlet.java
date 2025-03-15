import java.io.*;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.*; // Tomcat 10
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/bookSearch") // Configure the request URL for this servlet (Tomcat 7/Servlet 3.0 upwards)
public class BookSearchServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = (String) request.getParameter("search");
        ArrayList<List<Object>> searchItems = new ArrayList<List<Object>>();
        if (search != null) {
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                String sql = "SELECT TITLE,PRICE,COVER_IMAGE_URL,BOOK_ID FROM BOOKS WHERE TITLE LIKE '%";
                sql += search;
                sql += "%' OR GENRE LIKE '%";
                sql += search;
                sql += "%'";
                System.out.println(sql);
                PreparedStatement searchstmt = conn.prepareStatement(sql);
                ResultSet rs = searchstmt.executeQuery();
                while (rs.next()) {
                    List<Object> item = new ArrayList<>();
                    item.add(rs.getString("title"));
                    item.add(rs.getString("price"));
                    item.add(rs.getString("cover_image_url"));
                    item.add(rs.getInt("book_id"));
                    searchItems.add(item);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            System.out.println("Search: " + search);
            request.setAttribute("search", search);
            request.setAttribute("searchItems", searchItems);
            RequestDispatcher dispatcher = request.getRequestDispatcher("searchItem.jsp");
            dispatcher.forward(request, response);

        }
    }
}