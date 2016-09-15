<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><s:message code="common.pageTitle"/></title>
    <link href="css/sb-admin/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin/metisMenu.min.css" rel="stylesheet">
    <link href="css/sb-admin/sb-admin-2.css" rel="stylesheet">
    <link href="css/sb-admin/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css/sb-admin/morris.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
    <script src="css/sb-admin/raphael-min.js"></script>
    <script src="css/sb-admin/morris.min.js"></script>    
	<script src="js/project9.js"></script>
<script>
window.onload = function() {
    Morris.Bar({
        element: 'morris-bar-chart',
        data: [
           	<c:forEach var="listview" items="${listview}" varStatus="status">
	            {x: '<c:out value="${listview.field1}"/>', y: <c:out value="${listview.cnt1}"/>}<c:if test="${!status.last}">,</c:if> 
    		</c:forEach>
              ],
        xkey: 'x',
        ykeys: 'y',
        labels: 'Count',
        resize: true
    });
    Morris.Donut({
        element: 'morris-donut-chart',
        data: [
              	<c:forEach var="listview" items="${listview}" varStatus="status">
              		{label: "<c:out value="${listview.field1}"/>",value: <c:out value="${listview.cnt1}"/>}<c:if test="${!status.last}">,</c:if>
	    		</c:forEach>
              ],
        resize: true
    });
}
</script>  
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">샘플 3: 챠트</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
				<div class="col-lg-5">
                	<div id="morris-bar-chart"></div>
                </div>
                
				<div class="col-lg-5">
                	<div id="morris-donut-chart"></div>
                </div>
            </div>
            <!-- /.row -->
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
</body>

</html>
