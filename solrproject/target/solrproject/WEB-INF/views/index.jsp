<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Solr auto complete</title>
<link
 href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
 rel="stylesheet"></link>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
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
</head>
<body>
 <div>
 <p>Type The or A</p>
 <label for="searchBox">Tags: </label> <input id="searchBox"></input>
 </div>
</body>
</html>