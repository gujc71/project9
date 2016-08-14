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
	<link href="js/dynatree/ui.dynatree.css" rel="stylesheet" id="skinSheet"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="js/jquery-2.2.3.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/dynatree/jquery.dynatree.js"></script>    
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
	<script src="js/project9.js"></script>    
<script>


function fn_formSubmit(){
	document.form1.submit();	
}

function showBoardList(ev){
	if( $('#boardlistDiv').is(':visible') ) {
		$("#boardlistDiv").hide();
		return;
	}
	var offset = $( "#boardlistBtn" ).offset();
	$("#boardlistDiv").css({
		   "top" : parseInt(offset.top)+30 + "px",
		   "left" : offset.left
	}).show();
	
	var node = $("#tree").dynatree("getRoot");
	
	if (node.childList) return;
	
	$.ajax({
		url: "boardListByAjax",
		type:"post", 
		dataType: "json",
		success: function(result){
			$("#tree").dynatree({children: result});
		    $("#tree").dynatree("getTree").reload();
		    $("#tree").dynatree("getRoot").visit(function(node){
		        node.expand(true);
		    });
		}
	})	
	
}

$(function(){
	$("#tree").dynatree({
		onActivate: TreenodeActivate
	});
});

function TreenodeActivate(node) {
	location.href = "boardList?bgno=" + node.data.key;
}

</script>
    
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-files-o fa-fw"></i> <s:message code="board.boardName"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
	                <button id="boardlistBtn" type="button" class="btn btn-default" onclick="showBoardList()"><i class="fa  fa-files-o fa-fw"></i> 전체</button>      
	                <div id="boardlistDiv" style="width: 250px; height:300px; display: none;" class="popover fade bottom in" role="tooltip">
	                	<div style="left:15%;" class="arrow"></div>
	                	<div class="popover-content">
             				<div id="tree"></div>	
	                	</div>
	                </div>
            </div>
            <!-- /.row -->
            <div class="row">
				<div class="table-responsive">
					 <table class="table table-striped table-bordered table-hover">
						<colgroup>
							<col width='8%' />
							<col width='*%' />
							<col width='15%' />
							<col width='15%' />
							<col width='10%' />
							<col width='10%' />
							<col width='10%' />
						</colgroup>
						<thead>
							<tr>
								<th><s:message code="board.no"/></th> 
								<th><s:message code="board.title"/></th>
								<th><s:message code="board.writer"/></th>
								<th><s:message code="board.date"/></th>
								<th><s:message code="board.hitCount"/></th>
								<th><s:message code="board.attach"/></th>
								<th><s:message code="board.locate"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="listview" items="${listview}" varStatus="status">	
								<c:url var="link" value="boardRead">
									<c:param name="brdno" value="${listview.brdno}" />
								</c:url>		
														  				
								<tr>
									<td style="text-align:center"><c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/></td>
									<td>
										<a href="${link}"><c:out value="${listview.brdtitle}"/></a>
										<c:if test="${listview.replycnt>0}">
											(<c:out value="${listview.replycnt}"/>)
										</c:if>						
									</td>
									<td><a href="boardList?bgno=<c:out value="${searchVO.bgno}"/>&searchExt1=<c:out value="${listview.userno}"/>"><c:out value="${listview.brdwriter}"/></a></td>
									<td style="text-align:center"><c:out value="${listview.brddate}"/></td>
									<td style="text-align:center"><c:out value="${listview.brdhit}"/></td>
									<td style="text-align:center"><c:out value="${listview.filecnt}"/></td>
									<td><a href="boardList?bgno=<c:out value="${listview.bgno}"/>"><c:out value="${listview.bgname}"/></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<form role="form" id="form1" name="form1"  method="post">
					    <jsp:include page="../common/pagingforSubmit.jsp" />
				    
						<div class="form-group">
							<div class="checkbox col-lg-3 ">
							 	<!-- label>
		                        	<input type="checkbox" name="searchType" value="brdwriter" <c:if test="${fn:indexOf(searchVO.searchType, 'brdwriter')!=-1}">checked="checked"</c:if>/>
		                        	<s:message code="board.writer"/>
		                        </label -->
							 	<label class="pull-right">
		                        	<input type="checkbox" name="searchType" value="brdtitle" <c:if test="${fn:indexOf(searchVO.searchType, 'brdtitle')!=-1}">checked="checked"</c:if>/>
		                        	<s:message code="board.title"/>
		                        </label>
							 	<label class="pull-right">
		                        	<input type="checkbox" name="searchType" value="brdmemo" <c:if test="${fn:indexOf(searchVO.searchType, 'brdmemo')!=-1}">checked="checked"</c:if>/>
		                        	<s:message code="board.contents"/>
		                        </label>
		                   </div>
		                   <div class="input-group custom-search-form col-lg-3">
	                                <input class="form-control" placeholder="Search..." type="text" name="searchKeyword" 
	                                	   value='<c:out value="${searchVO.searchKeyword}"/>' >
	                                <span class="input-group-btn">
	                                <button class="btn btn-default" onclick="fn_formSubmit()">
	                                    <i class="fa fa-search"></i>
	                                </button>
	                            </span>
	                       </div>
						</div>
					</form>	
            	</div>    
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>
