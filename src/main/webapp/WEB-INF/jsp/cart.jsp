<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<fmt:setLocale value="en_US"/>

<t:masterPage>
    <jsp:attribute name="title">
        DVD SHOP - Shopping Cart
    </jsp:attribute>
    <jsp:body>   
        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="../resources/img/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Shopping Cart</h2>
                            <div class="breadcrumb__option">
                                <a href="/">Home</a>
                                <span>Shopping Cart</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->   

        <!-- Shoping Cart Section Begin -->
        <section class="shoping-cart spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="shoping__cart__table">
                            <table>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th class="shoping__product">Movie</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>                                

                                <tbody>
                                    <c:set var="total" value="0" />
                                    <c:forEach var="item" items="${sessionScope.cart}">
                                        <c:set var="iTotal" value="${item.product.price*item.quantity}" />
			                            <c:set var="total" value="${total + iTotal}" />
                                        <tr>
                                            <td class="shoping__cart__view">
                                                <a href="product?id=${item.product.id}">View</a>
                                            </td>                                            
                                            <td class="shoping__cart__item">
                                                <img src="${item.product.poster_path}" alt="${item.product.title}" width="100px" height="100px">
                                                <h5>${item.product.title}</h5>
                                            </td>
                                            <td class="shoping__cart__price">
                                                <fmt:formatNumber value="${item.product.price}" type="currency"/>
                                            </td>
                                            <td class="shoping__cart__quantity">
                                                <div class="quantity">
                                                    <div class="pro-qty">
                                                        <input type="text" value="${item.quantity}">
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="shoping__cart__total">
                                                <fmt:formatNumber value="${iTotal}" type="currency"/>
                                            </td>
                                            <td class="shoping__cart__item__update">
                                                <span class="fa fa-refresh"></span>
                                            </td>
                                            <td class="shoping__cart__item__close">
                                                <span class="icon_close"></span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="shoping__cart__btns">
                            <a href="shop" class="primary-btn cart-btn">CONTINUE SHOPPING</a>
                            <a href="cart" class="primary-btn cart-btn cart-btn-right"><span class="icon_loading"></span>
                                Upadate Cart</a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="shoping__continue">
                            <div class="shoping__discount">
                                <h5>Discount Codes</h5>
                                <form action="#">
                                    <input type="text" placeholder="Enter your coupon code">
                                    <button type="submit" class="site-btn">APPLY COUPON</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="shoping__checkout">
                            <h5>Cart Total</h5>
                            <ul>                           
                                <li>SubTotal <span><fmt:formatNumber value="${total}" type="currency"/></span></li>     
                                <li>Total <span><fmt:formatNumber value="${total}" type="currency"/></span></li>
                            </ul>
                            <a href="checkout" class="primary-btn">PROCEED TO CHECKOUT</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shoping Cart Section End -->     
    </jsp:body>    
</t:masterPage>
