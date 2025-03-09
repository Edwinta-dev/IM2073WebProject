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
    // Getting, when clicking Wishlist button
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        ArrayList<List<Object>> wishlistItems = new ArrayList<List<Object>>();
        if (userId != null) {
            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                String sql = "select books.title, books.price, books.cover_image_url, books.book_id from wishlist, books where user_id=? and books.book_id = wishlist.book_id order by wishlist.added_at desc";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    List<Object> item = new ArrayList<>();
                    item.add(rs.getString("title"));
                    item.add(rs.getString("price"));
                    item.add(rs.getString("cover_image_url"));
                    item.add(rs.getInt("book_id"));
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

    // Posting when adding books to Wishlist
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addWishlist(request, response);
        } else if ("remove".equals(action)) {
            removeWishlist(request, response);
        }
    }

    public void addWishlist(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("User ID is " + userId);
        System.out.println("Book ID is " + bookId);
        if (userId != null && bookId != null) {
            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                // Checking if wishlist entry alrdy exists
                String checkwishlist = "select * from  wishlist where user_id=? and book_id=?";
                PreparedStatement checkwishliststmt = conn.prepareStatement(checkwishlist);
                checkwishliststmt.setInt(1, userId);
                checkwishliststmt.setInt(2, bookId);
                ResultSet rs = checkwishliststmt.executeQuery();
                String message;
                if (rs.next()) {
                    // Logic handling for book entry in wishlist alrdy exists
                    message = "Already in cart !";
                    System.out.println(message);
                    // Store message in session (so it persists after redirect)
                    session.setAttribute("wishlistMessage", message);
                    // Redirect back to books page (or wherever the user was)
                    String redirect = "wishlist?userId==<%= userId%>";
                    response.sendRedirect(redirect);
                } else {

                    // Adding to wishlist
                    String sql = "Insert into wishlist(user_id,book_id) values (?,?)";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, userId);
                    stmt.setInt(2, bookId);
                    stmt.executeUpdate();
                    message = "Book sucessfully added to cart!";
                    System.out.println(message);
                    // Store message in session (so it persists after redirect)
                    session.setAttribute("wishlistMessage", message);
                    // Redirect back to books page (or wherever the user was)
                    String redirect = "wishlist?userId==<%= userId%>";
                    response.sendRedirect(redirect);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }

    public void removeWishlist(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId != null && bookId != null) {
            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                // Deleting from wishlist
                String removewishlist = "Delete from  wishlist where user_id=? and book_id=?";
                PreparedStatement removewishliststmt = conn.prepareStatement(removewishlist);
                removewishliststmt.setInt(1, userId);
                removewishliststmt.setInt(2, bookId);
                removewishliststmt.executeUpdate();
                String message;
                message = "Book successfully removed from wishlist";
                // Store message in session (so it persists after redirect)
                session.setAttribute("wishlistMessage", message);
                String redirect = "wishlist?userId==<%= userId%>";
                response.sendRedirect(redirect);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }

}
