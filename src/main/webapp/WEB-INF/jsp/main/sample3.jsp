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
///////////////////////
function fn_showCode(id){
    $(id).modal("show");
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
                	
                    <button class="btn btn-default" type="button" onclick="fn_showCode('#popupCodeBar')" title="코드 보기">
                        <i class="fa fa-code"></i> 코드 보기
                    </button>                	
                </div>
                
				<div class="col-lg-5">
                	<div id="morris-donut-chart"></div>
                	
                    <button class="btn btn-default" type="button" onclick="fn_showCode('#popupCodeDonut')" title="코드 보기">
                        <i class="fa fa-code"></i> 코드 보기
                    </button>                	
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
    
    <div id="popupCodeBar" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
             <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header"> 
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button> 
                    <h4 class="modal-title" id="mySmallModalLabel">필요 코드</h4> 
                </div>             
                <div class="modal-body">
                    <!-- /.row -->
                    <div class="row">
                        <pre style="height:200px">
    &lt;link href="css/sb-admin/morris.css" rel="stylesheet"&gt;
    &lt;script src="css/sb-admin/raphael-min.js"&gt;&lt;/script&gt;    
    &lt;script src="css/sb-admin/morris.min.js"&gt;&lt;/script&gt;    
&lt;script&gt;
window.onload = function() {
    Morris.Bar({
        element: 'morris-bar-chart',
        data: [
	            {x: '자료실', y: 19}, 
	            {x: 'QnA', y: 25}, 
	            {x: '일반게시판', y: 51} 
              ],
        xkey: 'x',
        ykeys: 'y',
        labels: 'Count',
        resize: true
    });
}
&lt;/script&gt;                       
                        </pre>  
                        <pre>
  &lt;div id="morris-bar-chart"&gt;&lt;/div&gt;
                        </pre> 
                    </div>
                    <!-- /.row -->                
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close"><s:message code="common.btnClose"/></button>
                </div>
            </div>
          </div>
    </div> 
    
    <div id="popupCodeDonut" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
             <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header"> 
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button> 
                    <h4 class="modal-title" id="mySmallModalLabel">필요 코드</h4> 
                </div>             
                <div class="modal-body">
                    <!-- /.row -->
                    <div class="row">
                        <pre style="height:200px">
    &lt;link href="css/sb-admin/morris.css" rel="stylesheet"&gt;
    &lt;script src="css/sb-admin/raphael-min.js"&gt;&lt;/script&gt;
    &lt;script src="css/sb-admin/morris.min.js"&gt;&lt;/script&gt;    
&lt;script&gt;
window.onload = function() {
    Morris.Donut({
        element: 'morris-donut-chart',
        data: [
	            {label: '자료실', value: 19}, 
	            {label: 'QnA', value: 25},
	            {label: '일반게시판', value: 51} 
              ],
        resize: true
    });
}
&lt;/script&gt;                       
                        </pre>  
                        <pre>
  &lt;div id="morris-donut-chart"&gt;&lt;/div&gt;
                        </pre> 
                    </div>
                    <!-- /.row -->                
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close"><s:message code="common.btnClose"/></button>
                </div>
            </div>
          </div>
    </div>              
</body>

</html>
