<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User password update</title>
    <style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        th, td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        h2 {
            margin-bottom: 20px;
        }

        form {
            max-width: 400px;
            margin-bottom: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .update-message {
            margin-top: 20px;
            padding: 10px;
            background-color: #f2f2f2;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <h2>password update</h2>
    <%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Establish database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "admin");

        // Retrieve user details for the logged-in user
        String loggedInUsername = (String) session.getAttribute("username"); // Assuming username is stored in a session variable
        ps = conn.prepareStatement("SELECT * FROM Registerusers WHERE username = ?");
        ps.setString(1, loggedInUsername);
        rs = ps.executeQuery();
        
        // Display the user details in a table
        if (rs.next()) {
            
            String user = rs.getString("username");
            String password = rs.getString("password");
            
    %>
    <table>
        <tr>
           
            <th>Username</th>
           <th>Password</th>
        </tr>
        <tr>
            
            <td><%= user %></td>
            <td><%= password %></td>
        </tr>
    </table>
    <br>
    <h3>Update Password</h3>
    <form action="UpdatePassword.jsp" method="post">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]+$" required><br>
        <input type="submit" value="Update Password">
    </form>
    <%
        } else {
            out.println("<p>No user details found.</p>");
        }
    } catch (Exception e) {
        out.println(e);
    } finally {
        // Close the resources
        try {
            if (rs != null) {
                rs.close();
            }
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
    %>
</body>
</html>
