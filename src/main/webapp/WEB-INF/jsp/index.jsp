<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.*" %>
<fmt:setLocale value="en_US"/>
<jsp:useBean id= "ProductDAO" scope= "page"   class= "model.ProductDAO" />  
<t:masterPage>
    <jsp:attribute name="title">
        DVD SHOP - Home
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
                                <span>All categories</span>
                            </div>
                            <ul>
                                <c:forEach var="genre" items="${ProductDAO.allGenres}">
                                    <li><a href="/shop?genre=${genre}">${genre}</a></li>
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
                        <div class="hero__item set-bg" data-setbg="../resources/img/hero/banner.jpg">
                            <div class="hero__text">
                                <span>NEW SERIES</span>
                                <h2>Movie <br />100% Origin</h2>
                                <p>Free Pickup and Delivery Available</p>
                                <a href="#" class="primary-btn">SHOP NOW</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

        <!-- Categories Section Begin -->
        <section class="categories">
            <div class="container">
                <div class="row">
                    <div class="categories__slider owl-carousel">
                        <div class="col-lg-3">
                            <div class="categories__item set-bg" data-setbg="../resources/img/categories/cat-1.jpg">
                                <h5><a href="shop?genre=Horror">Horror</a></h5>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="categories__item set-bg" data-setbg="../resources/img/categories/cat-2.jpg">
                                <h5><a href="shop?genre=Action">Action</a></h5>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="categories__item set-bg" data-setbg="../resources/img/categories/cat-3.jpg">
                                <h5><a href="shop?genre=Family">Family</a></h5>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="categories__item set-bg" data-setbg="../resources/img/categories/cat-4.jpg">
                                <h5><a href="shop?genre=Animation">Animation</a></h5>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="categories__item set-bg" data-setbg="../resources/img/categories/cat-5.jpg">
                                <h5><a href="shop?genre=Science">Science Fiction</a></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Categories Section End -->

        <!-- Featured Section Begin -->
        <section class="featured spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h2>Featured Movie</h2>
                        </div>
                        <div class="featured__controls">
                            <ul>
                                <li class="active" data-filter="*">All</li>
                                <li data-filter=".thriller">Thriller</li>
                                <li data-filter=".crime">Crime</li>
                                <li data-filter=".drama">Drama</li>
                                <li data-filter=".science-fiction">Science Fiction</li>
                                <li data-filter=".action">Action</li>
                                <li data-filter=".adventure">Adventure</li>
                                <li data-filter=".mystery">Mystery</li>
                                <li data-filter=".fantasy">Fantasy</li>
                                <li data-filter=".family">Family</li>
                                <li data-filter=".animation">Animation</li>
                                <li data-filter=".comedy">Comedy</li>
                                <li data-filter=".romance">Romance</li>
                                <li data-filter=".horror">Horror</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row featured__filter">
                    <c:forEach var="product" items="${ProductDAO.allProducts}" end="35">  
                        <c:set var="genres" value="${fn:replace(fn:replace(fn:toLowerCase(product.genres),' ', '-'),',', ' ')}" />
                        <div class="col-lg-3 col-md-4 col-sm-6 mix ${genres}">
                            <div class="featured__item">
                                <div class="featured__item__pic set-bg" data-setbg="${product.poster_path}">
                                    <ul class="featured__item__pic__hover">
                                        <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                        <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                        <li><a href="<c:url value='cart?&action=buy&id=${product.id}' />"><i class="fa fa-shopping-cart"></i></a></li>
                                    </ul>
                                </div>
                                <div class="featured__item__text">
                                    <h6><a href="product?id=${product.id}">${fn:substring(product.title, 0, 35)}</a></h6>
                                    <h5><fmt:formatNumber value="${product.price}" type="currency"/></h5>
                                </div>
                            </div>
                        </div>
                    </c:forEach>            
                </div>
            </div>
        </section>
        <!-- Featured Section End -->

        <!-- Banner Begin -->
        <div class="banner">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="banner__pic">
                            <img src="../resources/img/banner/banner-1.jpg" alt="">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="banner__pic">
                            <img src="../resources/img/banner/banner-2.jpg" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Banner End -->

        <!-- Latest Product Section Begin -->
        <section class="latest-product spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Latest Movies</h4>
                            <div class="latest-product__slider owl-carousel">
                                <div class="latest-prdouct__slider__item">
                                    <c:forEach var="product" items="${ProductDAO.allProducts}" begin="0" end="2">
                                        <c:set var="genres" value="${fn:replace(fn:replace(fn:toLowerCase(product.genres),' ', '-'),',', ' ')}" />
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
                                        <c:set var="genres" value="${fn:replace(fn:replace(fn:toLowerCase(product.genres),' ', '-'),',', ' ')}" />
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
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Top Rated Movies</h4>
                            <div class="latest-product__slider owl-carousel">
                                <div class="latest-prdouct__slider__item">
                                    <c:forEach var="product" items="${ProductDAO.allProducts}" begin="6" end="8">
                                        <c:set var="genres" value="${fn:replace(fn:replace(fn:toLowerCase(product.genres),' ', '-'),',', ' ')}" />
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
                                    <c:forEach var="product" items="${ProductDAO.allProducts}" begin="9" end="11">
                                        <c:set var="genres" value="${fn:replace(fn:replace(fn:toLowerCase(product.genres),' ', '-'),',', ' ')}" />
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
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Review Movies</h4>
                            <div class="latest-product__slider owl-carousel">
                                <div class="latest-prdouct__slider__item">
                                    <c:forEach var="product" items="${ProductDAO.allProducts}" begin="12" end="14">
                                        <c:set var="genres" value="${fn:replace(fn:replace(fn:toLowerCase(product.genres),' ', '-'),',', ' ')}" />
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
                                    <c:forEach var="product" items="${ProductDAO.allProducts}" begin="15" end="17">
                                        <c:set var="genres" value="${fn:replace(fn:replace(fn:toLowerCase(product.genres),' ', '-'),',', ' ')}" />
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
        </section>
        <!-- Latest Product Section End -->        
        <script src="../resources/js/custom/index.js"></script>
    </jsp:body>
</t:masterPage>
