<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.*" %>
<fmt:setLocale value="en_US"/>
<jsp:useBean id= "ProductDAO" scope= "page"   class= "model.ProductDAO">        
</jsp:useBean>  

<c:if test="${not empty param.criteria}">
    <jsp:setProperty property="criteria" name="ProductDAO" value="${param.criteria}"/>
</c:if>
<c:if test="${not empty param.genre}">
    <jsp:setProperty property="criteria" name="ProductDAO" value="${param.genre}"/>
</c:if>
    
<c:set var="foundTotal" value="0"/>
<c:forEach var="product" items="${ProductDAO.productsByCriteria}"> 
    <c:set var="foundTotal" value="${foundTotal+1}"/>
</c:forEach>

<t:masterPage>
    <jsp:attribute name="title">
        DVD SHOP - Shop
    </jsp:attribute>
    <jsp:body>   
        <!-- Hero Section Begin -->
        <section class="hero hero-normal">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="hero__categories">
                            <div class="hero__categories__all">
                                <i class="fa fa-bars"></i>
                                <span>All Categories</span>
                            </div>
                            <ul>
                                <c:forEach var="genre" items="${ProductDAO.allGenres}">
                                    <li><a href="shop?genre=${genre}">${genre}</a></li>
                                </c:forEach> 
                            </ul>                            
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="hero__search">
                            <div class="hero__search__form">
                                <form action="shop">
                                    <div class="hero__search__categories">
                                        All Categories
                                        <span class="arrow_carrot-down"></span>
                                    </div>
                                    <input type="text" name="criteria" placeholder="What do yo u need?">
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
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="../resources/img/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>MIU-DVD SHOP</h2>
                            <div class="breadcrumb__option">
                                <a href="/">Home</a>
                                <span>Shop</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->        

        <!-- Product Section Begin -->
        <section class="product spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-5">
                        <div class="sidebar">
                            <div class="sidebar__item">
                                <h4>Categories</h4>
                                <ul>
                                    <c:forEach var="genre" items="${ProductDAO.allGenres}">
                                        <li><a href="shop?genre=${genre}">${genre}</a></li>
                                    </c:forEach> 
                                </ul>
                            </div>
                            <div class="sidebar__item">
                                <h4>Price</h4>
                                <div class="price-range-wrap">
                                    <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                        data-min="10" data-max="540">
                                        <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
                                        <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                        <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                    </div>
                                    <div class="range-slider">
                                        <div class="price-input">
                                            <input type="text" id="minamount">
                                            <input type="text" id="maxamount">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="sidebar__item sidebar__item__color--option">
                                <h4>Colors</h4>
                                <div class="sidebar__item__color sidebar__item__color--white">
                                    <label for="white">
                                        White
                                        <input type="radio" id="white">
                                    </label>
                                </div>
                                <div class="sidebar__item__color sidebar__item__color--gray">
                                    <label for="gray">
                                        Gray
                                        <input type="radio" id="gray">
                                    </label>
                                </div>
                                <div class="sidebar__item__color sidebar__item__color--red">
                                    <label for="red">
                                        Red
                                        <input type="radio" id="red">
                                    </label>
                                </div>
                                <div class="sidebar__item__color sidebar__item__color--black">
                                    <label for="black">
                                        Black
                                        <input type="radio" id="black">
                                    </label>
                                </div>
                                <div class="sidebar__item__color sidebar__item__color--blue">
                                    <label for="blue">
                                        Blue
                                        <input type="radio" id="blue">
                                    </label>
                                </div>
                                <div class="sidebar__item__color sidebar__item__color--green">
                                    <label for="green">
                                        Green
                                        <input type="radio" id="green">
                                    </label>
                                </div>
                            </div>
                            <div class="sidebar__item">
                                <h4>Popular Size</h4>
                                <div class="sidebar__item__size">
                                    <label for="large">
                                        Large
                                        <input type="radio" id="large">
                                    </label>
                                </div>
                                <div class="sidebar__item__size">
                                    <label for="medium">
                                        Medium
                                        <input type="radio" id="medium">
                                    </label>
                                </div>
                                <div class="sidebar__item__size">
                                    <label for="small">
                                        Small
                                        <input type="radio" id="small">
                                    </label>
                                </div>
                                <div class="sidebar__item__size">
                                    <label for="tiny">
                                        Tiny
                                        <input type="radio" id="tiny">
                                    </label>
                                </div>
                            </div>
                            <div class="sidebar__item">
                                <div class="latest-product__text">
                                    <h4>Latest Movies</h4>
                                    <div class="latest-product__slider owl-carousel">
                                        <div class="latest-prdouct__slider__item">
                                            <c:forEach var="product" items="${ProductDAO.allProducts}" begin="0" end="2">                                                
                                                <a href="product?id=${product.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${product.poster_path}" alt="${product.title}">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${fn:substring(product.title, 0, 35)}</h6>
                                                        <span><fmt:formatNumber value="${product.price}" type="currency"/></span>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </div>
                                        <div class="latest-prdouct__slider__item">
                                            <c:forEach var="product" items="${ProductDAO.allProducts}" begin="3" end="5">                                                
                                                <a href="product?id=${product.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${product.poster_path}" alt="${product.title}">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${fn:substring(product.title, 0, 35)}</h6>
                                                        <span><fmt:formatNumber value="${product.price}" type="currency"/></span>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>                                    
                                </div>
                            </div>
                            <div class="sidebar__item">
                                <div class="latest-product__text">
                                    <h4>Top Rated Movies</h4>
                                    <div class="latest-product__slider owl-carousel">
                                        <div class="latest-prdouct__slider__item">
                                            <c:forEach var="product" items="${ProductDAO.allProducts}" begin="10" end="12">                                                
                                                <a href="product?id=${product.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${product.poster_path}" alt="${product.title}">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${fn:substring(product.title, 0, 35)}</h6>
                                                        <span><fmt:formatNumber value="${product.price}" type="currency"/></span>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </div>
                                        <div class="latest-prdouct__slider__item">
                                            <c:forEach var="product" items="${ProductDAO.allProducts}" begin="13" end="15">                                                
                                                <a href="product?id=${product.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${product.poster_path}" alt="${product.title}">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${fn:substring(product.title, 0, 35)}</h6>
                                                        <span><fmt:formatNumber value="${product.price}" type="currency"/></span>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>                                    
                                </div>
                            </div>
                            <div class="sidebar__item">
                                <div class="latest-product__text">
                                    <h4>Review Movies</h4>
                                    <div class="latest-product__slider owl-carousel">
                                        <div class="latest-prdouct__slider__item">
                                            <c:forEach var="product" items="${ProductDAO.allProducts}" begin="20" end="22">                                                
                                                <a href="product?id=${product.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${product.poster_path}" alt="${product.title}">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${fn:substring(product.title, 0, 35)}</h6>
                                                        <span><fmt:formatNumber value="${product.price}" type="currency"/></span>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </div>
                                        <div class="latest-prdouct__slider__item">
                                            <c:forEach var="product" items="${ProductDAO.allProducts}" begin="23" end="25">                                                
                                                <a href="product?id=${product.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${product.poster_path}" alt="${product.title}">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${fn:substring(product.title, 0, 35)}</h6>
                                                        <span><fmt:formatNumber value="${product.price}" type="currency"/></span>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-7">
                        <div class="product__discount">
                            <div class="section-title product__discount__title">
                                <h2>Sale Off</h2>
                            </div>
                            <div class="row">
                                <div class="product__discount__slider owl-carousel">
                                    <c:forEach var="product" items="${ProductDAO.allProducts}">
                                        <div class="col-lg-4">
                                            <div class="product__discount__item">
                                                <div class="product__discount__item__pic set-bg"
                                                    data-setbg="${product.poster_path}">
                                                    <div class="product__discount__percent">-20%</div>
                                                    <ul class="product__item__pic__hover">
                                                        <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                        <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                                        <li><a href="<c:url value='cart?&action=buy&id=${product.id}' />"><i class="fa fa-shopping-cart"></i></a></li>
                                                    </ul>
                                                </div>
                                                <div class="product__discount__item__text">
                                                    <span>${product.genres}</span>
                                                    <h5><a href="product?id=${product.id}">${fn:substring(product.title, 0, 35)}</a></h5>
                                                    <div class="product__item__price"><fmt:formatNumber value="${product.price*0.8}" type="currency"/> <span><fmt:formatNumber value="${product.price}" type="currency"/></span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="filter__item">
                            <div class="row">
                                <div class="col-lg-4 col-md-5">
                                    <div class="filter__sort">
                                        <span>Sort By</span>
                                        <select>
                                            <option value="0">Default</option>
                                            <option value="0">Default</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4">
                                    <div class="filter__found">
                                        <h6><span>${foundTotal}</span> movies found</h6>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-3">
                                    <div class="filter__option">
                                        <span class="icon_grid-2x2"></span>
                                        <span class="icon_ul"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <c:forEach var="product" items="${ProductDAO.productsByCriteria}" end="35">  
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="product__item">
                                        <div class="product__item__pic set-bg" data-setbg="${product.poster_path}">
                                            <ul class="product__item__pic__hover">
                                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                                <li><a href="<c:url value='cart?&action=buy&id=${product.id}' />"><i class="fa fa-shopping-cart"></i></a></li>
                                            </ul>
                                        </div>
                                        <div class="product__item__text">
                                            <h6><a href="product?id=${product.id}">${fn:substring(product.title, 0, 35)}</a></h6>
                                            <h5><fmt:formatNumber value="${product.price}" type="currency"/></h5>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>                            
                        </div>
                        <div class="product__pagination">
                            <a href="#">1</a>
                            <a href="#">2</a>
                            <a href="#">3</a>
                            <a href="#"><i class="fa fa-long-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Product Section End -->
        <script src="../resources/js/custom/shop.js"></script>
    </jsp:body>
</t:masterPage>
