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
	<script src="js/project9.js"></script>    
<script>
function fn_formSubmit(){
	if ( ! chkInputValue("#searchKeyword", "<s:message code="common.keyword"/>")) return false;
	
	$("#form1").submit();
}
</script>
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-users fa-fw"></i> <s:message code="memu.users"/></h1>
                </div>
            </div>
            
            <!-- /.row -->
            <div class="row">
				<form role="form" id="form1" name="form1"  method="post">
					<div class="form-group">
						<div class="checkbox col-lg-4">
							<s:message code="msg.page.inputName"/>
	                   	</div>
	                   	<div class="input-group custom-search-form col-lg-3">
                        	<input class="form-control" placeholder="Search..." type="text" id="searchKeyword" name="searchKeyword" 
                                	   value='<c:out value="${searchVO.searchKeyword}"/>' >
                            <span class="input-group-btn">
                            <button class="btn btn-default" onclick="fn_formSubmit()"><i class="fa fa-search"></i></button>
                            </span>
                       	</div>
					</div>
				</form>	
            </div>
            
            <!-- /.row -->
            <div class="row">
					 <table class="table table-striped table-bordered table-hover">
						<colgroup>
							<col width='10%' />
							<col width='25%' />
							<col width='25%' />
							<col width='20%' />
						</colgroup>
						<thead>
							<tr>
								<th><s:message code="board.no"/></th> 
								<th><s:message code="common.id"/></th>
								<th><s:message code="common.name"/></th>
								<th><s:message code="common.deptName"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="listview" items="${listview}" varStatus="status">	
								<tr>
									<td><c:out value="${status.index+1}"/></td>
									<td><c:out value="${listview.userid}"/></td>
									<td><c:out value="${listview.usernm}"/></td>
									<td><c:out value="${listview.deptno}"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>            	
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>
