<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<script>
var selectedNode = null;

$(function(){
	$("#deptTree4Users").dynatree({
		children: <c:out value="${treeStr}" escapeXml="false"/>,
		onActivate: deptTreeInUsersActivate
	});
    $("#deptTree4Users").dynatree("getRoot").visit(function(node){
        node.expand(true);
    });
});

function set_Users(usernos, usernms) {
	var nos = usernos.split(",");
	var nms = usernms.split(",");
	for (var i in nos) {
		$("#seletedUsers > tbody").append("<tr id='tr" + nos[i] +"'><td>" + nms[i] + "</td><td><a href='javascript:fn_UserDelete(" + nos[i] +")'><i class='fa fa-times fa-fw'></i></a></td><tr>");
	}
}

function fn_search4Users() {
	if ( ! chkInputValue("#keyword4Users", "<s:message code="common.keyword"/>")) return false;
	
    $.ajax({
    	url: "popupUsers4Users",
		type: "post", 
    	data: { searchKeyword : $("#keyword4Users").val() }    	
    }).success(function(result){
    			$("#userlist4Users").html(result);
		}    		
    );
}
function fn_addUser(userno, usernm, deptnm) {
    
    var chk = document.getElementById("tr"+userno);
    if (chk) {
    	alert("<s:message code="msg.err.existUser"/>");
    	return;
    }
    
	$("#seletedUsers > tbody").append("<tr id='tr" + userno +"'><td>" + usernm + "</td><td><a href='javascript:fn_UserDelete(" + userno +")'><i class='fa fa-times fa-fw'></i></a></td><tr>");
}
function fn_UserDelete(userno) {
	$("#tr"+userno).remove();
}

function fn_closeUsers() {
	var usernos="", usernms="";
	$("#seletedUsers > tbody  > tr").each(function() {
		if (!this.id) return; 
		usernos += this.id.replace("tr","") + ",";
		usernms += $(this).find('td:eq(0)').html() + ",";
	});
	if (usernos.length>0) {
		usernos = usernos.substring(0, usernos.length-1);
		usernms = usernms.substring(0, usernms.length-1);
	}
	fn_selectUsers(usernos, usernms)
}

</script>    

	  	<div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="closeX" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="col-lg-3 pull-right">
		                   	<div class="input-group custom-search-form">
	                        	<input class="form-control" type="text" id="keyword4Users" name="keyword4Users" onkeydown="if(event.keyCode == 13) { fn_search4Users();}">
	                            <span class="input-group-btn">
	                            	<button class="btn btn-default" onclick="fn_search4Users()"><i class="fa fa-search"></i></button>
	                            </span>
	                       	</div>
					</div>
                    <h4 class="modal-title" id="myModalLabel"><s:message code="memu.user"/></h4>
                </div>
                
                <div class="modal-body">
		            <!-- /.row -->
		            <div class="row">
		            	<div class="col-lg-4" >
			            	<div class="panel panel-default" >
			            		<div class="panel-heading">
			                            <s:message code="common.deptList"/>
			                    </div>
			                    <div class="maxHeight400">
							    	<div id="deptTree4Users">
									</div>
								</div>
							</div>
		                </div> 
		            	<div class="col-lg-4" >
			            	<div class="panel panel-default" >
			            		<div class="panel-heading">
			            			<s:message code="common.userList"/>
			                    </div>
			                    <div class="panel-body maxHeight400" id="userlist4Users">
							    </div>    
							</div>
						</div>	
		            	<div class="col-lg-4" >
			            	<div class="panel panel-default" >
			            		<div class="panel-heading">
			            			<s:message code="common.selectedUser"/>
			                    </div>
			                    <div class="panel-body maxHeight400">
									 <table  id="seletedUsers" class="table table-striped table-bordered table-hover">
										<colgroup>
											<col width='80%' />
											<col width='10%' />
										</colgroup>
										<thead>
											<tr>
												<th><s:message code="common.name"/></th>
												<th></th> 
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
							    </div>    
							</div>
						</div>	
		            </div>
            		<!-- /.row -->                
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close"><s:message code="common.btnClose"/></button>
                    <button type="button" class="btn btn-primary" onclick="fn_closeUsers()"><s:message code="common.btnOK"/></button>
                </div>
		    </div>
	  	</div>