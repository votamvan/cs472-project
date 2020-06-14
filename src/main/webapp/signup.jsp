<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up Page</title>
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
    <h1>Sign Up Page</h1>
    <form method="POST" action="/signup">
        <ul>
            <li><label for="fullname">Full name</label></li>
            <li><input type="text" id="fullname" name="fullname"></li>
            <li><label for="username">Login name</label></li>
            <li><input type="text" id="username" name="username"></li>
            <li><label for="password">Password</label></li>
            <li><input type="password" id="password" name="password"></li>
            <li><label for="password2">Retype Password</label></li>
            <li><input type="password" id="password2" name="password2"></li>
            <input type="submit" value="Sign Up"></li>
        </ul>
        <span>${message}</span>
    </form>
</body>
</html>