<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Hasan Masum
  Date: 22-Jul-21
  Time: 8:09 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Login</title>
</head>
<body>

<div class="container position-absolute top-50 start-50 translate-middle">
    <div class="row justify-content-center align-items-center">
        <div class="col-md-4">
            <legend>Login</legend>

            <div class="mb-3">
                <c:if test="${error != null}">
                    <div class="alert alert-danger" role="alert">
                            ${error}
                    </div>
                </c:if>

                <c:if test="${verifiedFailed!=null}">
                    <div class="alert alert-danger" role="alert">
                            ${verifiedFailed}
                    </div>
                </c:if>


                <c:if test="${logout != null}">
                    <div class="alert alert-success" role="alert">
                            ${logout}
                    </div>
                </c:if>

                <c:if test="${VERIFICATION_SENT!= null}">
                    <div class="alert alert-success" role="alert">
                            ${VERIFICATION_SENT}
                    </div>
                </c:if>

                <c:if test="${VERIFICATION_SUCCESS!= null}">
                    <div class="alert alert-success" role="alert">
                            ${VERIFICATION_SUCCESS}
                    </div>
                </c:if>

                <c:if test="${NOT_VERIFIED!=null}">
                    <div class="alert alert-danger" role="alert">
                            ${NOT_VERIFIED}
                    </div>
                </c:if>


                <c:if test="${VERIFIED!=null}">
                    <div class="alert alert-danger" role="alert">
                            ${VERIFIED}
                    </div>
                </c:if>

                <c:if test="${VERIFICATION_FAILED!=null}">
                    <div class="alert alert-danger" role="alert">
                            ${VERIFICATION_FAILED}
                    </div>
                </c:if>


            </div>

            <form method="POST">

                <div class="mb-3">
                    <input type="text"
                                name="username"
                                class="form-control"
                                placeholder="Username"
                                autofocus="true" required/>
                </div>

                <div class="mb-3">
                    <input type="password"
                                name="password"
                                class="form-control"
                                placeholder="Password" required/>
                </div>

                <div class="d-grid gap-2 col-12 justify-content-auto">
                    <button class="btn btn-md btn-primary btn-block" type="submit">Login</button>
                </div>
            </form>
            <div class="mb-3" style="margin-top: 10px">>
                <a class="pe-auto text-primary" href="/auth/registration" >Not registered? Register here</a>
            </div>


        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</body>
</html>
