<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Hasan Masum
  Date: 01-Aug-21
  Time: 8:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add new category</title>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center align-items-center">
        <div class="col-md-4 col-sm-6" >

            <form method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="inputCategoryName" class="form-label">Category Name*</label>
                    <input  name="name"
                            type="text"
                            class="form-control"
                            id="inputCategoryName"
                            placeholder="Book"/>
                </div>
                <div class="mb-3">
                    <label for="inputCategoryDescription" class="form-label">Description*</label>
                    <input name="description"
                            type="text"
                            class="form-control"
                            id="inputCategoryDescription"
                            placeholder="Description here"/>
                </div>
                <div class="mb-3">
                    <label for="inputCategoryLogo" class="form-label">Logo Image</label>
                    <input name="logoFile"
                            type="file"
                            accept="image/*"
                            class="form-control form-control-sm"
                            id="inputCategoryLogo"/>
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>

        </div>


        <!--Profile Card 5-->
        <div class="col-md-4 mt-4 mx-4 mb4" >
            <div class="card profile-card-5">
                <div class="card-img-block">
                    <img id="category-logo" class="card-img-top"
                        src="https://cdn.icon-icons.com/icons2/1147/PNG/512/1486486297-attribute-category-label-shop-price-price-tag-tag_81213.png"
                         style="max-width: 40rem; max-height: 40rem"
                         alt="Card image cap">
                </div>
                <div class="card-body pt-0">
                    <h5 class="card-title" id="cardCategoryName">Category Name</h5>
                    <p class="card-text" id="cardCategoryDescription">Category Description goes here</p>

                </div>
            </div>
        </div>


    </div>
    <script>
        // render the category name
        const categoryNameField = document.getElementById("inputCategoryName");
        const cardCategoryName = document.getElementById("cardCategoryName");
        categoryNameField.addEventListener("change", function (){
            const categoryName = categoryNameField.value;
            console.log(categoryName);
            cardCategoryName.innerText = categoryName;
        });

        // render category description
        const categoryDescriptionField = document.getElementById("inputCategoryDescription");
        const cardCategoryDescription = document.getElementById("cardCategoryDescription");
        categoryDescriptionField.addEventListener("change", function (){
            const categoryName = categoryDescriptionField.value;
            console.log(categoryName);
            cardCategoryDescription.innerText = categoryName;
        });

        // render the image file in image view
        const imageInputField = document.getElementById("inputCategoryLogo")
        const preview = document.getElementById("category-logo")

        imageInputField.addEventListener("change", function() {
            console.log("on change")
            if (this.files && this.files[0]) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    console.log("adding src")
                    preview.setAttribute('src', e.target.result);
                }

                reader.readAsDataURL(this.files[0]);
            }
        });

        // front end validation
        function validate(){

        }

    </script>
</div>
</body>
</html>
