<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Retrieve form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    // Database connection parameters
    String dbURL ="jdbc:oracle:thin:@localhost:1521:xe"; // Change the URL based on your database configuration
    String dbUser = "SYSTEM"; // Replace with your database username
    String dbPassword = "admin"; // Replace with your database password

    // Database connection and query
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load and register the JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");
        
        // Open a connection to the database
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        // Prepare the SQL statement for inserting data
        String insertQuery = "INSERT INTO contactusdata(name, email, message) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(insertQuery);
        
        // Set the parameters for the query
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, message);
        
        // Execute the insert query
        stmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the statement and database connection
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Form Submission Confirmation</title>
    <style>
        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
        }

        .container {
            max-width: 400px;
            padding: 20px;
            border-radius: 6px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        .content {
            text-align: center;
        }

        .content h1 {
            font-size: 28px;
            color: #4CAF50;
        }

        .content p {
            font-size: 16px;
            margin-top: 10px;
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="content">
            <h1>Thank You!</h1>
            <p>Your message has been submitted successfully.</p>
            <a href="home1.xhtml" class="back-link">Back to Home page</a>
        </div>
    </div>
</body>
</html>

