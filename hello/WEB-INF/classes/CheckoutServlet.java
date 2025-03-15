import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;
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

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        double totalPrice = 0.0;
        if (userId != null) {
            ArrayList<List<Object>> Order = new ArrayList<List<Object>>();
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                    "xxxx")) {
                /*
                 * Upon order, will have to do several things
                 * First retrieve what items were ordered
                 * Next create an order in orders table
                 * Next create an entry in order_items table to update contents of the order
                 * Next decrement stock in books by the order quantity for respective books
                 * Lastly clear user's cart
                 */
                // Retrieving user cart
                String cartItems = "SELECT BOOKS.TITLE, BOOKS.PRICE, CART.QUANTITY, CART.BOOK_ID FROM BOOKS, CART WHERE USER_ID=? AND CART.BOOK_ID=BOOKS.BOOK_ID";
                PreparedStatement cartItemsstmt = conn.prepareStatement(cartItems);
                cartItemsstmt.setInt(1, userId);
                ResultSet rs = cartItemsstmt.executeQuery();
                while (rs.next()) {
                    List<Object> bookOrder = new ArrayList<Object>();
                    bookOrder.add(rs.getInt("book_id"));
                    bookOrder.add(rs.getInt("quantity"));
                    bookOrder.add(rs.getDouble("price"));
                    bookOrder.add(rs.getString("TITLE"));
                    totalPrice += rs.getDouble("price") * rs.getInt("quantity");
                    Order.add(bookOrder);
                }
                rs.close();
                // Creating entry in order table
                String orderString = "INSERT INTO ORDERS(USER_ID,TOTAL_PRICE) VALUES (?,?)";
                PreparedStatement orderStringstmt = conn.prepareStatement(orderString);
                orderStringstmt.setInt(1, userId);
                orderStringstmt.setDouble(2, totalPrice);
                orderStringstmt.executeUpdate();
                System.out.println("Order created!");
                // Retrieve the generated order_id
                String orderIdSelect = "SELECT MAX(ORDER_ID) FROM ORDERS";
                PreparedStatement orderIdstmt = conn.prepareStatement(orderIdSelect);
                ResultSet orderIdrs = orderIdstmt.executeQuery();
                if (orderIdrs.next()) {
                    // Creating entry in order items
                    Integer orderId = (Integer) orderIdrs.getInt("MAX(ORDER_ID)");
                    System.out.println(orderId);
                    String order_itemsString = "INSERT INTO ORDER_ITEMS(ORDER_ID,BOOK_ID,QUANTITY,PRICE) VALUES (?,?,?,?)";
                    PreparedStatement order_itemStringstmt = conn.prepareStatement(order_itemsString);
                    for (List<Object> bookOrder : Order) {
                        // Iterating through bookOrders in Order
                        order_itemStringstmt.setInt(1, orderId);
                        Integer quantity = (Integer) bookOrder.get(1);
                        Integer bookId = (Integer) bookOrder.get(0);
                        double unitPrice = (double) bookOrder.get(2);
                        order_itemStringstmt.setInt(2, bookId);
                        order_itemStringstmt.setInt(3, quantity);
                        double bookTotalPrice = quantity * unitPrice;
                        order_itemStringstmt.setDouble(4, bookTotalPrice);
                        order_itemStringstmt.executeUpdate();
                        order_itemStringstmt.clearParameters();
                        System.out.println("Order item added");
                        // Decrementing stock in books
                        String bookStockDecreaseString = "UPDATE BOOKS SET STOCK_QUANTITY = STOCK_QUANTITY-? WHERE BOOK_ID =?";
                        PreparedStatement bookStockDecreaseStringstmt = conn.prepareStatement(bookStockDecreaseString);
                        // Decrementing book stock by order amount
                        bookStockDecreaseStringstmt.setInt(1, quantity);
                        bookStockDecreaseStringstmt.setInt(2, bookId);
                        bookStockDecreaseStringstmt.executeUpdate();
                        // Book stock decremented
                        System.out.println("Book stock decremented");
                    }
                }
                // Clearing Cart
                String deleteCartString = "DELETE FROM CART WHERE USER_ID=?";
                PreparedStatement deleteCartStringstmt = conn.prepareStatement(deleteCartString);
                deleteCartStringstmt.setInt(1, userId);
                deleteCartStringstmt.executeUpdate();
                System.out.println("Cart has been cleared!");

            } catch (Exception e) {
                e.printStackTrace();
            }
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("Order", Order);
            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
        }
    }
}
