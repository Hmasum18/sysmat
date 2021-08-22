<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hasan Masum
  Date: 04-Aug-21
  Time: 12:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All products</title>
</head>
<body>
   <div class="container">

       <div class="my-3">
           <h3>Product</h3>
       </div>

       <div class="row mb-3">
           <%--error--%>
           <c:if test="${productList ==null || productList.size() == 0}">
               <div class="alert alert-info" role="alert">
                   No product available..
               </div>
           </c:if>
       </div>


       <%--show product list--%>
       <c:forEach items="${productList}" step="4" varStatus="i">
           <div class="row">
               <c:forEach items="${productList}" var="product" begin="${i.index}" end="${i.index+3}" varStatus="j">
                   <!--Profile Card 5-->
                   <%--https://codepen.io/halidaa/pen/GGZqqg--%>
                   <div class="col-md-3 mt-4 mx-4" id="product">
                       <div class="product-card-body"
                            style="z-index: 0; transform: translate3d(0px, 0px, 0px) rotateX(0deg);"
                            tabindex="0">

                           <img id="productCardImage" src="${product.images}" alt="Product image">
                           <div class="card-content">
                               <p class="category-name" id="productCardCategoryName">${product.category.name}</p>
                               <h2 id="productCardProductName">${product.name}</h2>
                               <p id="productLocation">${product.location}</p>
                               <p class="read-more" id="productCardContactNumber">Contact: ${product.mobileNumbers}</p>
                               <div class="description">
                                   <p id="productCardDescription">${product.description}</p>
                                   <p></p>
                                   <p class="date" id="productCardDate">${product.created}</p>
                               </div>
                           </div>
                       </div>
                   </div>
               </c:forEach>
           </div>
       </c:forEach>

   </div>

   <%--product card info update--%>
   <script>
       //https://awesomeopensource.com/project/algolia/places
       //https://www.algolia.com/apps/VG3P3EKYOE/api-keys/all
       $("#product .product-card-body").click(function () {
           $(this).find(".card-content").toggleClass("open");
       })
   </script>
</body>
</html>
