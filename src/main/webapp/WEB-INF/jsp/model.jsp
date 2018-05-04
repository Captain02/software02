<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${list}" var="model">
<table>
	<tr>
		<td>${model.id}</td>
		<td>${model.key}</td>
		<td>${model.category}</td>
		<td>${model.createTime}</td>
		<td><a href="/Activiti-LFP/process-editor/modeler.html?modelId=${model.id}">编辑</a></td>
	</tr>
</table>
</c:forEach>
</body>
</html>