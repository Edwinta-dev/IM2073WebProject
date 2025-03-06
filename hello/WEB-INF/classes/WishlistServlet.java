import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.*; // Tomcat 10
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.util.logging.Logger;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        ArrayList<List<Object>> wishlistItems = new ArrayList<List<Object>>();
        if (userId != null) {
            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                String sql = "select books.title, books.price, books.cover_image_url from wishlist, books where user_id=? and books.book_id = wishlist.book_id order by wishlist.added_at desc";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    List<Object> item = new ArrayList<>();
                    item.add(rs.getString("title"));
                    item.add(rs.getString("price"));
                    item.add(rs.getString("cover_image_url"));
                    wishlistItems.add(item);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            System.out.println("Wishlist Items: " + wishlistItems);
            request.setAttribute("wishlistItems", wishlistItems);
            RequestDispatcher dispatcher = request.getRequestDispatcher("wishlist.jsp");
            dispatcher.forward(request, response);
        }
    }

}
