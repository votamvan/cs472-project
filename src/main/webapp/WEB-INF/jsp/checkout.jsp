<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<fmt:setLocale value="en_US"/>
<c:if test="${sessionScope.cart == null}">
	<c:redirect url="/"/>
</c:if>
<c:if test="${sessionScope.user == null}">
	<c:redirect url="login"/>
</c:if>
<t:masterPage>
    <jsp:attribute name="title">
        DVD SHOP - Checkout
    </jsp:attribute>
    <jsp:body>   
        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="../resources/img/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Checkout</h2>
                            <div class="breadcrumb__option">
                                <a href="/">Home</a>
                                <span>Checkout</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Checkout Section Begin -->
        <section class="checkout spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h6><span class="icon_tag_alt"></span> Have a coupon? <a href="#">Click here</a> to enter your code
                        </h6>
                    </div>
                </div>
                <div class="checkout__form">
                    <h4>Billing Details</h4>
                    <form action="checkout" method="POST">
                        <div class="row">
                            <div class="col-lg-8 col-md-6">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Fist Name<span>*</span></p>
                                            <input type="text" placeholder="John" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Last Name<span>*</span></p>
                                            <input type="text" placeholder="Smith" required>
                                        </div>
                                    </div>
                                </div>                                
                                <div class="checkout__input">
                                    <p>Address<span>*</span></p>
                                    <input type="text" placeholder="Street Address" class="checkout__input__add">
                                    <input type="text" placeholder="Apartment, suite, unite ect (optinal)">
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Town/City<span>*</span></p>
                                            <input type="text" placeholder="Fairfield" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Country/State<span>*</span></p>
                                            <input type="text" placeholder="IA" placeholder="IA" list="state_list" required pattern="^[A-Za-z]{2}$" title="Two letter state code">
                                            <datalist id="state_list">
                                                <option value="CA">
                                                <option value="FL">
                                                <option value="IA">
                                                <option value="IL">
                                            </datalist>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Country<span>*</span></p>
                                            <input type="text" placeholder="United States" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Postcode / ZIP<span>*</span></p>
                                            <input type="text" placeholder="#####" pattern="^([0-9]{5})$" title="5-digit number" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Phone<span>*</span></p>
                                            <input type="text" placeholder="##########" pattern="^([0-9]{10})$" title="10-digit number" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Email<span>*</span></p>
                                            <input type="text" placeholder="compro@miu.edu" required pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" title="Invalid email format">
                                        </div>
                                    </div>
                                </div>                                
                                <div class="checkout__input__checkbox">
                                    <label for="diff-acc">
                                        Ship to a different address?
                                        <input type="checkbox" id="diff-acc">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__textarea">
                                    <p>Order notes<span>*</span></p>
                                    <textarea rows="5" cols="96" placeholder="Notes about your order, e.g. special notes for delivery."></textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="checkout__order">
                                    <h4>Your Order</h4>
                                    <div class="checkout__order__products">Products <span>Total</span></div>
                                    <ul>
                                        <c:set var="total" value="0" />
                                        <c:forEach var="item" items="${sessionScope.cart}">
			                                <c:set var="iTotal" value="${item.product.price*item.quantity}" />
			                                <c:set var="total" value="${total + iTotal}" /> 
                                            <li>${item.product.title} <span><fmt:formatNumber value="${iTotal}" type="currency"/></span></li>
                                        </c:forEach>
                                    </ul>
                                    <div class="checkout__order__subtotal">Subtotal <span><fmt:formatNumber value="${total}" type="currency"/></span></div>
                                    <div class="checkout__order__total">Total <span><fmt:formatNumber value="${total}" type="currency"/></span></div>
                                    
                                    <p>Please provide the payment information to perform your order.</p>
                                    <h4>Payment Info</h4>
                                    <label>Accepted Cards</label>
                                    <img src="resources/images/412930.jpg" alt="Accepted Cards" width="288" height="67"/>
                                    <div class="checkout__input__radio">
                                        <label for="visa">                                            
                                            <input type="radio" name="cc" id="visa" value="visa"/>Visa
                                        </label>
                                    </div>
                                    <div class="checkout__input__radio">
                                        <label for="mastercard">
                                            <input type="radio" name="cc" id="mastercard" value="mastercard" />MasterCard
                                        </label>
                                    </div>
                                    <div class="checkout__input__radio">
                                        <label for="discover">                                            
                                            <input type="radio" name="cc" id="discover" value="discover"/>Discover
                                        </label>
                                    </div>
                                    <div class="checkout__input__radio">
                                        <label for="amex">                                            
                                            <input type="radio" name="cc" id="amex" value="amex"/>American Express
                                        </label>
                                    </div>

                                    <ul>
                                        <li>
                                            <label for="cname">Card Name</label>
                                            <input type="text" id="cname" name="cardname" placeholder="John Smith" required>    
                                        </li>
                                        <li>
                                            <label for="ccnum">Card Number</label>
                                            <input type="text" id="ccnum" name="cardnumber" placeholder="####-####-####-####" required>
                                        </li>
                                        <li>
                                            <label for="exp_month">Expiration</label>
                                            <input id="exp_month" name="exp_month" size="8" placeholder="Month" list="month_list" required>
                                            <datalist id="month_list">
                                                <option>Jan</option>
                                                <option>Feb</option>
                                                <option>Mar</option>
                                                <option>Apr</option>
                                                <option>May</option>
                                                <option>Jun</option>
                                                <option>Jul</option>
                                                <option>Aug</option>
                                                <option>Sep</option>
                                                <option>Oct</option>
                                                <option>Nov</option>
                                                <option>Dec</option>
                                            </datalist>
                                            <input id="exp_year" name="exp_year" size="8" placeholder="Year" list="year_list" required>
                                            <datalist id="year_list">                                                
                                                <option value="2020">2020
                                                <option value="2021">2021
                                                <option value="2022">2022
                                                <option value="2023">2023
                                                <option value="2024">2024
                                                <option value="2025">2025
                                            </datalist>
                                        </li>
                                        <li>
                                            <label for="cvv">CVV</label>
                                            <input type="text" id="cvv" name="cvv" placeholder="###" size="8" required>
                                        </li>
                                    </ul>
                                    
                                    <hr>
                                    <label>
                                        <input type="checkbox" name="agree" required> By clicking this check box, I hereby:
                                    </label>
                                    <ul>
                                        <li>Agree and consent to the User Agreement, and the Return Policy</li>
                                    </ul>
                                    
                                    <button type="submit" class="site-btn">PLACE ORDER</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <!-- Checkout Section End -->
    </jsp:body>
</t:masterPage>
