<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>


     <div class="col-lg-12">
         <h1 class="page-header">
         <a href="javascript: fn_moveDate('<c:out value="${preWeek}"/>')"><i class="fa fa-angle-left fa-fw"></i></a>
         
         <c:out value="${month}"/>월 <c:out value="${week}"/>째주
         <a href="javascript: fn_moveDate('<c:out value="${nextWeek}"/>')"><i class="fa fa-angle-right fa-fw"></i></a>
         </h1>
     </div>
 
     <div class="col-lg-12">
         <c:forEach var="calenList" items="${calenList}" varStatus="status">    
             <div class="col-gu">
                 <div class="panel <c:if test="${calenList.istoday}">panel-red</c:if> <c:if test="${!calenList.istoday}">panel-default</c:if> height100">
                     <div class="panel-heading"><c:out value="${calenList.month}"/>월 <c:out value="${calenList.day}"/>일 (<c:out value="${calenList.week}"/>)</div>
                     <div class="panel-body">
                     </div>
                 </div>
             </div>
         </c:forEach>
     </div>
