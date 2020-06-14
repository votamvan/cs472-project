<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<c:if test="${sessionScope.cart == null}">
	<c:redirect url="/product"/>
</c:if>
<c:if test="${sessionScope.user == null}">
	<c:redirect url="/login"/>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Checkout Page</title>
<link rel="stylesheet" href="resources/css/checkout.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/checkout.js"></script>
</head>
<body>
    <h2>Order Summary</h2>
<% request.setAttribute("disableCheckout", true); %>
<jsp:include page="/WEB-INF/cart.jsp"></jsp:include>
<hr>
<form action="/checkout" method="POST">
    <hr>
    <div class="row">
        <div class="col-50">
        <h3>Billing Address</h3>
        <label for="bill_fname">Full Name</label>
        <input type="text" id="bill_fname" name="bill_fname" placeholder="John Smith" required>
        <label for="bill_email">Email</label>
        <input type="text" id="bill_email" name="bill_email" placeholder="compro@miu.edu" required
                pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                title="Invalid email format">
        <label for="bill_adr">Address</label>
        <input type="text" id="bill_adr" name="bill_adr" placeholder="1000 North 4th Street">
        <label for="bill_city">City</label>
        <input type="text" id="bill_city" name="bill_city" placeholder="Fairfield" required>

        <div class="row">
            <div class="col-50">
            <label for="bill_state">State</label>
            <input type="text" id="bill_state" name="bill_state" placeholder="IA" list="state_list" required
                    pattern="^[A-Za-z]{2}$" title="Two letter state code">
            <datalist id="state_list">
                <option value="CA">
                <option value="FL">
                <option value="IA">
                <option value="IL">
            </datalist>
            </div>
            <div class="col-50">
            <label for="bill_zip">Zip</label>
            <input type="text" id="bill_zip" name="bill_zip" placeholder="52557" 
                    pattern="^([0-9]{5})$" title="Five number zip code" required>
            </div>
        </div>
        </div>

        <div class="col-50">
        <h3>Payment Info</h3>
        <label>Accepted Cards</label>
        <img src="resources/images/412930.jpg" alt="Accepted Cards" width="288" height="67"/>
        <fieldset>
            <legend>Credit cards:</legend>
            <input type="radio" name="cc" value="visa" checked="checked" /> Visa
            <input type="radio" name="cc" value="mastercard" /> MasterCard
            <input type="radio" name="cc" value="discover" /> Discover
            <input type="radio" name="cc" value="amex" /> American Express
        </fieldset>
        <br>
        <label for="cname">Name on Card</label>
        <input type="text" id="cname" name="cardname" placeholder="John Smith" required>
        <label for="ccnum">Credit card number</label>
        <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444" required>
        <div class="row">
            <div class="col-50">
            <label for="exp_month">Expire month</label>
            <select id="exp_month" name="exp_month" size="1" required>
                <option value="" selected>Choose month</option>
                <option>January</option>
                <option>Feburary</option>
                <option>March</option>
                <option>April</option>
                <option>May</option>
                <option>June</option>
                <option>July</option>
                <option>August</option>
                <option>September</option>
                <option>October</option>
                <option>November</option>
                <option>December</option>
            </select>
            </div>
            <div class="col-25">
            <label for="exp_year">Expire year</label>
            <input type="text" id="exp_year" name="exp_year" placeholder="2024" list="year_list" required>
            <datalist id="year_list">
                <option value="2020">
                <option value="2021">
                <option value="2022">
                <option value="2023">
                <option value="2024">
                <option value="2025">
            </datalist>
            </div>
            <div class="col-25">
            <label for="cvv">CVV</label>
            <input type="text" id="cvv" name="cvv" placeholder="352" required>
            </div>
        </div>
        </div>

    </div>
    <label>
        <input type="checkbox" id="sameadr" name="sameadr" onclick="myFunction()"> Shipping address same as billing
    </label>

    <div class="row">
        <div class="col-50">
        <h3>Shipping Address</h3>
        <label for="ship_fname">Full Name</label>
        <input type="text" id="ship_fname" name="ship_fname" placeholder="John Smith" required>
        <label for="ship_email">Email</label>
        <input type="text" id="ship_email" name="ship_email" placeholder="compro@miu.edu" required
                pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                title="Invalid email format">
        <label for="ship_adr">Address</label>
        <input type="text" id="ship_adr" name="ship_adr" placeholder="1000 North 4th Street" required>
        <label for="ship_city">City</label>
        <input type="text" id="ship_city" name="ship_city" placeholder="Fairfield" required>

        <div class="row">
            <div class="col-50">
            <label for="ship_state">State</label>
            <input type="text" id="ship_state" name="ship_state" placeholder="IA" 
                    list="state_list" pattern="^[A-Za-z]{2}$" title="Two letter state code" required>
            </div>
            <div class="col-50">
            <label for="ship_zip">Zip</label>
            <input type="text" id="ship_zip" name="ship_zip" placeholder="52557" 
                    pattern="^[0-9]{5}$" title="Five number zip code" required>
            </div>
        </div>
        </div>
        <div class="col-50"></div>
    </div>

    <hr>
    <label>
        <input type="checkbox" name="agree" required> By clicking this check box, I hereby:
    </label>
    <ul>
        <li>Agree and consent to the User Agreement, and the Return Policy</li>
    </ul>
    <input type="submit" value="Continue to checkout" class="btn">
</form>
</body>
</html>