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
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <div class="row mb-3">
            <div class="mt-3">
                <h3>${category!=null?category.name:"Product"}(Pending verification)</h3>
            </div>
                <%--error--%>
            <c:if test="${productListUnverified == null || productListUnverified.size() == 0}">
                <div class="alert alert-info" role="alert">
                    No product for verification.
                </div>
            </c:if>
        </div>

        <c:forEach items="${productListUnverified}" step="4" varStatus="i">
        <div class="row">
            <c:forEach items="${productListUnverified}" var="product" begin="${i.index}" end="${i.index+3}"
                       varStatus="j">
            <div class="col-md-6 mt-4 product">
                <div class="card card-body">
                    <div class="row media justify-content-center align-items-center align-items-lg-start text-center text-lg-left flex-column flex-lg-row">
                        <div class="col-md-3 mr-2 mb-3 mb-lg-0">
                            <img src="${product.images}" width="150"  alt="Product Image">
                        </div>
                        <div class="col-md-6 media-body text-left ">
                            <h6 class="media-title font-weight-bold">${product.name}</h6>
                            <p class="text-muted">${product.category.name}</p>
                            <p class="mb-3">${product.description}</p>
                            <p class="mb-0 text-muted">${product.location}</p>
                        </div>
                        <div class="col-md-3">
                            <h3 class="mb-0 font-weight-semibold">
                                <b style="font-size: 1.5em;">৳</b>${product.price}</h3>
                            <p class="btn btn-outline-success mt-4 font-weight-bold">${product.mobileNumbers}</p>
                            <p class="text-muted">Uploaded by: ${product.user.username}</p>
                        </div>
                    </div>
                </div>

                <div class="my-3">
                    <a href="/user/product/${product.id}/edit/" type="button" class="btn btn-primary">EDIT</a>
                    <a
                            type="submit"
                            class="btn btn-danger productDeleteButton"
                            data-product-id="${product.id}"
                            data-product-logo="${product.images}"
                            data-bs-toggle="modal"
                            data-bs-target=".productDeleteModal">
                        DELETE
                    </a>
                    <c:if test="${pageContext.request.userPrincipal.toString().contains(\"ROLE_ADMIN\")}">
                        <a href="/admin/product/${product.id}/verify" type="button" class="btn btn-success">VERIFY</a>
                    </c:if>
                </div>
            </div>
            </c:forEach>
        </div>
        </c:forEach>

    </c:if>

    <div class="row mb-3">

        <div class="my-3">
            <h3>${category!=null?category.name:"Product"}</h3>
        </div>
        <%--error--%>
        <c:if test="${productList == null || productList.size() == 0}">
            <div class="alert alert-info" role="alert">
                No product available..
            </div>
        </c:if>
    </div>


    <%--show product list--%>
    <c:forEach items="${productList}" step="4" varStatus="i">
        <div class="row">
            <c:forEach items="${productList}" var="product" begin="${i.index}" end="${i.index+3}" varStatus="j">

                <div class="col-md-6 mt-4 product">

                    <div class="card card-body">
                        <div class="row media justify-content-center align-items-center align-items-lg-start text-center text-lg-left flex-column flex-lg-row">
                            <div class="col-md-3 mr-2 mb-3 mb-lg-0">
                                <img src="${product.images}" width="150" alt="Product Image">
                            </div>
                            <div class="col-md-6 media-body text-left ">
                                <h6 class="media-title font-weight-bold">${product.name}</h6>
                                <p class="text-muted">${product.category.name}</p>
                                <p class="mb-3">${product.description}</p>
                                <p class="mb-0 text-muted">${product.location}</p>
                            </div>
                            <div class="col-md-3">
                                <h3 class="mb-0 font-weight-semibold">
                                    <b style="font-size: 1.5em;">৳</b>${product.price}</h3>
                                <p class="btn btn-outline-success mt-4 font-weight-bold">${product.mobileNumbers}</p>
                                <p class="text-muted">Uploaded by: ${product.user.username}</p>
                            </div>
                        </div>

                    </div>

                    <div class="my-3">


                        <c:if test="${pageContext.request.userPrincipal.name != null && category == null}">
                            <a href="/user/product/${product.id}/edit/" type="button"
                               class="btn btn-primary">EDIT</a>
                            <a
                                    type="submit"
                                    class="btn btn-danger productDeleteButton"
                                    data-product-id="${product.id}"
                                    data-product-logo="${product.images}"
                                    data-bs-toggle="modal"
                                    data-bs-target=".productDeleteModal">
                                DELETE
                            </a>
                        </c:if>
                        <c:if test="${pageContext.request.userPrincipal.toString().contains(\"ROLE_ADMIN\")}">
                            <a href="/admin/product/${product.id}/verify" type="button"
                               class="btn btn-success">VERIFY</a>
                        </c:if>
                    </div>

                </div>


            </c:forEach>
        </div>
    </c:forEach>

    <!-- delete modal -->
    <div class="modal fade productDeleteModal" tabindex="-1"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">${product.name}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Do you want to delete this category permanently?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Close
                    </button>

                    <form method="post" id="productModalDeleteForm">
                        <input
                                id="productModalDeleteButton"
                                value="PROCEED"
                                type="submit" class="btn btn-danger"/>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

    <%--product card info update--%>
    <script>
        //https://awesomeopensource.com/project/algolia/places
        //https://www.algolia.com/apps/VG3P3EKYOE/api-keys/all
        $(".product .product-card-body").click(function () {
            $(this).find(".card-content").toggleClass("open");
        })

        $(function () {
            $(".productDeleteButton").click(function () {
                const productId = $(this).data("product-id");
                console.log("willing to delete product id: " + productId);
                const productLogoUrl = $(this).data("product-logo");
                parseImageNameFromUrl(productLogoUrl);
                console.log("logo: " + productLogoUrl);
                $('#productModalDeleteForm').data("product-logo", productLogoUrl)
                $('#productModalDeleteForm').attr("action", "/user/product/" + productId + "/delete");
            })

            $("#productModalDeleteForm").submit(function (e) {
                e.preventDefault();
                deleteImageFromFirebaseStorage($('#productModalDeleteForm').data("product-logo"),
                    function () {
                        console.log("image deleted callback")
                        $("#productModalDeleteForm").unbind().submit();
                    });
            })
        });
    </script>


    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/8.9.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.9.1/firebase-storage.js"></script>

    <!-- TODO: Add SDKs for Firebase products that you want to use
         https://firebase.google.com/docs/web/setup#available-libraries -->


    <script>
        // Your web app's Firebase configuration
        const firebaseConfig = {
            apiKey: "${firebaseApiKey}",
            authDomain: "${firebaseProjectId}" + ".firebaseapp.com",
            databaseURL: "${firebaseProjectId}" + ".firebaseio.com",
            projectId: "${firebaseProjectId}",
            storageBucket: "${firebaseProjectId}" + ".appspot.com",
            messagingSenderId: "${messagingSenderId}",
            appId: "${firebaseAppId}"
        };
        //console.log(firebaseConfig);
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);

        console.log("firebase initialized.")

        function parseImageNameFromUrl(imageUrl) {
            const startIdx = imageUrl.indexOf("images%2F") + "images%2F".length;
            const endIdx = imageUrl.indexOf("?alt", startIdx);
            const imageName = imageUrl.substring(startIdx, endIdx);
            console.log("parseImageNameFromUrl()->" + imageName);
            return imageName;
        }

        function deleteImageFromFirebaseStorage(imageUrl, onDeleteFinish) {
            const imageName = parseImageNameFromUrl(imageUrl)
            // Create a reference to the file to delete
            const fileName = 'images/' + imageName;
            console.log(fileName);
            const storageRef = firebase.storage().ref();
            const desertRef = storageRef.child('images').child(imageName);

            // Delete the file
            desertRef.delete().then(() => {
                // File deleted successfully
                console.log(imageName + " deleted successfully form firebase")
                onDeleteFinish();
            }).catch((error) => {
                // Uh-oh, an error occurred!
                console.log(imageName + " was not deleted from firebase.")
                onDeleteFinish();
            });
        }
    </script>
</body>
</html>
