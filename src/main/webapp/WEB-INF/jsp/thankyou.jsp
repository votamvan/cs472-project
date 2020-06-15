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
        MIU-DVD SHOP - Thank You
    </jsp:attribute>
    <jsp:body>   
        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="../resources/img/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Thank You</h2>
                            <div class="breadcrumb__option">
                                <a href="/">Home</a>
                                <span>Thank You</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End --> 

        <!-- Confirmation Section Start -->
        <div class="confirm-form spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="confirm__form__title">
                            <c:if test="${user != null}">
                                <h2>Thank you <strong>${user.username}</strong> for shopping</h2>
                            </c:if>
                        </div>
                        <div class="col-lg-12 text-center">
                            <p>Your confirmation id of your order is 8888PNKME3333EEEEddddPPPPP</p>
                        </div>
                    </div>
                </div>
                
                <div class="row">                    
                    <div class="col-lg-12 text-center">                        
                        <button type="button" class="site-btn" onclick="return document.location='/'">Continue Shopping</button>
                        <button type="button" class="site-btn" onclick="return document.location='logout'">Logout</button>
                    </div>
                </div>
                
            </div>
        </div>        
        <!-- Confirmation Section End -->
    </jsp:body>
</t:masterPage>