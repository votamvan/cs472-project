<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<c:if test="${user == null}">
	<c:redirect url="/index.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Assignment 13 - CS472</title>
<style>
body {
    background-color: linen;
}
strong {
    color: red;
}
</style>
</head>
<body>
<div style="text-align: center">
<h1>Assignment 13 - CS472</h1>
<c:if test="${user != null}">
    <h2>Thank you <strong>${user.username}</strong> for shopping</h2>
</c:if>
<a href="/index.jsp">Continue Shopping</a>
<a href="/logout">Logout</a>
</div>
</body>
</html>