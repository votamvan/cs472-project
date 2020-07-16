<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:masterPage>
    <jsp:attribute name="title">
        DVD SHOP - Sign Up
    </jsp:attribute>
    <jsp:body>   
        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="../resources/img/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Sign Up</h2>
                            <div class="breadcrumb__option">
                                <a href="/">Home</a>
                                <span>Sign Up</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->   

        <!-- Sign Up Form Begin -->
        <div class="signup-form spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="signup__form__title">
                            <h2>Sign Up Form</h2>
                        </div>
                    </div>
                </div>
                <form action="signup" method="POST">
                    <div class="row">
                        <div class="col-lg-3 col-md-3">
                            <label for="fullname">Full Name</label>
                        </div>                    
                        <div class="col-lg-9 col-md-9">
                            <input type="text" id="fullname" name="fullname" placeholder="John Smith" required/>
                        </div>
                        <div class="col-lg-3 col-md-3">
                            <label for="username">User Name</label>
                        </div>                    
                        <div class="col-lg-9 col-md-9">
                            <input type="text" id="username" name="username" placeholder="johnsmith" required/>
                        </div>
                        <div class="col-lg-3 col-md-3">
                            <label for="password">Password</label>                            
                        </div>                                           
                        <div class="col-lg-9 col-md-9">
                            <input type="password" placeholder="********" id="password" name="password" required/>
                        </div>
                        <div class="col-lg-12 text-right">
                            <span id="pwd_info"></span>
                        </div> 
                        <div class="col-lg-3 col-md-3">
                            <label for="password2">Retype Password</label>
                        </div>                    
                        <div class="col-lg-9 col-md-9">
                            <input type="password" placeholder="********" id="password2" name="password2" required/>
                        </div>                                 
                        <div class="col-lg-12 text-center">
                            <button type="submit" class="site-btn">SIGN UP</button>
                            <span><c:out value="${message}"/></span>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- Sign Up Form End -->
        <script src="../resources/js/custom/signup.js"></script>
    </jsp:body>
</t:masterPage>
