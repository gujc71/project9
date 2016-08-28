<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<script>
var selectedNode = null;

$(function(){
	$("#deptTree").dynatree({
		children: <c:out value="${treeStr}" escapeXml="false"/>,
		onActivate: deptTreeActivate
	});
    $("#deptTree").dynatree("getRoot").visit(function(node){
        node.expand(true);
    });
});


</script>    
    	<div class="modal-dialog modal-sm" role="document"> 
    		<div class="modal-content"> 
    			<div class="modal-header"> 
    				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
    					<span aria-hidden="true">×</span>
    				</button> 
    				<h4 class="modal-title" id="mySmallModalLabel"><s:message code="common.deptList"/></h4> 
    			</div> 
    			<div class="modal-body">
		            <!-- /.row -->
		            <div class="row">
		            	<div class="col-lg-12" >
			            	<div class="panel panel-default maxHeight400" >
							    	<div id="deptTree">
									</div>
							</div>
		                </div> 
		            </div>
		            <!-- /.row -->
		
    			</div>
    		</div> 
    	</div> 
