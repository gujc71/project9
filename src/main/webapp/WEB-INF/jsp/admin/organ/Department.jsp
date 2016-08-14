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
	<link href="js/dynatree/ui.dynatree.css" rel="stylesheet"/>

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
	<script src="js/dynatree/jquery.dynatree.js"></script>
	<script src="js/project9.js"></script>    
		
<script>
var selectedNode = null;

$(function(){
	$("#tree").dynatree({
		children: <c:out value="${treeStr}" escapeXml="false"/>,
		onActivate: TreenodeActivate
	});
    $("#tree").dynatree("getRoot").visit(function(node){
        node.expand(true);
    });
	fn_groupNew();
});
function TreenodeActivate(node) {
	selectedNode = node;
	
    if (selectedNode==null || selectedNode.data.key==0) return;
    $.ajax({
    	url: "adDepartmentRead",
    	cache: false,
    	data: { deptno : selectedNode.data.key }    	
    }).done(receiveData);
}

function receiveData(data){
    $("#deptno").val(data.deptno);
    $("#deptnm").val(data.deptnm);
}

function fn_groupNew(){
    $("#deptno").val("");
    $("#deptnm").val("");
}

function fn_groupDelete(value){
    if (selectedNode==null){
    	alert("<s:message code="msg.err.boardDelete"/>");
    	return;
    }
    if (selectedNode.childList){
    	alert("<s:message code="msg.err.boardDelete4Child"/>");
    	return;
    }
    
    if(!confirm("<s:message code="ask.Delete"/>")) return;
    $.ajax({
    	url: "adDepartmentDelete",
    	cache: false,
    	data: { deptno : selectedNode.data.key }    	
    }).done(receiveData4Delete);
}

function receiveData4Delete(data){
	alert("<s:message code="msg.boardDelete"/>");
	selectedNode.remove();		
	selectedNode = null;
	fn_groupNew();
}

function fn_groupSave(){
	if ( ! chkInputValue("#deptnm", "<s:message code="common.deptName"/>")) return;

	var pid=null;
    if (selectedNode!=null) pid=selectedNode.data.key;

    if (!confirm("<s:message code="ask.Save"/>")) return;

    $.ajax({
    	url: "adDepartmentSave",
    	cache: false,
    	type: "POST",
    	data: { deptno:$("#deptno").val(), deptnm:$("#deptnm").val(), parentno: pid}    	
    }).done(receiveData4Save);
}

function receiveData4Save(data){
	if (selectedNode!==null && selectedNode.data.key===data.deptno) {
		selectedNode.data.title=data.deptnm;
		selectedNode.render();
	} else {
		addNode(data.deptno, data.deptnm);
	}
	
	alert("<s:message code="msg.boardSave"/>");
}

function addNode(nodeNo, nodeTitle){
	var node = $("#tree").dynatree("getActiveNode");
	if (!node) node = $("#tree").dynatree("getRoot");
	var childNode = node.addChild({key: nodeNo, title: nodeTitle});
	node.expand() ;
	node.data.isFolder=true;
	node.tree.redraw();
}
</script>    
</head>

<body>

    <div id="wrapper">
		<jsp:include page="../../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-sitemap fa-fw"></i> <s:message code="memu.dept"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
            	<div class="panel panel-default col-lg-3" >
                    <div style="max-height:400px; overflow:auto;" >
				    	<div id="tree">
						</div>
					</div>
				</div>
                 
            	<div class="panel panel-default col-lg-6" >
                    <div class="panel-body">
			            <div class="row form-group">
			            	<button class="btn btn-outline btn-primary" onclick="fn_groupNew()" ><s:message code="board.append"/></button>
						</div>
						<input name="deptno" id="deptno" type="hidden" value=""> 
			            <div class="row form-group">
			            	<label class="col-lg-3" ><s:message code="common.deptName"/></label>
			            	<div class="col-lg-9" >
				 				<input name="deptnm" id="deptnm" style="width: 300px;" type="text" maxlength="100" value="" class="form-control">
			            	</div>
						</div>

			            <div class="row form-group">
			            	<button class="btn btn-outline btn-primary" onclick="fn_groupSave()" ><s:message code="common.btnSave"/></button>
			            	<button class="btn btn-outline btn-primary" onclick="fn_groupDelete()" ><s:message code="common.btnDelete"/></button>
						</div>
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
