<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.*" %>
<fmt:setLocale value="en_US"/>
<t:adminPage>
    <jsp:attribute name="title">
        MIU-DVD SHOP - Admin Home Page
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
                    <div class="col-lg-9 product-mgmt">
                        <div class="section-title">
                            <h3>Product Information</h3>
                            <hr/>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="id">Id</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="id" readonly="readonly" placeholder="Id auto-generated"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="title">Title</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="title" placeholder="Title" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="overview">Overview</label>
                            </div>
                            <div class="col-lg-8">
                                <textarea id="overview" rows="5" cols="40"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="genres">Genres</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="genres" placeholder="Seperated by a comma" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="release_date">Release Date</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="release_date" placeholder="MM/DD/YY" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="poster_path">Poster</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="poster_path" placeholder="Poster URL: http://example.com/poster.jpg " />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="price">Price</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="price" placeholder="##" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 text-right">
                                <input class="btn btn-primary" id="btn_add" type="submit" value="Add Product"/>
                                <input class="btn btn-info" id="btn_edit" type="submit" value="Update Product"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 text-center"><span id="errmsg"></span></div>
                        </div>                       
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

        <!-- Product List Section Begin -->
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="user-mngt__table">
                            <table id="tbl">
                                <thead>
                                    <tr>
                                        <th>Poster</th>
                                        <th>Id</th>
                                        <th>Title</th>
                                        <th>Overview</th>
                                        <th>Genres</th>
                                        <th>Release Date</th>
                                        <th>Price</th>
                                        <th>Update</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${products}" var="item">
                                        <tr id="row${item.id}">
                                            <td><img src="${item.poster_path}" width="100px" height="100px"></td>
                                            <td><c:out value="${item.id}" /></td>
                                            <td><c:out value="${item.title}" /></td>
                                            <td><c:out value="${item.overview}" /></td>
                                            <td><c:out value="${item.genres}" /></td>
                                            <td><c:out value="${item.release_date}" /></td>
                                            <td><c:out value="${item.price}" /></td>
                                            <td><button class="btn-info" id="edit${item.id}" value="${item.id}">Update</button></td>
                                            <td><button class="btn-warning" id="del${item.id}" value="${item.id}">Delete</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->
        <script src="../resources/js/custom/admin/product.js"></script>
    </jsp:body>
</t:adminPage>