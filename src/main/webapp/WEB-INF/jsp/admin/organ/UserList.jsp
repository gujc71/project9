<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

					 <table class="table table-striped table-bordered table-hover">
						<colgroup>
							<col width='10%' />
							<col width='25%' />
							<col width='25%' />
							<col width='20%' />
							<col width='5%' />
						</colgroup>
						<thead>
							<tr>
								<th><s:message code="board.no"/></th> 
								<th><s:message code="common.id"/></th>
								<th><s:message code="common.name"/></th>
								<th><s:message code="common.role"/></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="listview" items="${listview}" varStatus="status">	
								<tr>
									<td><c:out value="${status.index+1}"/></td>
									<td><a href="javascript:fn_UserRead(<c:out value="${listview.userno}"/>)"><c:out value="${listview.userid}"/></a></td>
									<td><a href="javascript:fn_UserRead(<c:out value="${listview.userno}"/>)"><c:out value="${listview.usernm}"/></a></td>
									<td><c:out value="${listview.userrole}"/></td>
									<td><a href="javascript:fn_UserDelete(<c:out value="${listview.userno}"/>)"><i class="fa fa-times fa-fw"></i></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
