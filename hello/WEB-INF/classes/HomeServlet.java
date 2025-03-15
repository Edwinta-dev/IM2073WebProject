import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.*; // Tomcat 10
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.util.logging.Logger;

@WebServlet("/home")
            /*
             *  My goal when the user views home is to have several selections availble to user with a variety of sorting criteria
             *  1 BestSeller
             * 
             * 
             * 
             * 
             * 
             * 
             * 
             */
public class HomeServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        ArrayList<List<Object>> cartItems = new ArrayList<List<Object>>();

            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                String sql = " select cart.quantity, books.title, books.price, books.cover_image_url, books.book_id from cart, books where user_id=? and books.book_id = cart.book_id order by cart.added_at desc";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    List<Object> item = new ArrayList<>();
                    item.add(rs.getString("title"));
                    item.add(rs.getDouble("price"));
                    item.add(rs.getInt("quantity"));
                    item.add(rs.getString("cover_image_url"));
                    item.add(rs.getInt("book_id"));
                    cartItems.add(item);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.setAttribute("cartItems", cartItems);
            String checkoutaction = request.getParameter("action");
            if ("checkout".equals(checkoutaction)) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
                dispatcher.forward(request, response);

            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
                dispatcher.forward(request, response);
            }
        }
}