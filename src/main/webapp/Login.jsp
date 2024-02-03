<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="oracle.jdbc.driver.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN PAGE</title>
<style>
    #message {
        position: fixed;
        top: 10px;
        right: 10px;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        font-weight: bold;
        display: none;
    }
</style>
</head>
<body>
<%
    // Retrieve form data
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    boolean loginSuccessful = false;

    try {
        // Establish database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "admin");

        // Prepare SQL statement
        String sql = "SELECT * FROM Registerusers WHERE username = ? AND password = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);

        // Execute the statement
        resultSet = statement.executeQuery();

        // Check if the login was successful
        if (resultSet.next()) {
            loginSuccessful = true;
            String usernameFromDb = resultSet.getString("username");
            
            session.setAttribute("username", usernameFromDb);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the resources
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    if (loginSuccessful) {
        // Redirect to home page with successful login message
        response.sendRedirect("home1.xhtml;jsessionid=" + session.getId() + "?message=success");
    } else {
        // Display invalid login credentials message
%>
        <div id="message" style="display: none;"></div>
        <script>
            window.onload = function() {
            	var messageContainer = document.createElement('div');
                messageContainer.style.display = 'flex';
                messageContainer.style.alignItems = 'center';
                messageContainer.style.justifyContent = 'center';
                messageContainer.style.height = '50vh';

                var message = document.createElement('div');
                message.innerHTML = 'Invalid login Credentials';
                message.style.backgroundColor = 'red';
                message.style.color = 'white';
                message.style.padding = '10px';
                message.style.fontSize = '20px';

                messageContainer.appendChild(message);
                document.body.appendChild(messageContainer);
            };

            setTimeout(function() {
                window.location.href = 'login.html';
            }, 1200);
        </script>
<%
    }
%>

<script>
    // Display success message if provided in the URL query parameter
    var urlParams = new URLSearchParams(window.location.search);
    var successMessage = urlParams.get('message');
    if (successMessage === 'success') {
        document.getElementById('message').innerHTML = 'Login successful';
        document.getElementById('message').style.backgroundColor = '#4CAF50';
        document.getElementById('message').style.display = 'block';
    }
</script>

</body>
</html>
