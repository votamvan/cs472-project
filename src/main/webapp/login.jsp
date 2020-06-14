<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login Page</title>
<style>
body {
    background-color: linen;
}
h1 {
    color: maroon;
    margin-left: 40px;
}
ul {
    list-style-type: none;
    margin-left: 1%;
}
</style>
</head>
<body>
    <h1>Login Page</h1>
    <form method="POST" action="/login">
        <ul>
            <li><label for="username">User name</label></li>
            <li><input type="text" id="username" name="username" value="${cookie.username.value}"></li>
            <li><label for="password">Password</label></li>
            <li><input type="password" id="password" name="password"></li>
            <li>
                <input type="checkbox" id="remember" name="remember" <c:if test = "${cookie.username != null}">checked</c:if>> 
                <label for="remember">Remember me</label></li>
            <li><input type="submit" value="Login"></li>
            <li><a href="/signup">Sign Up here</a></li>
        </ul>
        <span>${message}</span>
    </form>
</body>
</html>