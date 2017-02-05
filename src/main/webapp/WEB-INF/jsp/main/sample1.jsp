<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
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
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/dynatree/jquery.dynatree.js"></script>
    <script src="js/project9.js"></script>
<script>

function fn_searchDept(){
    $.ajax({
        url: "popupDept",
        type: "post"        
    }).success(function(result){
                $("#popupDept").html(result);
        }            
    );
    $("#popupDept").modal("show");
}

function deptTreeActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $("#deptno").val(node.data.key);
    $("#deptnm").val(node.data.title);
    $("#popupDept").modal("hide");
}
////////////////////////////////////////////////
function fn_searchUser(){
    $.ajax({
        url: "popupUser",
        type: "post"        
    }).success(function(result){
                $("#popupUser").html(result);
        }            
    );
    $("#popupUser").modal("show");
}

function deptTreeInUserActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $.ajax({
        url: "popupUsersByDept",
        type:"post", 
        data: { deptno : node.data.key }        
    }).success(function(result){
                $("#userlist").html(result);
        }            
    );
}
function fn_selectUser(userno, usernm) {
    $("#userno").val(userno);
    $("#usernm").val(usernm);
    $("#popupUser").modal("hide");

}
////////////////////////////////////////////////
function fn_searchUsers(){
    $.ajax({
        url: "popupUsers",
        type: "post"        
    }).success(function(result){
                $("#popupUsers").html(result);
                if ($("#usernos").val()!==""){
                    set_Users($("#usernos").val(), $("#usernms").val()); 
                }
        }            
    );
    $("#popupUsers").modal("show");
}
function deptTreeInUsersActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $.ajax({
        url: "popupUsers4Users",
        type:"post", 
        data: { deptno : node.data.key }        
    }).success(function(result){
                $("#userlist4Users").html(result);
        }            
    );
}

function fn_selectUsers(usernos, usernms) {
    $("#usernos").val(usernos);
    $("#usernms").val(usernms);
    $("#popupUsers").modal("hide");
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
                    <h1 class="page-header">샘플 1: 조직도/사용자</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-2">
                        부서 선택
                </div>
                <div class="col-lg-3">
                    <div class="input-group custom-search-form">
                        <input type="hidden" name="deptno" id="deptno">
                        <input class="form-control" type="text" name="deptnm" id="deptnm" readonly="readonly">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="fn_searchDept()">
                                <i class="fa fa-search"></i>
                            </button>
                        </span>
                    </div>
                </div>
                <div class="col-lg-1">
                    <button class="btn btn-default" type="button" onclick="fn_showCode('#popupCode4Dept')" title="코드 보기">
                        <i class="fa fa-code"></i> 코드 보기
                    </button>
                </div>
            </div>
            
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-2">
                        사용자 선택
                </div>
                <div class="col-lg-3">
                    <div class="input-group custom-search-form">
                        <input type="hidden" name="userno" id="userno">
                        <input class="form-control" type="text" name="usernm" id="usernm" readonly="readonly">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="fn_searchUser()">
                                <i class="fa fa-search"></i>
                            </button>
                        </span>
                    </div>
                </div>
                <div class="col-lg-1">
                    <button class="btn btn-default" type="button" onclick="fn_showCode('#popupCode4User')" title="코드 보기">
                        <i class="fa fa-code"></i> 코드 보기
                    </button>
                </div>                                                  
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-2">
                        사용자들 선택
                </div>
                <div class="col-lg-3">
                    <div class="input-group custom-search-form">
                        <input type="hidden" name="usernos" id="usernos">
                        <input class="form-control" type="text" name="usernms" id="usernms" readonly="readonly">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="fn_searchUsers()">
                                <i class="fa fa-search"></i> 
                            </button>
                        </span>
                    </div>
                </div>
                <div class="col-lg-1">
                    <button class="btn btn-default" type="button" onclick="fn_showCode('#popupCode4Users')" title="코드 보기">
                        <i class="fa fa-code"></i> 코드 보기
                    </button>
                </div>                                                  
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
    <!-- Modal -->
    <div id="popupDept" style="display: none;" class="modal fade bs-example-modal-sm" role="dialog" tabindex="-1" aria-labelledby="mySmallModalLabel"></div>

    <div id="popupUser" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"></div>
    
    <div id="popupUsers" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"></div>
    
    <div id="popupCode4Dept" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
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
                        <pre style="height:100px">
    &lt;link href="js/dynatree/ui.dynatree.css" rel="stylesheet"/&gt; 
    &lt;script src="js/jquery-2.2.3.min.js"&gt;&lt;/script&gt;
    &lt;script src="js/jquery-ui.js"&gt;&lt;/script&gt;
    &lt;script src="js/dynatree/jquery.dynatree.js"&gt;&lt;/script&gt;
&lt;script&gt;
function fn_searchDept(){
    $.ajax({
        url: "popupDept",
        type: "post"        
    }).success(function(result){
                $("#popupDept").html(result);
        }            
    );
    $("#popupDept").modal("show");
}

function deptTreeActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $("#deptno").val(node.data.key);
    $("#deptnm").val(node.data.title);
    $("#popupDept").modal("hide");
}
&lt;/script&gt;                        
                        </pre>  
                        <pre>
   &lt;input type="hidden" name="deptno" id="deptno"&gt;
   &lt;input class="form-control" type="text" name="deptnm" id="deptnm" readonly="readonly"&gt;
   &lt;span class="input-group-btn"&gt;
       &lt;button class="btn btn-default" type="button" onclick="fn_searchDept()"&gt;
           &lt;i class="fa fa-search"&gt;&lt;/i&gt;
       &lt;/button&gt;
   &lt;/span&gt;        
                        </pre>
                        <pre>
   &lt;div id="popupDept" style="display: none;" class="modal fade bs-example-modal-sm" role="dialog" 
    tabindex="-1" aria-labelledby="mySmallModalLabel"&gt;&lt;/div&gt;
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
    <div id="popupCode4User" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
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
                        <pre style="height:100px">
    &lt;link href="js/dynatree/ui.dynatree.css" rel="stylesheet"/&gt; 
    &lt;script src="js/jquery-2.2.3.min.js"&gt;&lt;/script&gt;
    &lt;script src="js/jquery-ui.js"&gt;&lt;/script&gt;
    &lt;script src="js/dynatree/jquery.dynatree.js"&gt;&lt;/script&gt;                        
&lt;script&gt;                        
function fn_searchUser(){
    $.ajax({
        url: "popupUser",
        type: "post"        
    }).success(function(result){
                $("#popupUser").html(result);
        }            
    );
    $("#popupUser").modal("show");
}

function deptTreeInUserActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $.ajax({
        url: "popupUsersByDept",
        type:"post", 
        data: { deptno : node.data.key }        
    }).success(function(result){
                $("#userlist").html(result);
        }            
    );
}
function fn_selectUser(userno, usernm) {
    $("#userno").val(userno);
    $("#usernm").val(usernm);
    $("#popupUser").modal("hide");

}
&lt;/script&gt;                        
                        </pre>  
                        <pre>
    &lt;input type="hidden" name="userno" id="userno"&gt;
    &lt;input class="form-control" type="text" name="usernm" id="usernm" readonly="readonly"&gt;
    &lt;span class="input-group-btn"&gt;
        &lt;button class="btn btn-default" type="button" onclick="fn_searchUser()"&gt;
            &lt;i class="fa fa-search"&gt;&lt;/i&gt;
        &lt;/button&gt;
    &lt;/span&gt;
                        </pre>
                        <pre>
    &lt;div id="popupUser" class="modal fade" tabindex="-1" role="dialog" 
    aria-labelledby="myModalLabel" aria-hidden="true"&gt;&lt;/div&gt;
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
    <div id="popupCode4Users" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
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
                        <pre style="height:100px">
    &lt;link href="js/dynatree/ui.dynatree.css" rel="stylesheet"/&gt; 
    &lt;script src="js/jquery-2.2.3.min.js"&gt;&lt;/script&gt;
    &lt;script src="js/jquery-ui.js"&gt;&lt;/script&gt;
    &lt;script src="js/dynatree/jquery.dynatree.js"&gt;&lt;/script&gt;
&lt;script&gt;                        
function fn_searchUsers(){
    $.ajax({
        url: "popupUsers",
        type: "post"        
    }).success(function(result){
                $("#popupUsers").html(result);
                if ($("#usernos").val()!==""){
                    set_Users($("#usernos").val(), $("#usernms").val()); 
                }
        }            
    );
    $("#popupUsers").modal("show");
}
function deptTreeInUsersActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $.ajax({
        url: "popupUsers4Users",
        type:"post", 
        data: { deptno : node.data.key }        
    }).success(function(result){
                $("#userlist4Users").html(result);
        }            
    );
}

function fn_selectUsers(usernos, usernms) {
    $("#usernos").val(usernos);
    $("#usernms").val(usernms);
    $("#popupUsers").modal("hide");
}
&lt;/script&gt;                          
                        </pre>  
                        <pre>
    &lt;input type="hidden" name="usernos" id="usernos"&gt;
    &lt;input class="form-control" type="text" name="usernms" id="usernms" readonly="readonly"&gt;
    &lt;span class="input-group-btn"&gt;
        &lt;button class="btn btn-default" type="button" onclick="fn_searchUsers()"&gt;
            &lt;i class="fa fa-search"&gt;&lt;/i&gt;
        &lt;/button&gt;
    &lt;/span&gt;
                        </pre>
                        <pre>
    &lt;div id="popupUsers" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" 
    aria-labelledby="myLargeModalLabel"&gt;&lt;/div&gt; 
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
