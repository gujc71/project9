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
    $("#photofile").change(function(){
    	readImage(this);
    });
});

    function readImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#previewImg").attr("src", e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
function TreenodeActivate(node) {
	selectedNode = node; 
	
    if (selectedNode==null || selectedNode.data.key==0) return;
    
    $.ajax({
    	url: "adUserList",
		type:"post", 
    	data: { deptno : selectedNode.data.key }    	
    }).success(function(result){
    			$("#userlist").html(result);
		}    		
    );
}

function fn_addUser(){
    if (selectedNode==null || selectedNode.data.key==0) {
    	alert("<s:message code="msg.err.selectDept"/>");
    	return;
    }
	$("#deptno").val("");	
	$("#userno").val("");	
	$("#userid").val("");
    $("#userid").attr("readonly",false);
	$("#usernm").val("");
	$("#userpw").val("");
	$("#userpw2").val("");
	$('input:radio[name="userrole"][value="U"]').prop("checked", true);
	$("#pwDiv").show("");
	$("#photofile").val("");
    $("#previewImg").attr("src","");
	
	$("#myModal").modal("show");	
}

function fn_addUserSave(){
	if ( ! chkInputValue("#userid", "<s:message code="common.id"/>")) return false;
	if ( ! chkInputValue("#usernm", "<s:message code="common.name"/>")) return false;
	if ( $("#userno").val() === ""){
		if ( ! chkInputValue("#userpw", "<s:message code="common.password"/>")) return false;
		if ( ! chkInputValue("#userpw2", "<s:message code="common.passwordRe"/>")) return false;
		if ( $("#userpw").val() !== $("#userpw2").val()){
			alert("<s:message code="msg.err.noMatchPW"/>");
			return false;
		}
	}
	
	var file = $("input[type=file]")[0].files[0];
	if (file) {
		var formData = new FormData();
		formData.append("userno", $("#userno").val());
		formData.append("deptno", selectedNode.data.key);
		formData.append("userid", $("#userid").val());
		formData.append("usernm", $("#usernm").val());
		formData.append("userpw", $("#userpw").val());
		formData.append("userrole", $("#userrole").val());
		formData.append("photofile", file); 
		$.ajax({
			url: "adUserSave",
		    contentType: false,
		    processData: false,		
			type:"post", 
			data : formData,
		}).done(saveResult);
	} else{
		$("#deptno").val(selectedNode.data.key);	
		var formData = $("#form1").serialize();
		$.ajax({
			url: "adUserSave",
			type:"post", 
			data : formData,
		}).done(saveResult);
	}
	$("#myModal").modal("hide");	
}

function saveResult(result){
	if (result==="") {
		alert("<s:message code="msg.err.usedID"/>");
	} else{
		$("#userlist").html(result);
		alert("<s:message code="msg.boardSave"/>");
	}	
}

function fn_chkUserid(){
	if ( ! chkInputValue("#userid", "<s:message code="common.id"/>")) return false;
	$.ajax({
		url: "chkUserid", 
		type:"post", 
		data : {userid: $("#userid").val()},
		success: function(result){
			if (result) {
				alert("<s:message code="msg.usedID"/>");
			} else{
				alert("<s:message code="msg.NoUsedID"/>");
			}
		}
	})		
}

function fn_UserRead(userno){
	$.ajax({
		url: "adUserRead", 
		type:"post", 
		data : {userno:userno},
		success: function(result){
			$("#deptno").val(result.deptno);	
			$("#userno").val(result.userno);
			$("#userid").val(result.userid);	
		    $("#userid").attr("readonly",true);
			$("#usernm").val(result.usernm);
			$('input:radio[name="userrole"][value="' + result.userrole + '"]').prop("checked", true);
			$("#pwDiv").hide("");
			$("#photofile").val("");
			if (result.photo){
		    	$("#previewImg").attr("src","fileDownload?downname="+result.photo);
			} else {
		    	$("#previewImg").attr("src","");
			}

			$("#myModal").modal("show");	
		}
	})		
}

function fn_UserDelete(userno){
    if(!confirm("<s:message code="ask.Delete"/>")) return;

	$.ajax({
		url: "adUserDelete", 
		type:"post", 
		data : {userno:userno, deptno:selectedNode.data.key},
		success: function(result){
			$("#userlist").html(result);
			alert("<s:message code="msg.boardDelete"/>");
		}
	})		
}

</script>    
</head>

<body>

    <div id="wrapper">
		<jsp:include page="../../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-user fa-fw"></i> <s:message code="memu.user"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
            	<div class="col-lg-3" >
	            	<div class="panel panel-default" >
	            		<div class="panel-heading">
	                            <s:message code="common.deptList"/>
	                    </div>
	                    <div style="max-height:400px; overflow:auto;" >
					    	<div id="tree">
							</div>
						</div>
					</div>
                </div> 
            	<div class="col-lg-6" >
	            	<div class="panel panel-default" >
	            		<div class="panel-heading">
	            			<s:message code="common.userList"/>
	            			<button class="btn btn-outline btn-primary pull-right" onclick="fn_addUser()" ><s:message code="board.append"/></button>	                            
	                    </div>
	                    <div class="panel-body" id="userlist">
					    </div>    
					</div>
				</div>	
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="closeX" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel"><s:message code="memu.user"/></h4>
                </div>
                <div class="modal-body">
                	<form id="form1" name="form1">
						<input type="hidden" name="userno" id="userno"> 
						<input type="hidden" name="deptno" id="deptno"> 
                    	<div class="row form-group">
                            <div class="col-lg-1"></div>
                            <label class="col-lg-2"><s:message code="common.id"/></label>
                            <div class="col-lg-5">
                            	<input type="text" class="form-control" id="userid" name="userid" maxlength="20">
                            </div>
                            <div class="col-lg-4">
			                    <button type="button" class="btn btn-default" onclick="fn_chkUserid()"><s:message code="common.idchk"/></button>
                            </div>
                        </div>
                    	<div class="row form-group">
                            <div class="col-lg-1"></div>
                            <label class="col-lg-2"><s:message code="common.name"/></label>
                            <div class="col-lg-8">
                            	<input type="text" class="form-control" id="usernm" name="usernm" maxlength="20">
                            </div>
                        </div>
                    	<div class="row form-group" id="pwDiv">
                            <div class="col-lg-1"></div>
                            <div class="col-lg-2"><label><s:message code="common.password"/></label></div>
                            <div class="col-sm-4">
                           		<input type="password" class="form-control" id="userpw" name="userpw" maxlength="20">
                           	</div>
                           	<div class="col-sm-4">
                           		<input type="password" class="form-control" id="userpw2" name="userpw2" maxlength="20">
                           	</div>
                        </div>
                    	<div class="row form-group">
                            <div class="col-lg-1"></div>
                            <label class="col-lg-2"><s:message code="common.role"/></label>
                            <div class="col-lg-8 checkbox-inline">
								 	<label><input name="userrole" id="userrole" type="radio" checked="checked" value="U"><s:message code="common.user"/></label>
								 	<label><input name="userrole" id="userrole" type="radio" value="A"><s:message code="memu.admin"/></label>
                            </div>
                        </div>
                    	<div class="row form-group">
                            <div class="col-lg-1"></div>
                            <div class="col-lg-2"><label><s:message code="common.photo"/></label></div>
                            <div class="col-sm-3">
                            	<img id="previewImg" style="width:100%; height: 120px; max-width: 100px;">
                            </div>
                            <div class="col-lg-5">
								<input type="file" name="photofile" id="photofile" accept='image/*'/>
                            </div>
                        </div>  
                	</form>        
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close"><s:message code="common.btnClose"/></button>
                    <button type="button" class="btn btn-primary" onclick="fn_addUserSave()"><s:message code="common.btnSave"/></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
        
</body>

</html>
