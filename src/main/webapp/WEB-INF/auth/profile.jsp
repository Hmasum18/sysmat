<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
</head>
<body>

<div class="container position-absolute top-50 start-50 translate-middle">
    <div class="row justify-content-center align-items-center">
        <div class="col-md-4">
            <legend>Edit profile</legend>

            <label for="inputUserName" class="form-label">Username</label>

            <input class="form-control"
                   type="text"
                   id="inputUserName"
                   placeholder="${user.username}" readonly>

            <label for="inputEmailName" class="form-label mt-3">Email</label>
            <input class="form-control"
                   type="text"
                   id="inputEmailName"
                   placeholder="${user.email}" readonly>

            <form method="post" class="my-3" id="userProfileForm">

                <input type="hidden" name="id" value="${userProfile.id}">

                <div class="mb-3">
                    <input type="text"
                           name="address"
                           class="form-control"
                           placeholder="Address"
                           value="${userProfile.address}"
                           />
                </div>

                <div class="mb-3">
                        <%--contact field of a profile--%>
                        <input type="number"
                               name="contact"
                               class="form-control"
                               placeholder="Contact(Number only)"
                               value="${userProfile.contact}"
                        />
                </div>

                <div class="mb-3">
                    <input id="newPassword" type="password"
                           name="newPassword"
                           class="form-control"
                           placeholder="New password"/>
                </div>

                <div class="mb-3">
                    <div>
                        <input id="currentPassword" type="password"
                               name="currentPassword"
                               class="form-control"
                               placeholder="Current password(required)" required/>
                    </div>

                    <div style="margin-top: 5px">
                        <c:if test="${passwordError!=null}">
                            <div class="alert alert-danger" role="alert">
                                    ${passwordError}
                            </div>
                        </c:if>
                    </div>
                </div>

                <button class="btn btn-lg btn-primary btn-block" type="submit">Update</button>
            </form>

        </div>
    </div>
</div>

<script>
   $().ready(function() {
       $('#userProfileForm').validate({
           rules : {
               contact : {
                 number: true
               },
               newPassword: {
                   minlength: 6,
               },
           },
           messages: {
               contact : {
                   number: "Only numbers are allowed"
               },
               newPassword: {
                   minlength: "Your password must be at least 6 characters long."
               }
           }
       });

   });
</script>

</body>
</html>
