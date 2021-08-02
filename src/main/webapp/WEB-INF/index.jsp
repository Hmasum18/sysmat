<%--
  Created by IntelliJ IDEA.
  User: Hasan Masum
  Date: 21-Jul-21
  Time: 11:53 AM
  To chanWEge this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>SysMat</title>
</head>
<body>
    <h3>Hey "${role}"</h3>
    <%
        out.println("Your IP address is: "+request.getRemoteAddr());
    %><br>
    <%
        out.println("Your username is: "+request.getRemoteUser());
    %>
    <p>Today's date: <%= new java.util.Date()%></p>
</body>
</html>
