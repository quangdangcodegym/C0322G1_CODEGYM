<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Management Application</title>
</head>
<body>
<center>
    <h1>User Management</h1>
    <h2>
        <a href="/users?action=create">Add New User</a>
    </h2>
</center>
<div align="center">

    <form action="users">
        Search: <input type="text" hint="search" value="${requestScope.q}" name="q"> Filter:
        <select name="idcountry">
            <option value="-1">All</option>
            <c:forEach items="${applicationScope.listCountry}" var="country">
                <c:choose>
                    <c:when test="${country.getId()== requestScope.idcountry}">
                        <option selected value="${country.getId()}">${country.getName()}</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${country.getId()}">${country.getName()}</option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </select><button type="get" >Submit</button>

    </form>
    <table border="1" cellpadding="5">
        <caption><h2>List of Users</h2></caption>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Country</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="user" items="${requestScope.listUser}">
            <tr>
                <td><c:out value="${user.getId()}"/></td>
                <td><c:out value="${user.getName()}"/></td>
                <td><c:out value="${user.getEmail()}"/></td>
                <td>
                    <c:forEach items="${applicationScope.listCountry }" var = "country">
                        <c:if test="${country.getId() == user.getIdcountry()}">
                            <c:out value="${country.getName()}"/>
                        </c:if>
                    </c:forEach>

                </td>
                <td>
                    <a href="/users?action=edit&id=${user.id}">Edit</a>
                    <a href="/users?action=delete&id=${user.id}">Delete</a>
                </td>
            </tr>
        </c:forEach>

    </table>
    <%--For displaying Previous link except for the 1st page --%>
    <c:if test="${currentPage != 1}">
        <td><a href="users?page=${currentPage - 1}&q=${requestScope.q}&idcountry=${requestScope.idcountry}">Previous</a></td>
    </c:if>

    <%--For displaying Page numbers.
    The when condition does not display a link for the current page--%>
    <table border="1" cellpadding="5" cellspacing="5">
        <tr>
            <c:forEach begin="1" end="${noOfPages}" var="i">
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <td>${i}</td>
                    </c:when>
                    <c:otherwise>
                        <td><a href="users?page=${i}&q=${requestScope.q}&idcountry=${requestScope.idcountry}">${i}</a></td>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </tr>
    </table>

    <%--For displaying Next link: lt < noOfPages--%>
    <c:if test="${currentPage lt noOfPages}">
        <td><a href="users?page=${currentPage + 1}&q=${requestScope.q}&idcountry=${requestScope.idcountry}">Next</a></td>
    </c:if>
</div>
</body>
</html>
