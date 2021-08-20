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

            <form method="POST" class="form-signin">
                <div class="mb-3">
                    <div>
                        <input type="text"
                               name="username"
                               class="form-control"
                               placeholder="Username"
                               autofocus="true" required/>

                    </div>

                    <div style="margin-top: 5px">
                        <c:if test="${usernameError!=null}">
                            <div class="alert alert-danger" role="alert">
                                    ${usernameError}
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="mb-3">
                    <div>
                        <%--login field of a user--%>
                        <input type="text"
                               name="email"
                               class="form-control"
                               placeholder="Email"
                               autofocus="true" required/>

                    </div>

                    <div style="margin-top: 5px">
                        <c:if test="${emailError!=null}">
                            <div class="alert alert-danger" role="alert">
                                    ${emailError}
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="mb-3">
                    <div>
                        <input type="password"
                               name="password"
                               class="form-control"
                               placeholder="Password" required/>
                    </div>

                    <div style="margin-top: 5px">
                        <c:if test="${passwordError!=null}">
                            <div class="alert alert-danger" role="alert">
                                    ${passwordError}
                            </div>
                        </c:if>
                    </div>
                </div>

                <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
            </form>

            <div class="mb-3" style="margin-top: 10px">
                <a href="/auth/login">Already have an account? Sign in here!</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
