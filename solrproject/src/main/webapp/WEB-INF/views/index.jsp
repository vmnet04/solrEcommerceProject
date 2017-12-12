<!DOCTYPE html>
<%@ page import="com.mindtree.entity.Products"%>
<%@ page import="com.mindtree.entity.Categories"%>
<%@ page import="java.util.ArrayList"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Ecommerce</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link
	href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet"></link>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<style>
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

.row.content {
	height: 450px
}

.sidenav {
	padding-top: 20px;
	background-color: #f1f1f1;
	height: 100%;
}

footer {
	background-color: #555;
	color: white;
	padding: 15px;
}

@media screen and (max-width: 767px) {
	.sidenav {
		height: auto;
		padding: 15px;
	}
	.row.content {
		height: auto;
	}
}

input[type=text] {
	width: 35%;
	box-sizing: border-box;
	border: 2px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
	background-color: white;
	background-position: 10px 10px;
	background-repeat: no-repeat;
	padding: 12px 20px 12px 40px;
}

#btn_submit {
	width: 130px;
	box-sizing: border-box;
	border-radius: 4px;
	font-size: 16px;
	background-color: #4CAF50;
	background-position: 10px 10px;
	background-repeat: no-repeat;
	padding: 12px 20px 12px 40px;
}

#btn_submit:hover {
	background-color: #45a049;
}

.products {
	position: fixed;
	left: 350px;
	height: 100%;
}
</style>
<script>
	$(function() {
		var URL_PREFIX = "http://localhost:8983/solr/select?q=text:";
		var URL_SUFFIX = "&wt=json";
		$("#searchBox").autocomplete({
			source : function(request, response) {
				var URL = URL_PREFIX + $("#searchBox").val() + URL_SUFFIX;
				$.ajax({
					url : URL,
					success : function(data) {
						var docs = JSON.stringify(data.response.docs);
						var jsonData = JSON.parse(docs);
						response($.map(jsonData, function(value, key) {
							return {
								label : value.name
							}
						}));
					},
					dataType : 'jsonp',
					jsonp : 'json.wrf'
				});
			},
			minLength : 1
		})
	});
</script>
<script>
	$(document).ready(function() {
		$("#searchBox").focus(function() {
			$(this).css("background-color", "#cccccc");
		});
		$("#searchBox").blur(function() {
			$(this).css("background-color", "#ffffff");
		});
	});
</script>

<script>
	var hosturl = window.location.hostname;
	var URL = "http://localhost:7009/solrproject/search";

	function sendSearchText() {
		var currentURL = window.location.href;

		console.log(hosturl);
		console.log("Hello");

		var searchText = document.getElementById("searchBox").value;
		console.log(searchText);
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			consolr.log(this.readyState);
			console.log(this.status);
			if (this.readyState == 4 && this.status == 200) {
				response = this.responseText;
				//console.log(response);
			}
		};
		xhttp.open("POST", URL, true);
		xhttp.setRequestHeader('Content-Type', 'text/plain');
		xhttp.send(searchText);
	}
</script>
<script>
	var URL1 = "http://localhost:7009/solrproject/1";
	function categorySet(name, search) {

		var currentURL = window.location.href;

		console.log("Hiii......");

		if (search != null) {
			console.log(name);
			console.log(search);
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				console.log(this.readyState);
				console.log(this.status);
				if (this.readyState == 4 && this.status == 200) {
					response = this.responseText;
					//console.log(response);
				}
			};
			xhttp.open("GET", URL1 + "/" + search + "/" + name, true);
			//xhttp.setRequestHeader('Content-Type', 'text/plain');
			xhttp.send();
		}

		else {
			alert(name);
			search1 = "*:*"
			alert(search1);
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				alert(this.readyState);
				alert(this.status);
				if (this.readyState == 4 && this.status == 200) {
					response = this.responseText;
					alert(response);
				}
			};
			xhttp.open("GET", URL1 + "/" + search1+ "/" + name, true);
			//xhttp.setRequestHeader('Content-Type', 'text/plain');
			xhttp.send();
		}
	}
</script>
</head>
<body>

	<%!String searchText;
	ArrayList<Categories> catList;
	ArrayList<Products> productList;
	Long size1;%>

	<%
		searchText = (String) session.getAttribute("searchText");
		catList = (ArrayList<Categories>) session.getAttribute("catList");
		productList = (ArrayList<Products>) session.getAttribute("productList");
		size1 = (Long) session.getAttribute("size1");
		//session.setAttribute("searchText",searchText);
	%>

	<!--  nav beginning -->

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Logo</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#">About</a></li>
					<li><a href="#">Projects</a></li>
					<li><a href="#">Contact</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="glyphicon glyphicon-log-in"></span>
							Login</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- nav end  -->
	<br>
	<br>
	<!-- search box start -->
	<div class="container-fluid search">

		<form method="POST">
			<input type="text" id="searchBox" name="search"
				placeholder="Search..">
			<!-- onKeypress="return sendText(event)" -->
			<!--  <input type="submit" id="btn_submit" value = "submit" >-->
			<button type="submit" id="btn_submit" value="submit"
				onclick="sendSearchText()">Submit</button>
		</form>

	</div>
	<!-- search box end -->

	<hr>


	<!-- facets -->
	<div class="container-fluid">
		<div class="row content">
			<div class="col-sm-2 sidenav">

				<!-- category list starts ${context}/1/${cat.name}-->

				<c:choose>
					<c:when test="${searchText == null}">
						<c:forEach items="${categories}" var="cat">
							<c:set var="context" value="${request.getRequestUri()}" />
							<a href="#" onclick="categorySet('${cat.name}')"><c:out
									value="${cat.name}"></c:out>(<c:out value="${cat.size}"></c:out>)</a>
							<br>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach items="${catList}" var="cat">
							<a href="#" onclick="categorySet('${cat.name}','${searchText}')"><c:out
									value="${cat.name}"></c:out>(<c:out value="${cat.size}"></c:out>)</a>
							<br>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<!-- category ends -->

			</div>
			<!-- facets list end -->

			<%
			searchText = (String) session.getAttribute("searchText");
		productList = (ArrayList<Products>) session.getAttribute("productList");
		size1 = (Long) session.getAttribute("size1");
		
	%>
			<!-- products details -->
			<div class="col-sm-8 text-left products">

				<!-- size -->
				<c:choose>
					<c:when test="${searchText == null }">
						<h2 id="size">${size}&nbsp;found</h2>
					</c:when>
					<c:otherwise>
						<h2 id="size">${size1}&nbsp;found</h2>
					</c:otherwise>
				</c:choose>
				<!-- size ends -->

				<!-- list start -->
				<c:choose>
					<c:when test="${searchText == null}">
						<c:forEach items="${products}" var="list">
							<a href=#><img src='<c:url value="C:${list.image_small}"/>' /></a>
							<c:out value="${list.product_id }"></c:out>&nbsp;&nbsp;<c:out
								value="${list.create_date}"></c:out>
							<br>
							<c:out value="${list.name}"></c:out>
							<br>
							<c:out value="${list.description}"></c:out>
							<br>
							<br>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach items="${productList}" var="list">
							<a href=#><img src='<c:url value="C:${list.image_small}"/>' /></a>
							<c:out value="${list.product_id }"></c:out>&nbsp;&nbsp;<c:out
								value="${list.create_date}"></c:out>
							<br>
							<c:out value="${list.name}"></c:out>
							<br>
							<c:out value="${list.description}"></c:out>
							<br>
							<br>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<!--  list end  -->
			</div>
			<!-- products list end -->
		</div>
	</div>


</body>
</html>