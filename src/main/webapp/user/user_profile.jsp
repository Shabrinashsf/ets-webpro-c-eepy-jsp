<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    // Hanya user yang boleh masuk
    if (userRole == null || !"user".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String active = request.getParameter("active");
    if (active == null) active = "profile";

    request.setAttribute("profile", "Profile");
    request.setAttribute("orders", "Orders");
    request.setAttribute("active", active);
    request.setAttribute("sidebarOpen", "true");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Eepy Hotel</title>

    <!-- Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,700;0,800;1,300;1,400;1,500;1,700;1,800&display=swap"
            rel="stylesheet" />

    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- 300, 400, 500, 700, 800 -->

    <!-- Icons -->
    <script src="https://unpkg.com/feather-icons"></script>

    <!-- HTMX -->
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>

    <!-- Alpine.js -->
    <script src="https://unpkg.com/alpinejs@3.12.0/dist/cdn.min.js" defer></script>

    <!-- Style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home.css" />
</head>

<body x-data="{ showEdit: false, editingUser: {} }">
<!-- Navbar Start -->
<nav class="navbar">
    <div class="avatar">
        <img src="${pageContext.request.contextPath}/image/eepy.png" alt="avatar" width="96" height="54" />
    </div>

    <div class="navbar-title">
        <a href="${pageContext.request.contextPath}/index.jsp">Homepage</a>
        <a href="${pageContext.request.contextPath}/room/room.jsp">Room</a>
    </div>

    <div>
        <% if (userName != null && "user".equals(userRole)) { %>
        <!-- USER NORMAL -->
        <div class="profile">
            <a href="${pageContext.request.contextPath}/user/user_profile.jsp" id="user">
                <i data-feather="user"></i>
                <span class="text-black"><%= userName %></span>
            </a>
        </div>
        <% } else if (userName != null && "admin".equals(userRole)) { %>
        <!-- ADMIN -->
        <div class="profile">
            <a href="${pageContext.request.contextPath}/admin/admin_profile.jsp" id="user">
                <i data-feather="user"></i>
                <span class="text-black"><%= userName %> (Admin)</span>
            </a>
        </div>
        <% } else { %>
        <!-- BELUM LOGIN -->
        <div class="sign">
            <a href="${pageContext.request.contextPath}/login/login.jsp" class="btn white-login" id="loginbtn">Login</a>
            <a href="${pageContext.request.contextPath}/register/register.jsp" class="btn" id="registbtn">Register</a>
        </div>
        <% } %>

        <div class="hamburger">
            <a href="#" id="ham-menu"><i data-feather="menu"></i></a>
        </div>
    </div>

    <!-- Sidebar muncul di mobile/tablet -->
    <div class="sidebar" id="sidebar">
        <a href="${pageContext.request.contextPath}/index.jsp">Homepage</a>
        <a href="${pageContext.request.contextPath}/room/room.jsp">Room</a>
        <div class="side-sign">
            <button class="btn white-login" id="side-login">Login</button>
            <button class="btn" id="side-register">Register</button>
            <a href="#" id="side-profile" class="side-profile"><i data-feather="user"></i></a>
        </div>
    </div>
</nav>
<!-- Navbar End -->

<!-- Main Section -->
<main>
    <div class="min-h-screen w-full px-[100px] flex flex-col items-center justify-center" data-aos="fade-up"
         data-aos-duration="1000">
        <div class="flex justify-center items-start w-full gap-8">

            <!-- Sidebar include -->
            <jsp:include page="../components/sidebar.jsp" />

            <% if ("profile".equals(active)) { %>
            <%--            <div id="users-table" hx-get="/admin/users" hx-trigger="load" hx-swap="innerHTML"></div>--%>
            <jsp:include page="../user/profile.jsp" />
            <% } else if ("orders".equals(active)) { %>
            <%--            <div hx-get="/admin/admin_profile.jsp?active=rooms" hx-trigger="load" hx-swap="innerHTML"></div>--%>
            <jsp:include page="../user/order.jsp" />
            <% } %>
        </div>
    </div>
</main>
<!-- Main End -->

<!-- Footer Section -->
<footer>
    <div class="credit flex flex-col justify-center items-center">
        <img src="${pageContext.request.contextPath}/image/eepy.png" alt="eepy logo" width="96" height="54" />
        <p>Created by Neb & Shab | &copy; 2025</p>
    </div>
</footer>
<!-- Footer End -->

<!-- Icons -->
<script>
    feather.replace();
</script>

<!-- JS -->
<script src="${pageContext.request.contextPath}/script.js"></script>
</body>

</html>
