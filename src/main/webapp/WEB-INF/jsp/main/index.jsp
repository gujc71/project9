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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    
.col-gu{
    float: left;
    width: 14%;
    padding: 1px;
    height: 200px;
}

@media screen and (max-width: 1024px) {
  .col-gu{
    width: 33%;
  }
}

@media screen and (max-width: 450px) {
  .col-gu{
    width: 50%;
  }
}

</style>
    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
<script>
function fn_moveDate(date){
    $.ajax({
        url: "moveDate",
        type:"post", 
        data : {date: date},
        success: function(result){
            $("#calenDiv").html(result);
        }
    })
}    
</script>
    
</head>

<body>

    <div id="wrapper">

        <jsp:include page="../common/navigation.jsp" />
        
        <div id="page-wrapper">
            <div id="calenDiv" class="row">
                <jsp:include page="indexCalen.jsp" />
            </div>

            <div class="row">
                <div class="col-lg-12">
                    &nbsp;
                </div>
            </div>
                
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-send fa-fw"></i> Recent News
                            <div class="pull-right"><a href="boardList">more</a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="col-lg-12">
                                <div class="listHead">
                                    <div class="listHiddenField pull-right field100"><s:message code="board.locate"/></div>
                                    <div class="listHiddenField pull-right field100"><s:message code="board.date"/></div>
                                    <div class="listHiddenField pull-right field100"><s:message code="board.writer"/></div>
                                    <div class="listTitle"><s:message code="board.title"/></div>
                                </div>
                                <c:forEach var="listview" items="${listview}" varStatus="status">    
                                    <c:url var="link" value="boardRead">
                                        <c:param name="brdno" value="${listview.brdno}" />
                                    </c:url>        
                                    <div class="listBody">
                                        <div class="listHiddenField pull-right field100"><c:out value="${listview.bgname}"/></div>
                                        <div class="listHiddenField pull-right field100"><c:out value="${listview.brddate}"/></div>
                                        <div class="listHiddenField pull-right field100"><c:out value="${listview.brdwriter}"/></div>
                                        <div class="listTitle" title="<c:out value="${listview.brdtitle}"/>">
                                            <a href="${link}"><c:out value="${listview.brdtitle}"/></a>
                                            <c:if test="${listview.replycnt>0}">
                                                (<c:out value="${listview.replycnt}"/>)
                                            </c:if>                                                
                                        </div>
                                        <div class="showField text-muted small">
                                            <c:out value="${listview.brdwriter}"/> <c:out value="${listview.brddate}"/>
                                        </div>
                                    </div>
                                </c:forEach>    
                            </div>                        
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-volume-up fa-fw"></i> <s:message code="common.notice"/>
                        </div>
                        <div class="panel-body maxHeight400">
                            <c:forEach var="noticeList" items="${noticeList}" varStatus="status">    
                                <c:url var="link" value="boardRead">
                                    <c:param name="brdno" value="${noticeList.brdno}" />
                                </c:url>    
                                <a href="${link}">
                                <div class="listBody listTitle">
                                    <c:out value="${noticeList.brdtitle}"/>
                                </div>    
                                </a>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Time Line -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-clock-o fa-fw"></i> Time Line
                        </div>
                        <div class="panel-body maxHeight400">
                            <ul class="chat">
                                <c:forEach var="listtime" items="${listtime}" varStatus="status">
                                    <c:choose>
                                        <c:when test="${status.index % 2 eq 0}">
                                            <li class="left clearfix">
                                                    <c:choose>
                                                    <c:when test="${listtime.photo==null}">
                                                        <span class="chat-img pull-left img-circle">
                                                            <i class="glyphicon glyphicon-user noPhoto"></i>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="fileDownload?downname=<c:out value="${listtime.photo}"/>" title="<c:out value="${listtime.rewriter}"/>" class="chat-img pull-left img-circle"/>
                                                    </c:otherwise>
                                                    </c:choose>                                                
                                                <div class="chat-body clearfix">
                                                    <div class="header">
                                                        <strong class="primary-font"><c:out value="${listtime.rewriter}"/></strong>
                                                        <small class="pull-right text-muted">
                                                            <i class="fa fa-clock-o fa-fw"></i> <c:out value="${listtime.redate}"/>
                                                        </small>
                                                    </div>
                                                    <p>
                                                        <a href="boardRead?brdno=<c:out value="${listtime.brdno}"/>">게시물[<c:out value="${listtime.rememo}"/>]에 댓글이 추가되었습니다.</a>    
                                                    </p>
                                                </div>
                                            </li>                                    
                                        </c:when>
                                        <c:otherwise>
                                            <li class="right clearfix">
                                                <c:choose>
                                                <c:when test="${listtime.photo==null}">
                                                    <span class="chat-img pull-right img-circle">
                                                        <i class="glyphicon glyphicon-user noPhoto"></i>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="fileDownload?downname=<c:out value="${listtime.photo}"/>" title="<c:out value="${listtime.rewriter}"/>" class="chat-img pull-right img-circle"/>
                                                </c:otherwise>
                                                </c:choose>
                                                <div class="chat-body clearfix">
                                                    <div class="header">
                                                        <small class=" text-muted">
                                                            <i class="fa fa-clock-o fa-fw"></i> <c:out value="${listtime.redate}"/></small>
                                                        <strong class="pull-right primary-font"><c:out value="${listtime.rewriter}"/></strong>
                                                    </div>
                                                    <p>
                                                        <a href="boardRead?brdno=<c:out value="${listtime.brdno}"/>">게시물[<c:out value="${listtime.rememo}"/>]에 댓글이 추가되었습니다.</a>    
                                                    </p>
                                                </div>
                                            </li>                                            
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </ul>    
                        </div>
                    </div>                    
                    <!-- Time Line -->
                    
                </div>
                <!-- col-lg-4 -->
            </div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>