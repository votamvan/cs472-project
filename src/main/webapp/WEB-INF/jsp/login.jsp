<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:masterPage>
    <jsp:attribute name="title">
        DVD SHOP - Login
    </jsp:attribute>
    <jsp:body>   
        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="../resources/img/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Login</h2>
                            <div class="breadcrumb__option">
                                <a href="/">Home</a>
                                <span>Login</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->   

        <!-- Login Form Begin -->
        <div class="login-form spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="login__form__title">
                            <h2>Login Form</h2>
                        </div>
                    </div>
                </div>
                <form action="login" method="POST">
                    <div class="row">
                        <div class="col-lg-3 col-md-3">
                            <label for="username">User Name</label>
                        </div>                    
                        <div class="col-lg-9 col-md-9">
                            <input type="text" id="username" name="username" placeholder="johnsmith" value="${cookie.username.value}" required title="Username is required" />
                        </div>
                        <div class="col-lg-3 col-md-3">
                            <label for="password">Password</label>
                        </div>                    
                        <div class="col-lg-9 col-md-9">
                            <input type="password" placeholder="********" id="password" name="password" required title="Password is required" />
                        </div>
                        <div class="col-lg-3 col-md-3">
                            <input type="checkbox" id="remember" name="remember" <c:if test = "${cookie.username != null}">checked</c:if>/>
                        </div>                    
                        <div class="col-lg-9 col-md-9">
                            <label for="remember">Remember me</label>
                        </div>                    
                        <div class="col-lg-12 text-center">
                            <button type="submit" class="site-btn">LOGIN</button>
                            <span>${message}</span>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- Login Form End -->
        <script src="../resources/js/custom/login.js"></script>
    </jsp:body>
</t:masterPage>
