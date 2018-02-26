
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
	padding-left: 0px;
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
	position: relative;
	left: 100px;
	height: 100%;
}

a {
	text-decoration: none;
	cursor: pointer;
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

</head>
<body>


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
				onclick="sendSearchText(); return false;">Submit</button>
		</form>

	</div>
	<!-- search box end -->

	<hr>



	<div class="container-fluid">
		<div class="row content">

			<!--  facets start-->
			<div class="col-sm-2 sidenav">

				<div id="cat">
					<ul style="list-style-type: none" id="categories">
						
					</ul>
				</div>
			</div>
			<!-- facets end -->


			<!-- products list start -->
			<div class="col-sm-8 text-left products">

				<div id="sizeP"></div>
				<div id="productsList"></div>

			</div>
			<!-- products list end -->
		</div>
	</div>

	<script>
		//var hosturl = window.location.hostname;
		var URL = window.location.href+"search";
		var count = 0;
		var URL1 = window.location.href+count++;
		var searchText = document.getElementById("searchBox").value;
		console.log("search : "+searchText)
		function sendSearchText() {
			
			console.log("Hello");
			console.log(URL);

			var searchText = document.getElementById("searchBox").value;
			console.log("search : "+searchText)
			
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				
				if (this.readyState == 4 && this.status == 200) {
					response = JSON.parse(this.responseText);
					sizeProducts = response.size;
					
					if (sizeProducts > 1) {
						document.getElementById("sizeP").innerHTML = '<p><h3>'
								+ sizeProducts
								+ ' Products Found</h3></p><br><br>';
						displayProducts();
						displayCategory();
					} else {
						document.getElementById("sizeP").innerHTML = '<p><h3>'
								+ sizeProducts
								+ ' Product Found</h3></p><br><br>';
						displayProducts();
						displayCategory();
					}

				}

				else if (this.status == 500) {
					document.getElementById("sizeP").innerHTML = '<p><h3>No Products Found</h3></p><br><br>';
					document.getElementById("productsList").innerHTML = '';
					document.getElementById("categories").innerHTML='';
				}
			};
			xhttp.open("POST", URL, true);
			xhttp.setRequestHeader('Content-Type', 'text/plain');
			xhttp.send(searchText);
		}

		function displayProducts() {

			var select = document.getElementById("productsList");
			select.innerHTML = "";

			for ( var key in response.productList) {

				select.style.visibility = 'visible';
				var image = response.productList[key].image_small;
				select.innerHTML += '<p><a href="#" id="largeimage" onclick="displayImageLarge(this)";>'
						+'<img src='+image+' width="90" height="90" align="left" border="1 solid black" hspace="20" ></img></a>'
						+ '<span style="color:#00cccc;" id="productid"><a href="productDetails.jsp" id="detailed" onclick="displaydetails(this)";>'
						+ response.productList[key].product_id
						+ '</a></span>&nbsp;&nbsp;'
						+ response.productList[key].description
						+ '</a><br><br>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do'
						+ 'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'
						+ 'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p><hr>';

			}

		}

		function displayCategory() {

			var select = document.getElementById("categories");
			select.innerHTML = "";
			
			for ( var key in response.categoryList) {

				select.style.visibility = 'visible';
				var catname = response.categoryList[key].name;
				var catsize = response.categoryList[key].size;
				
				if(catsize>0){
					select.innerHTML += "<li><a href='#' id='cathref' onclick='return categorySet(this)';>"
						+ catname + "</a>("
						+ catsize + ")" + "</li>";
				}	
			}
		}
	
	
		function categorySet(obj) {

			var name = obj.innerHTML;	
			var search = document.getElementById("searchBox").value;
			console.log("Hiii......");
			console.log(window.location.href);
			xhttp = new XMLHttpRequest();
			
			xhttp.onreadystatechange = function() {
				
				if (this.readyState == 4 && this.status == 200) {
					response = JSON.parse(this.responseText);
					
					sizeProducts = response.size;
					if (sizeProducts > 1) {
						document.getElementById("sizeP").innerHTML = '<p><h3>'
								+ sizeProducts
								+ ' Products Found</h3></p><br><br>';
						displayProducts();
						displayCategory();
					} else {
						document.getElementById("sizeP").innerHTML = '<p><h3>'
								+ sizeProducts
								+ ' Product Found</h3></p><br><br>';
						displayProducts();
						displayCategory();
					}

				}
				
				else if (this.status == 500) {
					document.getElementById("sizeP").innerHTML = '<p><h3>No Products Found</h3></p><br><br>';
					document.getElementById("productsList").innerHTML = '';
				}
				
				name = null;
				
			};
		
			xhttp.open("GET", URL1 + "/" + search + "/" + name, true);
			xhttp.send();
	
		}
		
		function displayImageLarge(obj){
			
			console.log(obj.innerHTML);
			//details = details.substring(0,details.indexOf("prod"))
			//console.log(document.getElementById("productid").innerHTML)
		}
		
		function displaydetails(obj){
			console.log(obj.innerHTML);
			
		}
		
	
	</script>
</body>
</html>