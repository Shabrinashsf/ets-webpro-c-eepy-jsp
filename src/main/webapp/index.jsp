<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
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
    <link rel="stylesheet" href="home.css" />
</head>

<body>
<!-- Navbar Start -->
<nav class="navbar">
    <div class="avatar">
        <img src="image/eepy.png" alt="avatar" width="96" height="54" />
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
        <h1>Welcome to Eepy Hotel</h1>
        <h2>Where Comfort Meets Serenity.</h2>
    </div>

    <div class="description">
        <p>
            Discover your perfect escape at Eepy Hotel, a cozy haven designed for
            dreamers and travelers alike. Nestled in the heart of the city, Eepy
            offers modern comfort, warm hospitality, and a touch of calm for every
            guest. Whether you’re here to unwind, explore, or simply take it
            easy—Eepy is where your rest feels effortless.
        </p>
    </div>

    <div class="reviews">
        <h1>What People Think About Us?</h1>
        <img src="image/reviewstar.png" alt="4.5/5 Stars" width="400px" />
        <h2>
            <span class="rate">4.5/5</span>
            <span class="rev">1000+ Reviews</span>
        </h2>

        <div class="rev-com">
            <div class="comment">
                <p>Comfortable</p>
            </div>

            <div class="comment">
                <p>Family Friendly</p>
            </div>

            <div class="comment">
                <p>Strategic Location</p>
            </div>

            <div class="comment">
                <p>Hygienic</p>
            </div>

            <div class="comment">
                <p>Great Services</p>
            </div>

            <div class="comment">
                <p>Beautiful View</p>
            </div>

            <div class="comment">
                <p>Delicious Food</p>
            </div>

            <div class="comment">
                <p>Fun Experiences</p>
            </div>

            <div class="comment">
                <p>Highly Recommended</p>
            </div>

            <div class="comment">
                <p>Best Choice</p>
            </div>
        </div>
    </div>

    <div class="location">
        <h1>Location</h1>
        <div class="loc-detail">
            <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d126646.20750916582!2d112.71268375!3d-7.275619450000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd7fbf8381ac47f%3A0x3027a76e352be40!2sSurabaya%2C%20Jawa%20Timur!5e0!3m2!1sid!2sid!4v1761069613875!5m2!1sid!2sid"
                    allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

            <div class="loc-desc">
                <div class="jalan">
                    <i data-feather="map-pin"></i>
                    <p>Jl. Lorem Ipsum dolor sit amet consectetur</p>
                </div>

                <div class="nearby-loc">
                    <div class="loc-title">
                        <i data-feather="map"></i>
                        <h2>Nearby Location</h2>
                    </div>
                    <li>Hospital</li>
                    <li>Mall</li>
                    <li>Zoo</li>
                    <li>University</li>
                    <li>School</li>
                    <li>Town Square</li>
                    <li>Street Food</li>
                </div>
            </div>
        </div>
    </div>

    <div class="facilities">
        <h1>All Facilities in Eepy Hotel</h1>
        <div class="group">
            <div class="box">
                <div class="fac-title">
                    <i data-feather="users"></i>
                    <h2>Public Facilities</h2>
                </div>
                <li>Parking lot</li>
                <li>Restaurant</li>
                <li>Meeting Room</li>
                <li>Fitness Center</li>
                <li>Pool</li>
            </div>

            <div class="box">
                <div class="fac-title">
                    <i data-feather="home"></i>
                    <h2>Room Facilities</h2>
                </div>
                <li>Mini Bar</li>
                <li>Refrigerator</li>
                <li>Television</li>
                <li>Bathtub</li>
                <li>Shower</li>
            </div>

            <div class="box">
                <div class="fac-title">
                    <i data-feather="globe"></i>
                    <h2>General Facilities</h2>
                </div>
                <li>AC</li>
                <li>Heater</li>
                <li>Free WiFi</li>
            </div>

            <div class="box">
                <div class="fac-title">
                    <i data-feather="clipboard"></i>
                    <h2>Hotel Services</h2>
                </div>
                <li>24-hours Room Services</li>
                <li>24-hours Receptionist</li>
                <li>Laundry Services</li>
            </div>
        </div>
    </div>

    <div class="policy">
        <h1>Accomodation Rules</h1>
        <div class="time">
            <i class="pol-icon" data-feather="clock"></i>
            <div class="checkin">
                <h3>Check In</h3>
                <p>From 14:00</p>
            </div>
            <div class="checkout">
                <h3>Check Out</h3>
                <p>Before 12:00</p>
            </div>
        </div>
        <div class="doc">
            <i class="pol-icon" data-feather="file-text"></i>
            <div class="pol-desc">
                <h3>Required Documents</h3>
                <p>Upon check-in, you are required to bring ID Card.</p>
            </div>
        </div>
        <div class="age">
            <i class="pol-icon" data-feather="user-check"></i>
            <div class="pol-desc">
                <h3>Minimum Age Policy</h3>
                <p>
                    Minimum age to check-in is 18. Minor guests must be accompanied by
                    adults upon check-in.
                </p>
            </div>
        </div>
    </div>
</main>
<!-- Main End -->

<!-- Footer Section -->
<footer>
    <div class="credit">
        <img src="image/eepy.png" alt="eepy logo" width="96" height="54" />
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
    window.contextPath = "${pageContext.request.contextPath}";
    window.images = [
        "${pageContext.request.contextPath}/image/home-hotel.jpg",
        "${pageContext.request.contextPath}/image/home-hotel2.jpeg",
        "${pageContext.request.contextPath}/image/home-hotel3.jpeg",
        "${pageContext.request.contextPath}/image/home-hotel4.jpeg",
        "${pageContext.request.contextPath}/image/home-hotel5.jpeg"
    ];
</script>
<script src="${pageContext.request.contextPath}/script.js"></script>
</body>

</html>