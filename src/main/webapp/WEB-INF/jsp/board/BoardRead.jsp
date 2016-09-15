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
	if ( ! chkInputValue("#rememo1", "<s:message code="board.contents"/>")) return;
	
	$.ajax({
		url: "boardReplySave", 
		dataType: "html",
		type:"post", 
		data : {brdno:$("#brdno").val(), rememo: $("#rememo1").val()},
		success: function(result){
			if (result!=="") {
				$("#rememo1").val("");
				$("#replyList").append(result);
				alert("<s:message code="msg.boardSave"/>");
			} else{
				alert("<s:message code="msg.err.server"/>");
			}
		}
	})		
}

function fn_replyDelete(reno){
	if (!confirm("<s:message code="ask.Delete"/>")) {
		return;
	}
	$.ajax({
		url: "boardReplyDelete",
		type:"post", 
		data: {"reno": reno},
		success: function(result){
			if (result=="OK") {
				$("#replyItem"+reno).remove();
				alert("<s:message code="msg.boardDelete"/>");
			} else
			if (result=="Fail") {
				alert("<s:message code="msg.err.delete4reply"/>");
			} else {
				alert("<s:message code="msg.err.delete4error"/>");
			}
		}
	})
}

var updateReno = updateRememo = null;
function fn_replyUpdate(reno){
	hideDiv("#replyDialog");
	
	if (updateReno) {
		$("#replyDiv").appendTo(document.body);
		$("#reply"+updateReno).text(updateRememo);
	} 
	updateReno   = reno;
	updateRememo = $("#reply"+reno).html();
	
	$("#reno2").val(reno);
	$("#rememo2").val( html2Text(updateRememo) );
	$("#reply"+reno).text("");
	$("#replyDiv").appendTo($("#reply"+reno));
	$("#replyDiv").show();
	$("#rememo2").focus();
} 

function fn_replyUpdateSave(){
	if ( ! chkInputValue("#rememo2", "<s:message code="board.contents"/>")) return;
	
	$.ajax({
		url: "boardReplySave", 
		type:"post", 
		data : {brdno:$("#brdno").val(), reno: updateReno, rememo: $("#rememo2").val()},
		success: function(result){
			if (result!=="") {
				$("#replyDiv").appendTo(document.body);
				$("#replyDiv").hide();
				$("#reply"+updateReno).html( text2Html($("#rememo2").val()) );
				alert("<s:message code="msg.boardSave"/>");
			} else{
				alert("<s:message code="msg.err.save4error"/>");
			}
			updateReno = updateRememo = null;
		}
	})
} 

function fn_replyUpdateCancel(){
	hideDiv("#replyDiv");
	
	$("#reply"+updateReno).html(updateRememo);
	updateReno = updateRememo = null;
} 

function hideDiv(id){
	$(id).hide();
	$(id).appendTo(document.body);
}

function fn_replyReply(reno){
	$("#replyDialog").show();
	
	if (updateReno) {
		fn_replyUpdateCancel();
	} 
	
	$("#reparent3").val(reno);
	$("#rememo3").val("");
	$("#replyDialog").appendTo($("#reply"+reno));
	$("#rememo3").focus();
} 

function fn_replyReplyCancel(){
	hideDiv("#replyDialog");
} 

function fn_replyReplySave(){
	if ( ! chkInputValue("#rememo3", "<s:message code="board.contents"/>")) return;

	$.ajax({
		url: "boardReplySave",
		type:"post", 
		data : {brdno:$("#brdno").val(), reno: $("#reno3").val(), reparent: $("#reparent3").val(), rememo: $("#rememo3").val()},
		success: function(result){
			if (result!=="") {
				var parent = $("#reparent3").val();
				$("#replyItem"+parent).after(result);
				hideDiv("#replyDialog");
				alert("<s:message code="msg.boardSave"/>");
				$("#rememo3").val("");
			} else{
				alert("<s:message code="msg.err.server"/>");
			}
		}
	})	
}

function fn_addBoardLike(brdno){
	$.ajax({
		url: "addBoardLike",
		type:"post", 
		data : {brdno: brdno},
		success: function(result){
			if (result==="OK") {
				$("#boardLikeBtn").hide();
				$("#boardLike").text( parseInt($("#boardLike").text())+1);
			}
		}
	})	
}

</script>    
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-files-o fa-fw"></i> <c:out value="${bgInfo.bgname}"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
				<div class="panel panel-default">
                    <div class="panel-heading">
                        	<c:out value="${boardInfo.brdtitle}"/> [ <c:out value="${boardInfo.brdwriter}"/> <c:out value="${boardInfo.brddate}"/>]
                        <span class="pull-right text-muted">
                        	<i class="fa fa-eye fa-fw"></i> <c:out value="${boardInfo.brdhit}"/>
                        	<i class="fa fa-thumbs-o-up fa-fw"></i> <span id="boardLike"><c:out value="${boardInfo.brdlike}"/></span>
                        </span>
                    </div>
                    <div class="panel-body">
                        <p><c:out value="${boardInfo.brdmemo}" escapeXml="false"/></p>
                    </div>
                    <c:if test="${listview.size()>0}">
		                <div class="panel-footer">
		                	<c:forEach var="listview" items="${listview}" varStatus="status">	
		           				<a href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
								<c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
							</c:forEach>
	                     </div>
                    </c:if>
                </div>
                <button class="btn btn-outline btn-primary" onclick="fn_moveToURL('boardList?bgno=<c:out value="${bgno}"/>')" ><s:message code="common.btnList"/></button>
				<c:if test='${boardInfo.userno==sessionScope.userno}' >
	                <button class="btn btn-outline btn-primary" onclick="fn_moveToURL('boardDelete?bgno=<c:out value="${boardInfo.bgno}"/>&brdno=<c:out value="${boardInfo.brdno}"/>', '<s:message code="common.btnDelete"/>')" ><s:message code="common.btnDelete"/></button>
	                <button class="btn btn-outline btn-primary" onclick="fn_moveToURL('boardForm?brdno=<c:out value="${boardInfo.brdno}"/>')" ><s:message code="common.btnUpdate"/></button>
				</c:if>
				
				<c:if test="${boardInfo.brdlikechk == null}" >
	                <button id="boardLikeBtn" class="btn btn-outline btn-primary pull-right" onclick="fn_addBoardLike(<c:out value="${boardInfo.brdno}"/>)" ><i class="fa fa-thumbs-o-up fa-fw"></i> <s:message code="common.like"/></button>
				</c:if>
							                               
				<p>&nbsp;</p>
				<input type="hidden" id="brdno" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
				
				<c:if test="${bgInfo.bgreply=='Y'}">
                    <div class="panel panel-default">
                        <div class="panel-body">
								<div class="col-lg-6">
									<textarea class="form-control" id="rememo1" name="rememo" maxlength="500" placeholder="<s:message code="msg.inputReply"/>"></textarea>
								</div>
								<div class="col-lg-6">
	                				<button class="btn btn-outline btn-primary" onclick="fn_formSubmit()"><s:message code="common.btnSave"/></button>
								</div>
                        </div>
                    </div>
						
					<div id="replyList"> 
						<c:forEach var="replylist" items="${replylist}" varStatus="status">
							<div class="panel panel-default" id="replyItem<c:out value="${replylist.reno}"/>" style="margin-left: <c:out value="${20*replylist.redepth}"/>px;">
			                	<div class="panel-body">
			                   		<div class="pull-left photoOutline">
										<c:choose>
										    <c:when test="${replylist.photo==null}">
												<a href="" class="img-circle">
													<i class="glyphicon glyphicon-user noPhoto"></i>
												</a>
										    </c:when>
										    <c:otherwise>
										    	<img class="img-circle" src="fileDownload?downname=<c:out value="${replylist.photo}"/>" title="<c:out value="${replylist.rewriter}"/>"/>
										    </c:otherwise>
										</c:choose>
									</div>					
				                   	<div class="photoTitle">
										<div> 
											<c:out value="${replylist.rewriter}"/> <c:out value="${replylist.redate}"/>
											<c:if test='${replylist.userno==sessionScope.userno}' >
												<a href="javascript:fn_replyDelete('<c:out value="${replylist.reno}"/>')" title="<s:message code="common.btnDelete"/>" ><span class="text-muted"><i class="fa fa-times fa-fw"></i></span></span></a>
												<a href="javascript:fn_replyUpdate('<c:out value="${replylist.reno}"/>')" title="<s:message code="common.btnUpdate"/>" ><span class="text-muted"><i class="fa fa-edit fa-fw"></i></span></a>
											</c:if>
											<a href="javascript:fn_replyReply('<c:out value="${replylist.reno}"/>')" title="<s:message code="common.btnReply"/>" ><span class="text-muted"><i class="fa fa-comments fa-fw"></i></span></a>
										</div>
										<div id="reply<c:out value="${replylist.reno}"/>"><c:out value="${replylist.getRememoByHTML()}" escapeXml="false"/></div>
									</div>
								</div>
				            </div>						
						</c:forEach>
					</div>
				</c:if>

				<div id="replyDiv" style="width: 99%; display:none">
						<input type="hidden" id="brdno2" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
						<input type="hidden" id="reno2" name="reno">
						<div class="col-lg-6">
							<textarea class="form-control" id="rememo2" name="rememo2" rows="3" maxlength="500"></textarea>
						</div>
						<div class="col-lg-2 pull-left">
               				<button class="btn btn-outline btn-primary" onclick="fn_replyUpdateSave()"><s:message code="common.btnSave"/></button>
               				<button class="btn btn-outline btn-primary" onclick="fn_replyUpdateCancel()"><s:message code="common.btnCancel"/></button>
						</div>
				</div>
				
				<div id="replyDialog" style="width: 99%; display:none">
						<input type="hidden" id="brdno3" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
						<input type="hidden" id="reno3" name="reno"> 
						<input type="hidden" id="reparent3" name="reparent">
						<div class="col-lg-6">
							<textarea class="form-control" id="rememo3" name="rememo3" rows="3" maxlength="500"></textarea>
						</div>
						<div class="col-lg-2 pull-left">
               				<button class="btn btn-outline btn-primary" onclick="fn_replyReplySave()"><s:message code="common.btnSave"/></button>
               				<button class="btn btn-outline btn-primary" onclick="fn_replyReplyCancel()"><s:message code="common.btnCancel"/></button>
						</div>
				</div>								
                
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>
