<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.*" %>
<fmt:setLocale value="en_US"/>
<t:adminPage>
    <jsp:attribute name="title">
        DVD SHOP - Admin Home Page 
    </jsp:attribute>
    <jsp:body>
<!-- Hero Section Begin -->
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="hero__categories">
                    <div class="hero__categories__all">
                        <i class="fa fa-bars"></i>
                        <span>Admin Menu</span>
                    </div>
                    <ul>
                        <li><a href="/admin/user">Users</a></li>
                        <li><a href="/admin/product">Products</a></li>
                        <li><a href="/admin/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <form action="#">
                            <input type="text" placeholder="What do you need?">
                            <button type="submit" class="site-btn">SEARCH</button>
                        </form>
                    </div>
                    <div class="hero__search__phone">
                        <div class="hero__search__phone__icon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <div class="hero__search__phone__text">
                            <h5>651-118-8888</h5>
                            <span>support 24/7 time</span>
                        </div>
                    </div>
                </div>
                <div class="hero__item set-bg" data-setbg="../resources/img/hero/admin-banner.png">
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Hero Section End -->
    </jsp:body>
</t:adminPage>
