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
            <legend>Create New Account</legend>

            <form:form method="POST" modelAttribute="user" class="form-signin">

                <div class="mb-3">
                    <div>
                        <form:input type="text"
                                    path="username"
                                    class="form-control"
                                    placeholder="Username"
                                    autofocus="true"/>

                    </div>

                    <div style="margin-top: 5px">
                        <form:errors path="username" cssClass="alert alert-danger form-control"/>
                    </div>
                </div>

                <div class="mb-3">
                    <div>
                            <%--login field of a user--%>
                        <form:input type="text"
                                    path="login"
                                    class="form-control"
                                    placeholder="Email"
                                    autofocus="true"/>

                    </div>

                    <div style="margin-top: 5px">
                        <form:errors path="username" cssClass="alert alert-danger form-control"/>
                    </div>
                </div>

                <div class="mb-3">
                    <div>
                        <form:input type="password"
                                    path="password"
                                    class="form-control"
                                    placeholder="Password"/>
                    </div>

                    <div style="margin-top: 5px">
                        <form:errors path="password" cssClass="form-control alert alert-danger"/>
                    </div>
                </div>

                <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
            </form:form>

            <div class="mb-3" style="margin-top: 10px">
                <a href="/auth/login">Already have an account? Sign in here!</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
