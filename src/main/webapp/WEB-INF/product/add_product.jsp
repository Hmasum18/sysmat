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
    <div class="row justify-content-center align-items-center">
        <div class="col-md-4 col-sm-6">
            <form:form modelAttribute="product" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="inputCategoryName" class="form-label">Product Name*</label>
                    <form:input path="name" name="name"
                                type="text"
                                class="form-control"
                                id="inputCategoryName"
                                placeholder="Name   "/>
                </div>

                <div class="mb-3">
                    <label for="inputCategoryDescription" class="form-label">Description*</label>
                    <form:input path="description" name="description"
                                type="text"
                                class="form-control"
                                id="inputCategoryDescription"
                                placeholder="Description here"/>
                </div>

                <label for="selectCategory" class="form-label">Category*</label>
                <div class="mb-3">
                    <form:select path="category" name="category" id="selectCategory"
                                 class="form-select form-select-sm"
                                 aria-label=".form-select-sm example">
                        <option selected>None</option>
                        <c:forEach items="${categoryList}" var="category" varStatus="i">
                            <form:option value="${category}">${category.name}</form:option>
                        </c:forEach>
                    </form:select>
                </div>

                <div class="mb-3">
                    <label for="address-input" class="form-label">Location*</label>
                    <input name="location"
                                type="search"
                                class="form-control"
                                id="address-input"
                                placeholder="Location"/>
                    <div class="address-search">
                        <div class="address-autocomplete-box">
                            <li>Dhaka</li>
                            <li>Chittagong</li>
                        </div>
                    </div>

                </div>


                <div class="mb-3">
                    <label for="inputCategoryLogo" class="form-label">Logo Image*</label>
                    <input name="logoFile"
                           type="file"
                           accept="image/*"
                           class="form-control form-control-sm"
                           id="inputCategoryLogo" required/>
                </div>

                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form:form>

        </div>


        <!--Profile Card 5-->
        <%--https://codepen.io/halidaa/pen/GGZqqg--%>
        <div class="col-md-3 mt-4 mx-4" id="product">
            <div class="product-card-body"
                 style="z-index: 0; transform: translate3d(0px, 0px, 0px) rotateX(0deg);"
                 tabindex="0">

                <img id="productCardImage" src="https://image.flaticon.com/icons/png/512/1170/1170577.png" alt="Product image">
                <div class="card-content">
                    <p class="category-name">Category</p>
                    <h2>Product name here</h2>
                    <p id="productLocation">Location</p>
                    <p class="date">Upload time</p>
                    <div class="description">
                        <p>Product description here.</p>
                        <p>The post
                            <a href="https://www.soompi.com/article/1481537wpp/9-k-pop-songs-that-incorporated-sign-language-in-their-performance">
                                9 K-Pop Songs That Incorporated Sign Language In Their Performance</a>
                            appeared first on <a href="https://www.soompi.com">Soompi</a></p>
                        <p class="read-more"><a target="_blank" rel="noreferrer noopener"
                                                href="https://www.soompi.com/article/1481537wpp/9-k-pop-songs-that-incorporated-sign-language-in-their-performance">Read
                            Full Article</a></p>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <%--address auto complete--%>
    <script>
        //tutorial
        // https://www.youtube.com/watch?v=QxMBHi_ZiT8
        const addressSearchInputWrapper = document.querySelector(".address-search");
        const locationInputBox = document.querySelector("#address-input")
        const autoCompleteBox = document.querySelector(".address-autocomplete-box");


        locationInputBox.onkeyup = function (event){
            //console.log(event.target.value);
            let addressInputText = event.target.value;
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

            const apiKey = "853bc30cff9d4c3ab95943bb921a7ce1";
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
            console.log(features);

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

           // console.log(addressList);

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
        }

      /*  locationText.addEventListener("change", function (e){
            const url = "https://api.geoapify.com/v1/geocode/autocomplete?text="++"&apiKey="+apiKey;

            fetch(url, requestOptions)
                .then(response => response.json())
                .then(result => console.log(result))
                .catch(error => console.log('error', error));
        })*/


    </script>


    <script>
        $("#product .product-card-body").click(function () {
            $(this).find(".card-content").toggleClass("open");
        })

        //https://awesomeopensource.com/project/algolia/places
        //https://www.algolia.com/apps/VG3P3EKYOE/api-keys/all


    </script>


</div>
</body>
</html>
