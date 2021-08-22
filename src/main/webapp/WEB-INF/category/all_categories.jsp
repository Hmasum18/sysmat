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
    <div class="row justify-content-center align-items-center">

        <div class="mb-3">

            <div class="my-3">
                <h3>Categories</h3>
            </div>

            <%--error--%>
            <c:if test="${categoryList ==null || categoryList.size() == 0}">
                <div class="alert alert-info" role="alert">
                    No category.
                </div>
            </c:if>

            <%--show categories--%>
            <c:forEach items="${categoryList}" step="4" varStatus="i">
                <div class="row">
                    <c:forEach items="${categoryList}" var="category" begin="${i.index}" end="${i.index+3}"
                               varStatus="j">
                        <%--category card--%>
                        <div class="col-md-3 my-4">

                           <%-- public --%>
                            <a class="card category-card" href="/category/${category.id}" style="text-decoration: none">
                                <div class="card-img-block">
                                    <img id="category-logo" class="card-img-top"
                                         src="${category.getLogo()}"
                                         alt="Card image cap">
                                </div>
                                <div class="card-body pt-0">
                                    <h5 class="card-title" id="cardCategoryName">${category.name}</h5>
                                    <p class="card-text" id="cardCategoryDescription">${category.description}</p>
                                </div>
                            </a>


                           <%--if the user is admin--%>
                            <c:if test="${pageContext.request.userPrincipal.toString().contains(\"ROLE_ADMIN\")}">
                                <div class="my-3">
                                    <a href="/admin/category/${category.id}/edit" type="button" class="btn btn-primary">EDIT</a>
                                    <a
                                            type="submit"
                                            class="btn btn-danger categoryDeleteButton"
                                            data-category-id = "${category.id}"
                                            data-category-logo= "${category.logo}"
                                            data-bs-toggle="modal"
                                            data-bs-target=".categoryDeleteModal">
                                        DELETE
                                    </a>
                                </div>
                            </c:if>
                        </div>


                    </c:forEach>
                </div>
            </c:forEach>

            <!-- delete modal -->
            <div class="modal fade categoryDeleteModal" tabindex="-1"
                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">${category.name}</h5>
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

                            <form method="post" id="categoryModalDeleteForm" >
                                <input
                                        id="categoryModalDeleteButton"
                                        value="PROCEED"
                                   type="submit" class="btn btn-danger"/>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>

<script>
    $(function () {
        $(".categoryDeleteButton").click(function (){
            const categoryId = $(this).data("category-id");
            console.log("willing to delete category id: "+categoryId);
            const categoryLogoUrl = $(this).data("category-logo");
            console.log("logo: "+categoryLogoUrl);
            $('#categoryModalDeleteForm').data("category-logo", categoryLogoUrl)
            $('#categoryModalDeleteForm').attr("action","/admin/category/"+categoryId+"/delete");
        })

        $("#categoryModalDeleteForm").submit(function (e){
            e.preventDefault();
            deleteImageFromFirebaseStorage($('#categoryModalDeleteForm').data("category-logo"),
            function() {
                console.log("image deleted callback")
                $("#categoryModalDeleteForm").unbind().submit();
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
