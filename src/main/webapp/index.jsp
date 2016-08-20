<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
    <c:when test="${sessionScope.userid eq null}">
		<jsp:forward page="/memberLogin"/>
    </c:when>
    <c:otherwise>
		<jsp:forward page="/index"/>
    </c:otherwise>


</c:choose>
