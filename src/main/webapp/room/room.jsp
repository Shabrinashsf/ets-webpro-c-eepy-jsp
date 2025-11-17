<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    int userID = (int) session.getAttribute("userID");

    List<String> rawImagePaths = java.util.Arrays.asList(
            "/image/standard1.jpeg",
            "/image/deluxe1.jpeg",
            "/image/suite1.jpeg",
            "/image/pres2.jpeg"
    );
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eepy.eepy.model.RoomType" %>

<%
    List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
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
    <!-- 300, 400, 500, 700, 800 -->

    <!-- Icons -->
    <script src="https://unpkg.com/feather-icons"></script>

    <!-- Style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/room/room.css" />
</head>

<body>
<!-- Navbar Start -->
<nav class="navbar">
    <div class="avatar">
        <img src="${pageContext.request.contextPath}/image/eepy.png" alt="avatar" width="96" height="54" />
    </div>

    <div class="navbar-title">
        <a href="${pageContext.request.contextPath}/index.jsp">Homepage</a>
        <a href="${pageContext.request.contextPath}/rooms">Room</a>
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
    <div class="background">
        <div class="bg-layer layer1"></div>
        <div class="bg-layer layer2"></div>
    </div>

    <div class="hero">
        <h1>When do you want to relax?</h1>
        <div class="datepicker">
            <input type="text" placeholder="Select date" />
            <div class="calendar" hidden>
                <div class="left-side">
                    <div class="controls">
                        <button class="prev"><i data-feather="arrow-left"></i></button>
                        <strong class="label"></strong>
                    </div>
                    <div class="days">
                        <span>Su</span>
                        <span>Mo</span>
                        <span>Tu</span>
                        <span>We</span>
                        <span>Th</span>
                        <span>Fr</span>
                        <span>Sa</span>
                    </div>
                    <div class="dates"></div>
                </div>

                <div class="right-side">
                    <div class="controls">
                        <button class="next"><i data-feather="arrow-right"></i></button>
                        <strong class="label"></strong>
                    </div>
                    <div class="days">
                        <span>Su</span>
                        <span>Mo</span>
                        <span>Tu</span>
                        <span>We</span>
                        <span>Th</span>
                        <span>Fr</span>
                        <span>Sa</span>
                    </div>
                    <div class="dates"></div>
                </div>

                <div class="action-menu">
                    <span class="selection"></span>

                    <button class="cancel">Cancel</button>
                    <button class="apply">Apply</button>
                </div>
            </div>
        </div>
        <input type="hidden" id="selectedCheckin" value="">
        <input type="hidden" id="selectedCheckout" value="">
    </div>

    <div class="types">
        <%
            int currentImageIndex = 0;
            for(RoomType room : roomTypes) {
        %>
        <div class="box">
            <div class="<%= room.getName().toLowerCase() %>">
                <h1><%= room.getName() %> Room</h1>
                <p class="price">Rp<%= room.getPrice() %>/night</p>

                <div class="room-detail">
                    <img src="${pageContext.request.contextPath}<%= rawImagePaths.get(currentImageIndex) %>"
                         alt="<%= room.getName() %>" width="300px"/>

                    <div class="desc-info">
                        <div class="room-desc">
                            <h2>Description</h2>
                            <p><%= room.getDescription() %></p>
                        </div>
                        <div class="room-info">
                            <h2>Room Information</h2>
                            <div class="content">
                                <div class="area">
                                    <i data-feather="maximize"></i>
                                    <p><%= room.getArea() %> sqm</p>
                                </div>
                                <div class="capac">
                                    <i data-feather="users"></i>
                                    <p><%= room.getCapacity() %> people</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="room-fac">
                        <div class="room-fac-title"><h2>Facilities</h2></div>
                        <ul class="room-fac-list">
                            <% for(String fac : room.getFacilities()) { %>
                            <li><%= fac %></li>
                            <% } %>
                        </ul>
                    </div>
                </div>

                <div class="avail">
                    <p>Only available rooms displayed</p>
                    <button class="btn choose-btn" data-roomid="<%= room.getId() %>" data-roomname="<%= room.getName() %>" data-price="<%= room.getPrice() %>" data-userid="<%= userID %>">
                        Choose
                    </button>
                </div>
            </div>
        </div>
        <%
                currentImageIndex++;
                if (currentImageIndex >= rawImagePaths.size()) {
                    currentImageIndex = 0;
                }
            }
        %>
    </div>
</main>
<!-- Main End -->

<!-- Footer Section -->
<footer>
    <div class="credit">
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
<script>
    window.images = [
        "${pageContext.request.contextPath}/image/home-hotel.jpg",
        "${pageContext.request.contextPath}/image/home-hotel2.jpeg",
        "${pageContext.request.contextPath}/image/home-hotel3.jpeg",
        "${pageContext.request.contextPath}/image/home-hotel4.jpeg",
        "${pageContext.request.contextPath}/image/home-hotel5.jpeg"
    ];
    window.contextPath = '<%= request.getContextPath() %>';
    window.bookingPath = '<%= request.getContextPath() %>/booking';
</script>
<script src="${pageContext.request.contextPath}/script.js"></script>
</body>

</html>