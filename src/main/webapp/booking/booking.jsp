<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    // Ambil data yang dikirim dari BookingServlet
    Map<String, Object> data = (Map<String, Object>) request.getAttribute("data");

    if (data == null) {
        response.sendRedirect(request.getContextPath() + "/rooms");
        return;
    }

    // Format mata uang Rupiah
    NumberFormat formatter = NumberFormat.getNumberInstance(new Locale("in", "ID"));

    int userId = (int) data.get("user_id");
    String roomTypeId = (String) data.get("room_type_id");
    String roomName = (String) data.get("room_name");
    String checkin = (String) data.get("checkin");
    String checkout = (String) data.get("checkout");
    int pricePerNight = (int) data.get("price_per_night");
    long nights = (long) data.get("nights");
    long totalPrice = (long) data.get("total_price");
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/booking/booking.css" />
</head>

<body>
<!-- Main Section -->
<main>
    <form action="${pageContext.request.contextPath}/booking-store" method="POST">
        <!-- Asumsi Anda memiliki Servlet mapping /booking-store untuk menyimpan data -->
        <div class="booking">
            <div class="box">
                <div class="book-data">
                    <!-- Hidden fields untuk passing data -->
                    <input type="hidden" name="user_id" value="<%= userId %>">
                    <input type="hidden" name="room_type_id" value="<%= roomTypeId %>">
                    <input type="hidden" name="checkin" value="<%= checkin %>">
                    <input type="hidden" name="checkout" value="<%= checkout %>">
                    <input type="hidden" name="total_price" value="<%= totalPrice %>">

                    <div class="title">
                        <i data-feather="edit"></i>
                        <h1>Guest Data</h1>
                    </div>
                    <p>
                        Please fill in all fields correctly to receive your booking confirmation.
                    </p>

                    <div class="input-box">
                        <h2>Name</h2>
                        <input type="text" name="name" placeholder="Full Name" required />
                    </div>
                    <div class="input-box">
                        <h2>Phone Number</h2>
                        <input type="text" name="phone" placeholder="+62XXX" required />
                    </div>
                </div>
            </div>

            <div class="box">
                <div class="book-detail">
                    <div class="title">
                        <i data-feather="file-text"></i>
                        <h1>Booking Details</h1>
                    </div>

                    <div class="book-time">
                        <div class="box-check">
                            <p class="b-title">Check In</p>
                            <h2><%= checkin %></h2>
                            <p>From 2 PM</p>
                        </div>
                        <i data-feather="arrow-right"></i>

                        <div class="box-check">
                            <p class="b-title">Check Out</p>
                            <h2><%= checkout %></h2>
                            <p>Before 12 PM</p>
                        </div>
                    </div>

                    <div class="room-qty">
                        <h3>(1x) <%= roomName %></h3>
                        <h3><%= nights %> night(s) x Rp<%= formatter.format(pricePerNight) %></h3>
                    </div>

                    <div class="total">
                        <h2>Total Price :</h2>
                        <h2 class="price">Rp<%= formatter.format(totalPrice) %></h2>
                    </div>
                </div>
            </div>

            <div class="box">
                <div class="payment">
                    <div class="title">
                        <i data-feather="dollar-sign"></i>
                        <h1>Payment Methods</h1>
                    </div>

                    <div class="method">
                        <input type="radio" id="option-1" name="payment_method" value="VA" required/>
                        <input type="radio" id="option-2" name="payment_method" value="Bank" required/>
                        <input type="radio" id="option-3" name="payment_method" value="E-Money" required/>

                        <label for="option-1" class="option option-1">
                            <div class="dot"></div>
                            <span>VA</span>
                        </label>
                        <label for="option-2" class="option option-2">
                            <div class="dot"></div>
                            <span>Bank</span>
                        </label>
                        <label for="option-3" class="option option-3">
                            <div class="dot"></div>
                            <span>E-Money</span>
                        </label>
                    </div>

                    <div class="total">
                        <h2>Total Price :</h2>
                        <h2 class="price">Rp<%= formatter.format(totalPrice) %></h2>
                    </div>
                    <button type="submit" class="payment btn">
                        Book Now
                    </button>
                </div>
            </div>
        </div>
    </form>
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
<script src="${pageContext.request.contextPath}/script.js"></script>
</body>

</html>