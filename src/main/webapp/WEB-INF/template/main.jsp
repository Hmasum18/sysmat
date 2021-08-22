<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/font-awesome-5.15.3/css/all.css">

    <link rel="stylesheet" href="/css/card.css">

    <script src="/js/jquery-3.6.0.min.js"></script>

    <title>
        <sitemesh:write property='title'/> <%--write title of other page--%>
    </title>

    <sitemesh:write property='head'/> <%--include the head section of other page--%>

    <style>
        .link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>

<%-------------------------------------Header---------------------------------------%>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #02CD7C;">
    <div class="container">
        <a href="/" class="navbar-brand align-items-center" style="font-family: 'Roboto'; font-weight: bold">
            <i class="fas fa-tasks"></i>
            SysMat
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>



        <c:if test="${pageContext.request.userPrincipal.name != null}"> <%--check if user is logged in--%>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">

                    <%--if the user is admin--%>
                    <c:if test="${pageContext.request.userPrincipal.toString().contains(\"ROLE_ADMIN\")}">
                        <a class="nav-link active" aria-current="page" href="/admin/category/add">Add Category</a>
                        <a class="nav-link active" aria-current="page" href="/admin/category/">Categories</a>
                        <a class="nav-link active" aria-current="page" href="/admin/product/pending">Pending</a>
                    </c:if>

                       <%-- options for both user and admin--%>
                    <a class="nav-link active" aria-current="page" href="/user/product/add">Add product</a>
                    <a class="nav-link active" aria-current="page" href="/user/product/">My Products</a>
                    <a class="nav-link active" aria-current="page" href="">My account</a>
                </div>
            </div>

            <form class="d-flex" id="logoutForm" method="POST" action="/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button class="btn btn-sm btn-danger" type="submit">Logout</button>
            </form>

        </c:if>
        <c:if test="${pageContext.request.userPrincipal.name == null}">
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link active" aria-current="page" href="/auth/login">Login</a>
                    <a class="nav-link active" aria-current="page" href="/auth/registration">Register</a>
                </div>
            </div>
        </c:if>
    </div>
</nav>


<sitemesh:write property='body'/>

<%--------------------------------------Footer-------------------------------------------%>
<%--
<nav class="navbar fixed-bottom navbar-light" style="background-color: #69F0AE;">
    <div class="container-fluid" style="padding-left: 40%">
        <div style="padding-top: 15px; text-align: center; font-size: 14px">
            <p> © Sysmat 2021. All Rights Reserved</p>
        </div>
    </div>
</nav>
--%>


<%--<!-- Footer-->
<footer class="footer text-center">
    <div class="container">
        <div class="row">
            <!-- Footer Location-->
            <div class="col-lg-4 mb-5 mb-lg-0">
                <h4 class="text-uppercase mb-4">Location</h4>
                <p class="lead mb-0">
                    2215 John Daniel Drive
                    <br />
                    Clark, MO 65243
                </p>
            </div>
            <!-- Footer Social Icons-->
            <div class="col-lg-4 mb-5 mb-lg-0">
                <h4 class="text-uppercase mb-4">Around the Web</h4>
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-facebook-f"></i></a>
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-twitter"></i></a>
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-linkedin-in"></i></a>
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-dribbble"></i></a>
            </div>
            <!-- Footer About Text-->
            <div class="col-lg-4">
                <h4 class="text-uppercase mb-4">About Freelancer</h4>
                <p class="lead mb-0">
                    Freelance is a free to use, MIT licensed Bootstrap theme created by
                    <a href="http://startbootstrap.com">Start Bootstrap</a>
                    .
                </p>
            </div>
        </div>
    </div>
</footer>
<!-- Copyright Section-->
<div class="copyright py-4 text-center text-white">
    <div class="container"><small>Copyright &copy; Your Website 2021</small></div>
</div>--%>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</body>
</html>