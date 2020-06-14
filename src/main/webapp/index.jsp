<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="model.*" %>
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
    <h2>Welcome <strong>${user.username}</strong></h2>
    <a href="/checkout">Checkout</a>
    <a href="/logout">Logout</a>
</c:if>
</div>
<%
    Product[] products = new ProductDAO().getAllProducts();
    request.setAttribute("products", products);
%>
<jsp:include page="/WEB-INF/product.jsp"></jsp:include>
</body>
</html>