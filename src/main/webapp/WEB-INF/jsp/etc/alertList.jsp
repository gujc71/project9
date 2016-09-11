<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="js/jquery-2.2.3.min.js"></script>
	<script src="js/jquery-ui.js"></script>
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
	<script src="js/project9.js"></script>    

<script>
function fn_formSubmit(){
	document.form1.submit();	
}

</script>
    
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-bell fa-fw"></i> <s:message code="common.alert"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="panel panel-default">
            	<div class="panel-body">
					<div class="listHead">
						<div class="listHiddenField pull-right field60"><s:message code="common.like"/></div>
						<div class="listHiddenField pull-right field60"><s:message code="board.hitCount"/></div>
						<div class="listHiddenField pull-right field130"><s:message code="board.date"/></div>
						<div class="listHiddenField pull-right field100"><s:message code="board.writer"/></div>
						<div class="listTitle"><s:message code="board.title"/></div>
					</div>
					
					<c:forEach var="listview" items="${listview}" varStatus="status">
						<c:url var="link" value="boardRead">
							<c:param name="brdno" value="${listview.brdno}" />
						</c:url>
					
						<div class="listBody">
							<div class="listHiddenField pull-right field60"><c:out value="${listview.brdlike}"/></div>
							<div class="listHiddenField pull-right field60 textCenter"><c:out value="${listview.brdhit}"/></div>
							<div class="listHiddenField pull-right field130 textCenter"><c:out value="${listview.brddate}"/></div>
							<div class="listHiddenField pull-right field100 textCenter"><a href="boardList?bgno=<c:out value="${searchVO.bgno}"/>&searchExt1=<c:out value="${listview.userno}"/>"><c:out value="${listview.brdwriter}"/></a></div>
							<div class="listTitle" title="<c:out value="${listview.brdtitle}"/>">
								<div class="pull-left field30">
							    	<i class="fa fa-<c:out value="${listview.extfield1}"/> fa-fw"></i> 
								</div>
							
								<a href="${link}" <c:if test="${listview.brdnotice=='Y'}">class="notice"</c:if>><c:out value="${listview.brdtitle}"/></a>
								<c:if test="${listview.replycnt>0}">
									(<c:out value="${listview.replycnt}"/>)
								</c:if>								
							</div>
							<div class="showField text-muted small col-lg-12">
								<c:out value="${listview.brdwriter}"/> 
								<c:out value="${listview.brddate}"/>
								<i class="fa fa-eye fa-fw"></i> <c:out value="${listview.brdhit}"/>
								<i class="fa fa-thumbs-o-up fa-fw"> <c:out value="${listview.brdlike}"/></i>
							</div>
						</div>
					
					</c:forEach>	
					<br/>

            	</div>    
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>
