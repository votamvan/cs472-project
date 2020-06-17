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
                    <div class="col-lg-9 user-mngt-info">
                        <div class="section-title">
                            <h3>User Information</h3>
                            <hr/>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="id">User ID</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="id" readonly="readonly" placeholder="ID auto-generated"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="fullname">Full Name</label>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="fullname" placeholder="Full Name" required pattern="[a-zA-Z0-9\s]{3,100}" title="Fullname is required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="username">User Name</label> 
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="username" placeholder="User Name" required pattern="[a-zA-Z]{5,32}" title="Username is required"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <label for="password">Password</label> 
                            </div>
                            <div class="col-lg-8">
                                <input type="text" id="password" placeholder="Password" required/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 text-right">
                                <input class="btn btn-primary" id="btn_add" type="submit" value="Add User" />
                                <input class="btn btn-info" id="btn_edit" type="submit" value="Edit User" />
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


        <!-- User List Section Begin -->
        <section class="user-mngt spad">
            <div class="container">
                <div class="row">                
                    <div class="col-lg-12">
                        <div class="user-mngt__table">
                            <table id="tbl">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Full Name</th>
                                        <th>User Name</th>
                                        <th>Password</th>
                                        <th>Update</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${users}" var="item">
                                        <tr id="row${item.id}">
                                            <td><c:out value="${item.id}" /></td>
                                            <td><c:out value="${item.fullname}" /></td>
                                            <td><c:out value="${item.username}" /></td>
                                            <td><c:out value="${item.password}" /></td>
                                            <td><button class="btn-info" id="edit${item.id}" value="${item.id}">Update</button></td>
                                            <td><button class="btn-warning" id="del${item.id}" value="${item.id}">Delete</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                    </div>
                </div>
            </div>
        </section>
        <!-- User List Section Begin -->
        <script src="../resources/js/custom/admin/user.js"></script>
    </jsp:body>
</t:adminPage>