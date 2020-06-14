<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Cart Page</title>
</head>
<body>
	<table cellpadding="2" cellspacing="2" border="1">
		<tr>
			<th>Option</th>
			<th>Id</th>
			<th>Name</th>
			<th>Photo</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Sub Total</th>
		</tr>
		<c:set var="total" value="0"></c:set>
		<c:forEach var="item" items="${sessionScope.cart}">
			<c:set var="total" value="${total + item.getSubTotal()}"></c:set>
			<tr>
				<td align="center">
					<a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}"
					onclick="return confirm('Are you sure?')">Remove</a>
				</td>
				<td>${item.product.id}</td>
				<td>${item.product.name}</td>
				<td>
					<img src="${item.product.photo}" width="120">
				</td>
				<td>${item.product.price}</td>
				<td>${item.quantity}</td>
				<td>${item.getSubTotal()}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6" align="right">Total</td>
			<td>
				<fmt:formatNumber type="number" maxFractionDigits="2" value="${total}" />
			</td>
			<!-- <td>${total}</td> -->
		</tr>
	</table>
	<br>
	<a href="${pageContext.request.contextPath}/product">Continue Shopping</a>
	<br>
<c:if test="${disableCheckout == null}">
	<a href="${pageContext.request.contextPath}/checkout">Checkout</a>
</c:if>
</body>
</html>