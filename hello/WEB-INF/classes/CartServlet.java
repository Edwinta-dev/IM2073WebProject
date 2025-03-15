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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String action = (String) request.getAttribute("action");
        ArrayList<List<Object>> cartItems = new ArrayList<List<Object>>();
        if (userId != null) {
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

    // Posting when adding books to Wishlist
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCart(request, response);
        } else if ("remove".equals(action)) {
            removeCart(request, response);
        }
    }

    public void addCart(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("User ID is " + userId);
        System.out.println("Book ID is " + bookId);
        if (userId != null && bookId != null) {
            // Establishing connection to server
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                // Checking Cart table
                /*
                 * For Cart quantity matters, so 2 cases
                 * 1. If entry alrdy exists update Db to increase quantity by 1
                 * 2. If entry does not exist yet create new entry
                 */
                String checkCart = "select quantity from  Cart where user_id=? and book_id=?";
                PreparedStatement checkCartstmt = conn.prepareStatement(checkCart);
                checkCartstmt.setInt(1, userId);
                checkCartstmt.setInt(2, bookId);
                ResultSet rs = checkCartstmt.executeQuery();
                String message;
                if (rs.next()) {
                    // Logic handling for Updating quantity in Cart
                    message = "Already in cart. Updating quantity";
                    System.out.println(message);
                    int quantity = rs.getInt("quantity");
                    quantity += 1;
                    // Store message in session (so it persists after redirect)
                    session.setAttribute("cartMessage", message);
                    // Updating DB
                    String updateCart = "Update cart set quantity =? where user_id=? and book_id=?";
                    PreparedStatement updateCartstmt = conn.prepareStatement(updateCart);
                    updateCartstmt.setInt(1, quantity);
                    updateCartstmt.setInt(2, userId);
                    updateCartstmt.setInt(3, bookId);
                    updateCartstmt.executeUpdate();
                    message = "Quantity updated to " + quantity;
                    System.out.println(message);
                    response.sendRedirect("cart?userId=" + userId); // Default page in case referer is null
                } else {

                    // Logic handling for Creating Entry in Cart
                    String addCart = "Insert into cart(user_id,book_id,quantity) values (?,?,1)";
                    String removeWishlist = "Delete from wishlist where user_id=? and book_id=?";
                    PreparedStatement addCartstmt = conn.prepareStatement(addCart);
                    PreparedStatement removeWishliststmt = conn.prepareStatement(removeWishlist);
                    addCartstmt.setInt(1, userId);
                    addCartstmt.setInt(2, bookId);
                    removeWishliststmt.setInt(1, userId);
                    removeWishliststmt.setInt(2, bookId);
                    addCartstmt.executeUpdate();
                    removeWishliststmt.executeUpdate();
                    message = "Book sucessfully added to cart!";
                    System.out.println(message);
                    message = "Book sucessfully removed from wishlist";
                    System.out.println(message);
                    response.sendRedirect("cart?userId=" + userId); // Default page in case referer is null
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }

    public void removeCart(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("User ID is " + userId);
        System.out.println("Book ID is " + bookId);
        if (userId != null && bookId != null) {
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                // Checking Cart table
                /*
                 * For Cart quantity matters, so 2 cases
                 * 1. If quantity more than 1 update Db to decrease quantity by 1
                 * 2. If quantity is 1 delete entry from db
                 */
                String checkCart = "select quantity from  Cart where user_id=? and book_id=?";
                PreparedStatement checkCartstmt = conn.prepareStatement(checkCart);
                checkCartstmt.setInt(1, userId);
                checkCartstmt.setInt(2, bookId);
                ResultSet rs = checkCartstmt.executeQuery();
                String message;
                if (rs.next()) {
                    int quantity = rs.getInt("quantity");
                    if (quantity > 1) {
                        // Logic handling for Reducing quantity in Cart
                        message = "Quantity greater than 1, reducing by 1";
                        System.out.println(message);
                        quantity -= 1;
                        // Store message in session (so it persists after redirect)
                        session.setAttribute("cartMessage", message);
                        // Updating DB
                        String updateCart = "Update cart set quantity =? where user_id=? and book_id=?";
                        PreparedStatement updateCartstmt = conn.prepareStatement(updateCart);
                        updateCartstmt.setInt(1, quantity);
                        updateCartstmt.setInt(2, userId);
                        updateCartstmt.setInt(3, bookId);
                        updateCartstmt.executeUpdate();
                        message = "Quantity updated to " + quantity;
                        System.out.println(message);
                        // Redirect back to books page (or wherever the user was)
                        String redirect = "cart?userId=" + userId;
                        response.sendRedirect(redirect);
                    } else if (quantity == 1) {
                        // Logic handling for Deleting Entry in Cart
                        String deleteCart = "Delete from cart where user_id=? and book_id=?";
                        PreparedStatement deleteCartstmt = conn.prepareStatement(deleteCart);
                        deleteCartstmt.setInt(1, userId);
                        deleteCartstmt.setInt(2, bookId);
                        deleteCartstmt.executeUpdate();
                        message = "Book sucessfully deleted from cart!";
                        System.out.println(message);
                        // Store message in session (so it persists after redirect)
                        session.setAttribute("cartMessage", message);
                        // Redirect back to books page (or wherever the user was)
                        String redirect = "cart?userId=" + userId;
                        response.sendRedirect(redirect);

                    } else {
                        System.out.println("Negative quantity error");
                    }

                } else {
                    System.out.println("Book entry does not exist");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
