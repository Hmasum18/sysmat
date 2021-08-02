<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hasan Masum
  Date: 02-Aug-21
  Time: 6:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All categories</title>
</head>
<body>

<div class="container">
    <div class="row content">

        <div class="mb-3">

            <%--error--%>
            <c:if test="${categoryList.size() == 0}">
                <div class="alert alert-info" role="alert">
                    No category.
                </div>
            </c:if>

            <%--show categories--%>
            <c:forEach items="${categoryList}" var="category" varStatus="i">
                <!--Category Card 5-->
                <div class="col-md-4 mt-4 mx-4 mb4" >
                    <div class="card profile-card-5">
                        <div class="card-img-block">
                            <img id="category-logo" class="card-img-top"
                                 src="${category.getLogoImagePath()}"
                                 style="max-width: 40rem; max-height: 40rem"
                                 alt="Card image cap">
                        </div>
                        <div class="card-body pt-0">
                            <h5 class="card-title" id="cardCategoryName">${category.name}</h5>
                            <p class="card-text" id="cardCategoryDescription">${category.description}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>


    </div>
</div>


</body>
</html>
