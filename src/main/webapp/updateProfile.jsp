<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
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
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
           

            // Update user profile in the database
            String loggedInUsername = (String) session.getAttribute("username"); // Assuming username is stored in a session variable
            ps = conn.prepareStatement("UPDATE Registerusers SET fname = ?, lsname = ? WHERE username = ?");
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, loggedInUsername);
            int rowsUpdated = ps.executeUpdate();

            // Redirect to user details page after update
            if (rowsUpdated > 0) {
                response.sendRedirect("Users.jsp");
            } else {
                out.println("<p>Failed to update profile. Please try again.</p>");
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
