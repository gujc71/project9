<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<div class="panel panel-default" id="replyItem<c:out value="${replyInfo.reno}"/>" style="margin-left: <c:out value="${20*replyInfo.redepth}"/>px;">
	<div class="panel-heading"> 
		<c:out value="${replyInfo.rewriter}"/> <c:out value="${replyInfo.redate}"/>
		<a href="javascript:fn_replyDelete('<c:out value="${replyInfo.reno}"/>')" title="<s:message code="common.btnDelete"/>" ><span class="text-muted"><i class="fa fa-times fa-fw"></i></span></a>
		<a href="javascript:fn_replyUpdate('<c:out value="${replyInfo.reno}"/>')" title="<s:message code="common.btnUpdate"/>" ><span class="text-muted"><i class="fa fa-edit fa-fw"></i></span></a>
		<a href="javascript:fn_replyReply('<c:out value="${replyInfo.reno}"/>')" title="<s:message code="common.btnReply"/>" ><span class="text-muted"><i class="fa fa-comments fa-fw"></i></span></a>
    </div>
    <div class="panel-body" id="reply<c:out value="${replyInfo.reno}"/>"><c:out value="${replyInfo.rememo}"/></div>
</div>