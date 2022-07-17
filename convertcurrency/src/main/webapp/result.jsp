<%--
  Created by IntelliJ IDEA.
  User: URIGOO
  Date: 09/07/2022
  Time: 9:10 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

    <h1>Rate: <c:out value="${requestScope.rRate}"></c:out></h1>
    <h1>USD: <c:out value="${requestScope.rUSD}"></c:out></h1>
    <h1>VND: ${requestScope.rVND}</h1>

    <c:choose>
        <c:when test="${requestScope.rVND<50000}">
            <p>NGHEO QUA DI</p>
        </c:when>
        <c:when test="${requestScope.rVND<100000 }">
            <p>DU AN</p>
        </c:when>
        <c:otherwise>
            <p>DAI GIA</p>
        </c:otherwise>
    </c:choose>
</body>
</html>
