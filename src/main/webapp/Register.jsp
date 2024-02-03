<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>REGISTER PAGE</title>
</head>
<body>
<%
    // Retrieve form data
    String firstName = request.getParameter("fname");
    String lastName = request.getParameter("lname");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Establish database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "admin");
        
        // Check if the email already exists
        ps = conn.prepareStatement("SELECT * FROM Registerusers WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            // Email already exists, display an error message
            %>
            <script>
                window.onload = function() {
                	var messageContainer = document.createElement('div');
                    messageContainer.style.display = 'flex';
                    messageContainer.style.alignItems = 'center';
                    messageContainer.style.justifyContent = 'center';
                    messageContainer.style.height = '50vh';

                    var message = document.createElement('div');
                    message.innerHTML = 'User already exists. Please choose a different email.';
                    message.style.backgroundColor = 'red';
                    message.style.color = 'white';
                    message.style.padding = '10px';
                    message.style.fontSize = '20px';

                    messageContainer.appendChild(message);
                    document.body.appendChild(messageContainer);
                };
                // Redirect to registration page after 3 seconds
                setTimeout(function() {
                    window.location.href = 'login.html';
                }, 1800);
            </script>
            <%
        } 
        
        else {
            // Check if the username already exists
            ps = conn.prepareStatement("SELECT * FROM Registerusers WHERE username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Username already exists, display an error message
                %>
                <script>
                    window.onload = function() {
                        var messageContainer = document.createElement('div');
                        messageContainer.style.display = 'flex';
                        messageContainer.style.alignItems = 'center';
                        messageContainer.style.justifyContent = 'center';
                        messageContainer.style.height = '50vh';

                        var message = document.createElement('div');
                        message.innerHTML = 'User with this username already exists. Please choose a different username.';
                        message.style.backgroundColor = 'red';
                        message.style.color = 'white';
                        message.style.padding = '10px';
                        message.style.fontSize = '20px';

                        messageContainer.appendChild(message);
                        document.body.appendChild(messageContainer);
                    };
                    // Redirect to registration page after 3 seconds
                    setTimeout(function() {
                        window.location.href = 'login.html';
                    }, 1800);
                </script>
                <%
            }
        
        
        else {
            // Email does not exist, proceed with registration
            ps = conn.prepareStatement("insert into Registerusers values(?,?,?,?,?)");
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, username);
            ps.setString(4, email);
            ps.setString(5, password);

            // Execute the statement
            ps.executeUpdate();
            %>
            <script>
                // Display registration successful message
                window.onload = function() {
                	var messageContainer = document.createElement('div');
                    messageContainer.style.display = 'flex';
                    messageContainer.style.alignItems = 'center';
                    messageContainer.style.justifyContent = 'center';
                    messageContainer.style.height = '50vh';

                    var message = document.createElement('div');
                    message.innerHTML = 'Register Sucessfull';
                    message.style.backgroundColor = 'green';
                    message.style.color = 'white';
                    message.style.padding = '10px';
                    message.style.fontSize = '20px';

                    messageContainer.appendChild(message);
                    document.body.appendChild(messageContainer);
                };
                // Redirect to login page after 3 seconds
                setTimeout(function() {
                    window.location.href = 'login.html';
                }, 1800);
            </script>
            <%
        }
    }
    }
    catch (Exception e) {
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
%>
</body>
</html>
