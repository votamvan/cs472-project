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
            <div class="col-lg-9">
                <fieldset>
                    <div>
                        <label for="id">Id</label>
                        <input type="text" id="id" readonly="readonly" placeholder="Id auto-generated"/>
                    </div>
                    <div>
                        <label for="title">Title</label>
                        <input type="text" id="title" placeholder="Title" />
                    </div>
                    <div>
                        <label for="overview">Overview</label><br>
                        <textarea id="overview" rows="5" cols="80"></textarea>
                    </div>
                    <div>
                        <label for="genres">genres</label>
                        <input type="text" id="genres" placeholder="Genres" />
                    </div>
                    <div>
                        <label for="release_date">Release Date</label>
                        <input type="text" id="release_date" placeholder="Release Date" />
                    </div>
                    <div>
                        <label for="poster_path">Poster</label>
                        <input type="text" id="poster_path" placeholder="Poster" />
                    </div>
                    <div>
                        <label for="price">Price</label>
                        <input type="text" id="price" placeholder="Price" />
                    </div>
                    <div>
                        <input id="btn_add" type="submit" value="Add Product"/>
                    </div>
                    <span id="errmsg"></span>
                </fieldset>
                <br>
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
                                <td><button id="edit${item.id}" value="${item.id}">Edit</button></td>
                                <td><button id="del${item.id}" value="${item.id}">Delete</button></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
    $('table#tbl button').each(function(index, btn) {
        var id = btn.id;
        if (id.substring(0,3) == "del"){
            $("#" + id).click(del);
        }
    });
	$('#btn_add').click(add);
	function add(){
        var title = $('#title').val();
        var overview = $('#overview').val();
        var genres = $('#genres').val();
        var release_date = $('#release_date').val();
		var poster_path = $('#poster_path').val();
		var price = $('#price').val();
		var item = {title:title, overview:overview, genres:genres, 
                    release_date:release_date, poster_path:poster_path, price:price};
        console.log(item);
		$.post('/admin/product',{product: JSON.stringify(item)}, processData, "json")
	}
	function processData(data){
        console.log(data);
        if (data.id <= 0){
            $("#errmsg").text("Product exist or insert error !!!");
            return;
        }
        $("#errmsg").text("");
        var id = data.id;
        var row_data = "<tr id=row" + id + ">"
                        + "<td><img src='" + data.poster_path + "' width='100px' height='100px'></td>"
                        + "<td>" + id + "</td>"
                        + "<td>" + data.title + "</td>"
                        + "<td>" + data.overview + "</td>"
                        + "<td>" + data.genres + "</td>"
                        + "<td>" + data.release_date + "</td>"
                        + "<td>" + data.price + "</td>"
                        + "<td><button id=edit" + data.id + " value=" + data.id + ">Edit</button></td>"
                        + "<td><button id=del" + data.id + " value=" + data.id + ">Delete</button></td>"
                        + "</tr>";
		$('#tbl>tbody').append(row_data);
        $("button#del" + id).click(del);
	}
    function del(){
        var id = this.value;
        console.log(id);
        $('#row' + id).remove();
		$.ajax({type:'DELETE', url:'/admin/product?id=' + id, success:processDel});
        function processDel(data){
            console.log(data);
        }
    }
});
</script>
<!-- Hero Section End -->
    </jsp:body>
</t:adminPage>