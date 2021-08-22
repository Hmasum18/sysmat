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

<style>

</style>

<div class="container mt-4">
    <div class="row justify-content-center align-items-center">
        <div class="col-md-4 col-sm-6">

            <form method="POST">

                <%--the fields we don't want to change--%>
                <input type="hidden" name="id" value="${category.id}">

                <div class="mb-3">
                    <label for="inputCategoryName" class="form-label">Category Name*</label>
                    <%--Category.name--%>
                    <input name="name"
                           type="text"
                           value="${category.name}"
                           class="form-control"
                           id="inputCategoryName"
                           placeholder="Book" required/>
                </div>


                <div class="mb-3">
                    <label for="inputCategoryDescription" class="form-label">Description*</label>
                    <%--Category.description--%>
                    <input name="description"
                           type="text"
                           value="${category.description}"
                           class="form-control"
                           id="inputCategoryDescription"
                           placeholder="Description here" required/>
                </div>
                <div class="mb-3">
                    <label for="inputCategoryLogo" class="form-label">Logo Image</label>
                    <input name="logoFile"
                           type="file"
                           accept="image/*"
                           class="form-control form-control-sm"
                           id="inputCategoryLogo"/>

                    <div class="my-3">
                        <div class="progress">
                            <div id="imageUploadProgressBar" class="progress-bar" role="progressbar" style="width: 0%;"
                                 aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>

                    <%--Category.logo--%>
                    <input type="hidden" id="categoryLogoUrl" name="logo" value="${category.logo}">
                </div>

                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>

        </div>


        <!--Profile Card 5-->
        <div class="col-md-3 mt-4 mx-4">
            <div class="card category-card">
                <div class="card-img-block">
                    <img id="category-logo" class="card-img-top"
                         src="${category.logo}"
                         style="max-width: 40rem; max-height: 40rem"
                         alt="Card image cap">
                </div>
                <div class="card-body pt-0">
                    <h5 class="card-title" id="cardCategoryName">${category.name}</h5>
                    <p class="card-text" id="cardCategoryDescription">${category.description}</p>
                </div>
            </div>
        </div>

    </div>


    <script>
        // render the category name
        const categoryNameField = document.getElementById("inputCategoryName");
        const cardCategoryName = document.getElementById("cardCategoryName");
        categoryNameField.addEventListener("change", function () {
            const categoryName = categoryNameField.value;
            console.log(categoryName);
            cardCategoryName.innerText = categoryName === "" ?
                "Category name here" : categoryName;
        });

        // render category description
        const categoryDescriptionField = document.getElementById("inputCategoryDescription");
        const cardCategoryDescription = document.getElementById("cardCategoryDescription");
        categoryDescriptionField.addEventListener("change", function () {
            const categoryDescription = categoryDescriptionField.value;
            //console.log(categoryName);
            cardCategoryDescription.innerText = categoryDescription === "" ?
                "Category description Here" : categoryDescription;
        });

        // front end validation
        function validate() {

        }

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
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);

        console.log("firebase initialized.")

        // render the image file in image view
        const imageInputField = document.getElementById("inputCategoryLogo")
        const preview = document.getElementById("category-logo")
        const hiddenImageUrlHolderInputField = document.getElementById("categoryLogoUrl");

        onImageSelected(imageInputField, preview, hiddenImageUrlHolderInputField);


        function onImageSelected(inputImageField, previewImg, imageUrlHolderHiddenInputField) {
            const funcName = "onImageSelected(): ";
            console.log(funcName);
            inputImageField.addEventListener("change", function () {
                console.log(funcName + "image selected for logo")
                if (this.files && this.files[0]) {
                    uploadToFirebase(this.files[0], function (imageUrl) {
                        console.log(funcName + "adding image url to src")
                        imageUrlHolderHiddenInputField.setAttribute("value", imageUrl);
                        previewImg.setAttribute('src', imageUrl);
                    });
                }
            });
        }

        function uploadToFirebase(file, onUploadSuccess) {
            const fileName = file.name;

            // Points to the root reference
            const storageRef = firebase.storage().ref();

            // Points to 'images'
            const imagesStorageRef = storageRef.child('images');

            // space ref where image will be stored
            const currentDate = new Date().getTime();
            const spaceRef = imagesStorageRef.child(currentDate + "-category-" + fileName);

            const uploadTask = spaceRef.put(file);

            uploadTask.on('state_changed',
                (snapshot) => {
                    // Observe state change events such as progress, pause, and resume
                    // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
                    let progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                    console.log('Upload is ' + progress + '% done');
                    const imageUploadProgressBar = document.querySelector("#imageUploadProgressBar");
                    imageUploadProgressBar.setAttribute("style", "width: " + progress + "%;");
                    imageUploadProgressBar.setAttribute("aria-valuenow", progress + "");
                },
                (error) => {
                    // Handle unsuccessful uploads
                },
                () => {
                    uploadTask.snapshot.ref.getDownloadURL().then((downloadURL) => {
                        console.log('File available at', downloadURL);
                        onUploadSuccess(downloadURL);
                    });
                }
            );
        }
    </script>
</div>
</body>
</html>
