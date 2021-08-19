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
        <div class="col-md-4 col-sm-6" >

            <form method="POST">
                <div class="mb-3">
                    <label for="inputCategoryName" class="form-label">Category Name*</label>
                    <%--Category.name--%>
                    <input  name="name"
                            type="text"
                            class="form-control"
                            id="inputCategoryName"
                            placeholder="Book" required/>
                </div>


                <div class="mb-3">
                    <label for="inputCategoryDescription" class="form-label">Description*</label>
                    <%--Category.description--%>
                    <input name="description"
                            type="text"
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
                            id="inputCategoryLogo" required/>

                    <%--Category.logo--%>
                    <input type="hidden" id="logoUrl" name="logo" value="">
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>

        </div>


        <!--Profile Card 5-->
        <div class="col-md-3 mt-4 mx-4" >
            <div class="card category-card">
                <div class="card-img-block">
                    <img id="category-logo" class="card-img-top"
                        src="https://cdn.icon-icons.com/icons2/1147/PNG/512/1486486297-attribute-category-label-shop-price-price-tag-tag_81213.png"
                         style="max-width: 40rem; max-height: 40rem"
                         alt="Card image cap">
                </div>
                <div class="card-body pt-0">
                    <h5 class="card-title" id="cardCategoryName">Category name here</h5>
                    <p class="card-text" id="cardCategoryDescription">Category description here</p>
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
            cardCategoryName.innerText = categoryName === ""?
                                        "Category name here" : categoryName;
        });

        // render category description
        const categoryDescriptionField = document.getElementById("inputCategoryDescription");
        const cardCategoryDescription = document.getElementById("cardCategoryDescription");
        categoryDescriptionField.addEventListener("change", function (){
            const categoryDescription = categoryDescriptionField.value;
            //console.log(categoryName);
            cardCategoryDescription.innerText = categoryDescription === "" ?
                                    "Category description Here" : categoryDescription;
        });



        // front end validation
        function validate(){

        }

    </script>


    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/8.9.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.9.1/firebase-storage.js"></script>

    <!-- TODO: Add SDKs for Firebase products that you want to use
         https://firebase.google.com/docs/web/setup#available-libraries -->

   <%-- uploading image in firebase and--%>
    <script>
        // Your web app's Firebase configuration
        const firebaseConfig = {
            apiKey: "${firebaseApiKey}",
            authDomain: "fir-tutorial-one-74d1a.firebaseapp.com",
            databaseURL: "https://fir-tutorial-one-74d1a.firebaseio.com",
            projectId: "fir-tutorial-one-74d1a",
            storageBucket: "fir-tutorial-one-74d1a.appspot.com",
            messagingSenderId: "757955193464",
            appId: "1:757955193464:web:0374488198ec678344db8d"
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);

        console.log("firebase initialized.")


        // render the image file in image view
        const imageInputField = document.getElementById("inputCategoryLogo")
        const preview = document.getElementById("category-logo")

        imageInputField.addEventListener("change", function() {
            console.log("image selected for logo")
            if (this.files && this.files[0]) {

                uploadToFirebase(this.files[0], function (imageUrl){
                    /*const reader = new FileReader();

                    reader.onload = function(e) {

                    }

                    reader.readAsDataURL(file);*/
                    console.log("adding image url to src")
                    preview.setAttribute('src', imageUrl);
                });

            }
        });

        function uploadToFirebase(file, onUploadSuccess){
            const fileName = file.name;

            // Points to the root reference
            const storageRef = firebase.storage().ref();

            // Points to 'images'
            const imagesStorageRef = storageRef.child('images');

            // space ref where image will be stored
            const currentDate = new Date().getTime();
            const spaceRef = imagesStorageRef.child(currentDate+"-"+fileName);

            const uploadTask = spaceRef.put(file)
                .then(function (snapshot) {
                    console.info("image uploaded in firebase");
                    // Handle successful uploads on complete
                    // For instance, get the download URL: https://firebasestorage.googleapis.com/...
                    snapshot.ref.getDownloadURL().then((downloadURL) => {
                        console.log('File available at', downloadURL);

                        const logUrlInputField = document.querySelector("#logoUrl")
                        logUrlInputField.setAttribute("value", downloadURL);

                        onUploadSuccess(downloadURL);
                    });
                })


        }
    </script>
</div>
</body>
</html>
