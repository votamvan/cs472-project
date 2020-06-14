<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${products == null}">
	<c:redirect url="/product"/>
</c:if>
<html lang="en">
<head>
<title>Product Page</title>
<script>
</script>
</head>
<body>
	<h1>Products</h1>
	<table cellpadding="2" cellspacing="2" border="1">
		<tr>
			<th>Id</th>
			<th>Title</th>
			<th>Overview</th>
			<th>Genres</th>
			<th>Photo</th>
			<th>Price</th>
		</tr>
		<c:forEach var="product" items="${products}">
			<tr>
				<td>${product.id}</td>
				<td>${product.title}</td>
				<td>${product.overview}</td>
				<td>${product.genres}</td>
				<td>
					<img src="${product.poster_path}" width="120">
				</td>
				<td>${product.price}</td>
				<td align="center">
					<a href="${pageContext.request.contextPath}/cart?&action=buy&id=${product.id}">Buy</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>