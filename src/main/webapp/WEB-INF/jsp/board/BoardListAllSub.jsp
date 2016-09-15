<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

	<c:url var="link" value="boardRead">
		<c:param name="brdno" value="${listitem.brdno}" />
	</c:url>		
	<div class="listBody">
		<div class="listHiddenField pull-left field60">
			<c:choose>
			    <c:when test="${listitemNo != null}">
					<c:out value="${listitemNo}"/>
			    </c:when>
			    <c:otherwise>
			    	<i class="fa fa-bell-o fa-fw"></i>
			    </c:otherwise>
			</c:choose>
		</div>
				
		<div class="listHiddenField pull-right field100"><a href="boardList?bgno=<c:out value="${listitem.bgno}"/>"><c:out value="${listitem.bgname}"/></a></div>
		<div class="listHiddenField pull-right field60">
			<c:if test="${listitem.filecnt>0}">
				<i class="fa fa-download fa-fw" title="<c:out value="${listitem.filecnt}"/>"></i>
			</c:if>	
		</div>
		<div class="listHiddenField pull-right field60 textCenter"><c:out value="${listitem.brdhit}"/></div>
		<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listitem.brddate}"/></div>
		<div class="listHiddenField pull-right field100 textCenter"><a href="list4User?userno=<c:out value="${listitem.userno}"/>"><c:out value="${listitem.brdwriter}"/></a></div>
		<div class="listTitle" title="<c:out value="${listitem.brdtitle}"/>">
			<a href="${link}" <c:if test="${listitem.brdnotice=='Y'}">class="notice"</c:if>><c:out value="${listitem.brdtitle}"/></a>
			<c:if test="${listitem.replycnt>0}">
				(<c:out value="${listitem.replycnt}"/>)
			</c:if>									
		</div>
		<div class="showField text-muted small">
			<c:out value="${listitem.brdwriter}"/> 
			<c:out value="${listitem.brddate}"/>
			<i class="fa fa-eye fa-fw"></i> <c:out value="${listitem.brdhit}"/>
			<c:if test="${listitem.filecnt>0}">
				<i class="fa fa-download fa-fw" title="<c:out value="${listitem.filecnt}"/>"></i>
			</c:if>
			[<a href="boardList?bgno=<c:out value="${listitem.bgno}"/>"><c:out value="${listitem.bgname}"/></a>]									
		</div>
	</div>
