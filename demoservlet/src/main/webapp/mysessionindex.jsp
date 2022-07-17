<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>

<%
    System.out.println("JSP: Mysession in request: " + request.getRequestedSessionId());
    System.out.println("JSP: Mysession in server getSession(): " + request.getSession().getId());
%>

<form action="/sessionfirst">
    Name:<input type="text" name="username"><br>
    Password:<input type="password" name="userpass"><br>

    <input type="submit" value="login"/>
</form>

</body>
</html>