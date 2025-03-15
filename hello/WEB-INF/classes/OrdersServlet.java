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

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String action = (String) request.getParameter("action");
        /*
         * My goal is to create an order page that is able to allow users to view past
         * orders,according to which section of the page they are in
         * (pending/completed/cancelled)
         * To reduce confusion I will create 2 lists here, order list and order_items
         * list
         * order_list will contain all orders of status (Pending/completed/cancelled)
         * order_items will contain all items of status (Pending/completed/cancelled)
         * Then after sending back to client, the JSP will iterate through order_list to
         * match order_id with the respective order_items
         */
        // Instantiate first array list to store orders
        ArrayList<List<Object>> ordersList = new ArrayList<List<Object>>();
        // Instantiate second array list to store order_items
        ArrayList<List<Object>> orderItemsList = new ArrayList<List<Object>>();
        // Instantiatng a third list to collate orderIDs for order items to use for
        // order_items
        List<Integer> orderIDList = new ArrayList<Integer>();
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                "xxxx")) {
            // Statement to select order status based on user input
            String orderStatus = "SELECT ORDER_ID,TOTAL_PRICE,ORDER_DATE FROM ORDERS WHERE USER_ID=? AND STATUS=? ORDER BY ORDER_ID DESC";
            PreparedStatement orderStatusstmt = conn.prepareStatement(orderStatus);

            orderStatusstmt.setInt(1, userId);
            if ("cancelled".equals(action)) {
                orderStatusstmt.setInt(2, 3);
            } else if ("completed".equals(action)) {
                orderStatusstmt.setInt(2, 2);
            } else {
                orderStatusstmt.setInt(2, 1);
            }
            // Collating orders into a nested array list
            ResultSet orderrs = orderStatusstmt.executeQuery();
            while (orderrs.next()) {
                List<Object> orders = new ArrayList<Object>();
                orderIDList.add(orderrs.getInt("ORDER_ID"));
                orders.add(orderrs.getInt("ORDER_ID"));
                orders.add(orderrs.getDouble("TOTAL_PRICE"));
                orders.add(orderrs.getDate("ORDER_DATE"));
                ordersList.add(orders);
            }

            // Iterating through each order in ordersList to retrieve order_items for every
            // order
            for (int i = 0; i < orderIDList.size(); i++) {
                Integer orderID = orderIDList.get(i);
                String orderItemsString = "SELECT ORDER_ITEMS.ORDER_ID,BOOKS.TITLE,ORDER_ITEMS.PRICE, ORDER_ITEMS.QUANTITY FROM BOOKS, ORDER_ITEMS WHERE ORDER_ITEMS.ORDER_ID=? AND ORDER_ITEMS.BOOK_ID = BOOKS.BOOK_ID";
                PreparedStatement orderItemsstmt = conn.prepareStatement(orderItemsString);
                orderItemsstmt.setInt(1, orderID);
                ResultSet orderItemsrs = orderItemsstmt.executeQuery();
                while (orderItemsrs.next()) {
                    List<Object> orderItems = new ArrayList<Object>();
                    orderItems.add(orderItemsrs.getInt("ORDER_ID"));
                    orderItems.add(orderItemsrs.getString("TITLE"));
                    orderItems.add(orderItemsrs.getDouble("PRICE"));
                    orderItems.add(orderItemsrs.getInt("QUANTITY"));
                    orderItemsList.add(orderItems);
                }
            }
            request.setAttribute("orderItemList", orderItemsList);
            request.setAttribute("ordersList", ordersList);
            request.setAttribute("status", action);

            RequestDispatcher dispatcher = request.getRequestDispatcher("orders.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String action = (String) request.getParameter("action");
        String orderIdStr = request.getParameter("order_id");
        Integer order_id = (orderIdStr != null && !orderIdStr.isEmpty()) ? Integer.parseInt(orderIdStr) : null;
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/im2073webproj", "myuser",
                "xxxx")) {
            if ("received".equals(action)) {
                String sql = "UPDATE ORDERS SET STATUS =2 WHERE ORDER_ID=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, order_id);
                stmt.executeUpdate();
                System.out.println("Updated pending order to completed");
                response.sendRedirect("orders?action=completed");
            } else if ("cancel".equals(action)) {
                String sql = "UPDATE ORDERS SET STATUS =3 WHERE ORDER_ID=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, order_id);
                stmt.executeUpdate();
                System.out.println("Updated pending order to canceled");
                response.sendRedirect("orders?action=cancelled");
            } else if ("delete".equals(action)) {
                String status = (String) request.getParameter("status");
                String sql = "DELETE FROM ORDERS WHERE ORDER_ID =?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, order_id);
                stmt.executeUpdate();
                System.out.println("Deleted canceled/completed order");
                response.sendRedirect("orders?action=" + status);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
