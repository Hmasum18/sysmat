<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Hasan Masum
  Date: 04-Aug-21
  Time: 12:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add product</title>
    <link rel="stylesheet" href="/css/add_product.css">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-4 col-sm-6">
            <form method="post">
                <div class="mb-3">
                    <label for="inputProductName" class="form-label">Product Name*</label>
                    <%--product name--%>
                    <input name="name"
                                type="text"
                                class="form-control"
                                id="inputProductName"
                                placeholder="Name" required>
                </div>

                <div class="mb-3">
                    <label for="inputProductPrice" class="form-label">Price*</label>
                    <%--product name--%>
                    <input name="price"
                           type="number"
                           class="form-control"
                           id="inputProductPrice"
                           placeholder="price" required>
                </div>

                <div class="mb-3">
                    <label for="inputProductDescription" class="form-label">Description*</label>
                    <%--product description--%>
                    <input name="description"
                                type="text"
                                class="form-control"
                                id="inputProductDescription"
                                placeholder="Description here" required>
                </div>

                <label for="inputProductCategory" class="form-label">Category*</label>
                <div class="mb-3">
                    <%--product category--%>
                    <select name="categoryId" id="inputProductCategory"
                                 class="form-select form-select-sm"
                                 aria-label=".form-select-sm example" required>

                        <c:forEach items="${categoryList}" var="product" varStatus="i">
                            <c:if test="${product.name.equalsIgnoreCase(\"book\")}">
                                <option selected value="${product.id}">${product.name}</option>
                            </c:if>
                            <c:if test="${!product.name.equalsIgnoreCase(\"book\")}">
                                <option value="${product.id}">${product.name}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="inputProductAddress" class="form-label">Location*</label>
                    <%--location--%>
                    <input name="location"
                                type="search"
                                class="form-control"
                                id="inputProductAddress"
                                placeholder="Location" required>
                    <div class="address-search">
                        <div class="address-autocomplete-box">
                        </div>
                    </div>

                </div>


                <div class="mb-3">
                    <label for="inputProductImage" class="form-label">Logo Image*</label>
                    <input name="logoFile"
                           type="file"
                           accept="image/*"
                           class="form-control form-control-sm"
                           id="inputProductImage" required/>
                    <div class="my-3">
                        <div class="progress">
                            <div id="imageUploadProgressBar" class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>

                    <%--Product.logo--%>
                    <input type="hidden" id="productImageUrl" name="images" value="">
                </div>

                <div class="mb-3">
                    <label for="inputContactNumber" class="form-label">Contact number*</label>
                    <input name="mobileNumbers"
                    type="number" class="form-control form-control-sm" id="inputContactNumber" required>
                </div>

                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>
        </div>

      <%--  <!--Profile Card 5-->
        &lt;%&ndash;https://codepen.io/halidaa/pen/GGZqqg&ndash;%&gt;
        <div class="col-md-3 mt-4 mx-4 product">
            <div class="product-card-body"
                 style="z-index: 0; transform: translate3d(0px, 0px, 0px) rotateX(0deg);"
                 tabindex="0">

                <img class="productCardImage" id="productCardImage" src="https://image.flaticon.com/icons/png/512/1170/1170577.png" alt="Product image">
                <div class="card-content">
                    <p class="category-name" id="productCardCategoryName">Category</p>
                    <h2 id="productCardProductName">Product name here</h2>
                    <p id="productCardPrice">0<b style="font-size: 1.5em;">৳</b></p>
                    <p id="productLocation" class="productLocation">Product location here</p>
                    <p class="read-more" id="productCardContactNumber">Contact here</p>
                    <div class="description">
                        <p id="productCardDescription">Product description here.</p>
                        <p class="date" id="productCardDate">Upload time</p>
                    </div>
                </div>
            </div>
        </div>--%>

        <%--https://bbbootstrap.com/snippets/bootstrap-ecommerce-item-products-list-description-and-rating-icons-83216490--%>

        <div class="col-md-6">
            <div class="card card-body">
                <div class="row media justify-content-center align-items-center align-items-lg-start text-center text-lg-left flex-column flex-lg-row">
                    <div class="col-md-3 mr-2 mb-3 mb-lg-0">
                        <img  id="productCardImage" src="/images/image-placeholder.png"
                              width="150" alt="Product Image">
                    </div>
                    <div class="col-md-6 media-body text-left ">
                        <h6 class="media-title font-weight-bold" id="productCardProductName">Product Name Here</h6>
                        <p id="productCardCategoryName" class="text-muted" >Phones</p>
                        <p id="productCardDescription" class="mb-3">Product description here.</p>
                        <p id="productLocation" class="mb-0 text-muted">location</p>
                    </div>
                    <div class="col-md-3">
                        <h3 id="productCardPrice" class="mb-0 font-weight-semibold">
                            <b style="font-size: 1.5em;">৳</b>000.00</h3>
                        <p id="productCardContactNumber" class="btn btn-outline-success mt-4 font-weight-bold">Contact here</p>
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

        // set product name to the card when changes
        $("#inputProductName").keyup(function(element){
            //console.log(element.target.value)
            let productName = element.target.value;
            productName = productName? productName : "Product name here";
            $('#productCardProductName').text(productName);
        })

        $("#inputProductPrice").keyup(function(element){
            let price = parseFloat(element.target.value);
            price = !isNaN(price) ? price: 0.00;
            //console.log(price);
            $("#productCardPrice").html("<b style=\"font-size: 1.5em;\">৳</b>"+price);
        })


        $("#inputProductDescription").keyup(function(element){
            let productDes = element.target.value;
            productDes= productDes? productDes : "Product description here";
            $('#productCardDescription').html(productDes);
        })

        // set product card category name
        const currentText = $("#inputProductCategory").find(":selected").text();
        $("#productCardCategoryName").html(currentText)

        $("#inputProductCategory").change(function (){
            const currentText = $(this).find(":selected").text();
            $("#productCardCategoryName").html(currentText)
        })

        $("#inputProductAddress").change(function(element){
            let location = element.target.value;
            location= location? location : "Product location here";
            $('#productLocation').html(location);
        })

        $("#inputContactNumber").keyup(function(element){
            let contact = element.target.value;
            contact= contact? contact : "Contact here";
            $('#productCardContactNumber').html(contact);
        })

        $("#productCardDate").html(new Date())

    </script>


    <%-- uploading image in firebase and--%>



    <%--address auto complete--%>
    <script>
        //tutorial
        // https://www.youtube.com/watch?v=QxMBHi_ZiT8
        const addressSearchInputWrapper = document.querySelector(".address-search");
        const locationInputBox = document.querySelector("#inputProductAddress")
        const autoCompleteBox = document.querySelector(".address-autocomplete-box");


        locationInputBox.onkeyup = function (element){
            //console.log(event.target.value);
            let addressInputText = element.target.value;
            if(addressInputText){
                fetchLocationFromGeoapify(addressInputText);
                addressSearchInputWrapper.classList.add("active");
            }else{
                addressSearchInputWrapper.classList.remove("active");
            }
        }

        /* function onSearchTextChange(input){
             if(input.value == "") {
                 alert("You either clicked the X or you searched for nothing.");
             }
             else {
                 fetchLocationFromGeoapify(input.value)
                 alert("You searched for " + input.value);
             }
         }*/

        function fetchLocationFromGeoapify(locationQueryString){
            const requestOptions = {
                method: 'GET',
            };

            const apiKey = "${geoapifyApiKey}";
            const url = "https://api.geoapify.com/v1/geocode/autocomplete?text="+locationQueryString+"&apiKey="+apiKey;

            fetch(url, requestOptions)
                .then(response => response.json())
                .then(function(result){
                    //console.log(result);
                    parseLocationInfo(result);

                }).catch(error => console.log('error', error));
        }

        function parseLocationInfo(result){
            const features = result["features"];
            //console.log(features);

            let addressList = [];
            for(let i = 0 ; i<features.length ; i++){
                const feature = features[i];
                //console.log(feature);

                addressList.push(feature["properties"]["formatted"]);
            }
            //console.log(addressList);
            addressList = addressList.map( function (data){
                return "<li>"+ data + "</li>"
            })
            showAddressSuggestions( addressList);
        }

        function showAddressSuggestions(addressList){
            addressList = ["<li>"+locationInputBox.value+"</li>"].concat(addressList);
            if(addressList.length){
                addressList = addressList.join('')
                autoCompleteBox.innerHTML = addressList;
            }

            let allAddressListItemList = autoCompleteBox.querySelectorAll('li');
            for (let i = 0; i < allAddressListItemList.length; i++) {
                const addressListItem = allAddressListItemList[i];
                addressListItem.setAttribute("onclick", "onSelectAddress(this)");
            }
        }

        function onSelectAddress(element){
            let address = element.textContent;
            locationInputBox.value = address;
            addressSearchInputWrapper.classList.remove("active"); // hide auto complete
            $("#productLocation").html(address)
        }

        /*  locationText.addEventListener("change", function (e){
              const url = "https://api.geoapify.com/v1/geocode/autocomplete?text="++"&apiKey="+apiKey;

              fetch(url, requestOptions)
                  .then(response => response.json())
                  .then(result => console.log(result))
                  .catch(error => console.log('error', error));
          })*/

    </script>

    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/8.9.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.9.1/firebase-storage.js"></script>

    <!--  https://firebase.google.com/docs/web/setup#available-libraries -->
    <script>
        // Your web app's Firebase configuration
        const firebaseConfig = {
            apiKey: "${firebaseApiKey}",
            authDomain: "${firebaseProjectId}"+".firebaseapp.com",
            databaseURL: "${firebaseProjectId}" +".firebaseio.com",
            projectId:  "${firebaseProjectId}",
            storageBucket:  "${firebaseProjectId}"+".appspot.com",
            messagingSenderId: "${messagingSenderId}",
            appId: "${firebaseAppId}"
        };
        //console.log(firebaseConfig)
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);

        //console.log("firebase initialized.")
        // render the image file in image view
        const imageInputField = document.querySelector("#inputProductImage")
        const preview = document.querySelector("#productCardImage")
        const hiddenImageUrlHolderInputField = document.querySelector("#productImageUrl");
        onImageSelected(imageInputField, preview, hiddenImageUrlHolderInputField);


        function onImageSelected(inputImageField, previewImg, imageUrlHolderHiddenInputField){
            const funcName = "onImageSelected(): ";
            console.log(funcName);
            inputImageField.addEventListener("change", function() {
                console.log(funcName+"image selected for logo")
                if (this.files && this.files[0]) {
                    uploadToFirebase(this.files[0],function (imageUrl){
                        console.log(funcName+"adding image url to src")
                        imageUrlHolderHiddenInputField.setAttribute("value", imageUrl);
                        previewImg.setAttribute('src', imageUrl);
                    });
                }
            });
        }

        function uploadToFirebase(file ,onUploadSuccess){
            const fileName = file.name;

            // Points to the root reference
            const storageRef = firebase.storage().ref();

            // Points to 'images'
            const imagesStorageRef = storageRef.child('images');

            // space ref where image will be stored
            const currentDate = new Date().getTime();
            const spaceRef = imagesStorageRef.child(currentDate+"-product-"+fileName);

            const uploadTask = spaceRef.put(file);
            /* .then(function (snapshot) {
                 console.info("image uploaded in firebase");
                 // Handle successful uploads on complete
                 // For instance, get the download URL: https://firebasestorage.googleapis.com/...
                     uploadTask.snapshot.ref.getDownloadURL().then((downloadURL) => {
                     console.log('File available at', downloadURL);

                     const logUrlInputField = document.querySelector("#logoUrl")
                     logUrlInputField.setAttribute("value", downloadURL);

                     onUploadSuccess(downloadURL);
             })*/


            uploadTask.on('state_changed',
                (snapshot) => {
                    // Observe state change events such as progress, pause, and resume
                    // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
                    let progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                    console.log('Upload is ' + progress + '% done');
                    const imageUploadProgressBar = document.querySelector("#imageUploadProgressBar");
                    imageUploadProgressBar.setAttribute("style","width: "+progress+"%;");
                    imageUploadProgressBar.setAttribute("aria-valuenow", progress+"");
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
