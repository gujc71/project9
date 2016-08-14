<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<script>
	alert("<s:message code="msg.err.noAuth"/>");
	history.back(-1);
</script>
