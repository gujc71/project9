<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

		
<div class="panel panel-default" id="replyItem<c:out value="${replyInfo.reno}"/>" style="margin-left: <c:out value="${20*replyInfo.redepth}"/>px;">
	<div class="panel-body">
		<div class="pull-left photoOutline">
			<c:choose>
			    <c:when test="${replyInfo.photo==null}">
					<a href="" class="img-circle">
						<i class="glyphicon glyphicon-user noPhoto"></i>
					</a>
			    </c:when>
			    <c:otherwise>
			    	<img class="img-circle" src="fileDownload?downname=<c:out value="${replyInfo.photo}"/>" title="<c:out value="${replyInfo.rewriter}"/>"/>
			    </c:otherwise>
			</c:choose>
		</div>					
	    <div class="pull-left photoTitle">
			<div> 
				<c:out value="${replyInfo.rewriter}"/> <c:out value="${replyInfo.redate}"/>
				<c:if test='${replyInfo.userno==sessionScope.userno}' >
					<a href="javascript:fn_replyDelete('<c:out value="${replyInfo.reno}"/>')" title="<s:message code="common.btnDelete"/>" ><span class="text-muted"><i class="fa fa-times fa-fw"></i></span></span></a>
					<a href="javascript:fn_replyUpdate('<c:out value="${replyInfo.reno}"/>')" title="<s:message code="common.btnUpdate"/>" ><span class="text-muted"><i class="fa fa-edit fa-fw"></i></span></a>
				</c:if>
				<a href="javascript:fn_replyReply('<c:out value="${replyInfo.reno}"/>')" title="<s:message code="common.btnReply"/>" ><span class="text-muted"><i class="fa fa-comments fa-fw"></i></span></a>
			</div>
			<div id="reply<c:out value="${replyInfo.reno}"/>"><c:out value="${replyInfo.getRememoByHTML()}" escapeXml="false"/></div>
		</div>
	</div>
</div>