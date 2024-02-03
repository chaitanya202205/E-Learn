<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Password</title>
</head>
<body>
    <h2>Update Profile</h2>
    <% 
    if (request.getMethod().equalsIgnoreCase("POST")) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Establish database connection
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "admin");

            // Retrieve form data
            String password = request.getParameter("password");

            // Update user profile in the database
            String loggedInUsername = (String) session.getAttribute("username"); // Assuming username is stored in a session variable
            ps = conn.prepareStatement("UPDATE Registerusers SET password = ? WHERE username = ?");
            ps.setString(1, password);
            ps.setString(2, loggedInUsername);
            int rowsUpdated = ps.executeUpdate();

            // Redirect to user details page after update
            if (rowsUpdated > 0) {
                response.sendRedirect("Userpassword.jsp");
                
            } else {
                out.println("<p>Failed to update password. Please try again.</p>");
            }
        } catch (Exception e) {
            out.println(e);
        } finally {
            // Close the resources
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>
   
</body>
</html>
