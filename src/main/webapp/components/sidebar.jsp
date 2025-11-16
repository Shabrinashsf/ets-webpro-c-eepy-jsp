<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String profile = (String) request.getAttribute("profile");
    String orders = (String) request.getAttribute("orders");
    String active = (String) request.getAttribute("active");
    if (active == null) active = "";
%>

<script src="https://cdn.tailwindcss.com"></script>

<!-- Alpine.js -->
<script src="https://unpkg.com/alpinejs@3.12.0/dist/cdn.min.js" defer></script>

<div x-data="{ open: false }" class="relative">

    <!-- Hamburger (mobile only) -->
    <button
            @click="open = !open"
            class="lg:hidden fixed top-4 left-4 z-50 bg-[#2C0855] text-white p-2 rounded-md"
    >
        <i data-feather="menu"></i>
    </button>

    <!-- Overlay (mobile) -->
    <div
            x-show="open"
            @click="open = false"
            class="fixed inset-0 bg-black/40 z-40 lg:hidden"
            x-transition.opacity
    ></div>

    <!-- Sidebar -->
    <div
            class="admin-card w-[333px] bg-[#78b3ce] rounded-3xl text-white flex flex-col justify-between items-center p-8
               fixed top-0 left-0 z-50 h-screen transform transition-transform duration-300 ease-in-out
               -translate-x-full lg:relative lg:h-auto lg:translate-x-0"
            :class="{ '-translate-x-full': !open, 'translate-x-0': open }"
    >
        <div class="flex flex-col items-center">

            <!-- Logo -->
            <img src="${pageContext.request.contextPath}/image/eepy.png" alt="Logo" />

            <!-- Menu -->
            <div class="w-full mt-8">

                <%-- USER VERSION: Profile + Orders --%>
                <% if ("Profile".equals(profile) && "Orders".equals(orders)) { %>

                <a href="${pageContext.request.contextPath}/user/user_profile.jsp"
                   class="group flex items-center gap-4 py-3 px-5 rounded-[8px] transition
                       <%= "profile".equals(active)
                           ? "bg-[#fbf8ef] text-[#000000]"
                           : "text-white hover:bg-[rgba(242,242,242,0.3)]" %>">
                    <i data-feather="user"></i>
                    <span><%= profile %></span>
                </a>

                <a href="${pageContext.request.contextPath}/user/orders.jsp"
                   class="group flex items-center gap-4 py-3 px-5 rounded-[8px] transition
                       <%= "orders".equals(active)
                           ? "bg-[#fbf8ef] text-[#000000]"
                           : "text-white hover:bg-[rgba(242,242,242,0.3)]" %>">
                    <i data-feather="clipboard"></i>
                    <span><%= orders %></span>
                </a>

                <% } %>

                <%-- ADMIN VERSION: Users + Rooms --%>
                <% if ("Users".equals(profile) && "Rooms".equals(orders)) { %>

                <a href="${pageContext.request.contextPath}/admin/admin_profile.jsp?active=users"
                   class="group flex items-center gap-4 py-3 px-5 rounded-[8px] transition
                       <%= "users".equals(active)
                           ? "bg-[#fbf8ef] text-[#000000]"
                           : "text-white hover:bg-[rgba(242,242,242,0.3)]" %>">
                    <i data-feather="user"></i>
                    <span><%= profile %></span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/admin_profile.jsp?active=rooms"
                   class="group flex items-center gap-4 py-3 px-5 rounded-[8px] transition
                       <%= "rooms".equals(active)
                           ? "bg-[#fbf8ef] text-[#000000]"
                           : "text-white hover:bg-[rgba(242,242,242,0.3)]" %>">
                    <i data-feather="clipboard"></i>
                    <span><%= orders %></span>
                </a>

                <% } %>

            </div>

            <!-- Logout Button -->
            <form method="post" action="${pageContext.request.contextPath}/logout" class="w-full mt-8">
                <button
                        type="submit"
                        class="bg-white text-[#2C0855] py-3 px-6 rounded-[8px] font-semibold hover:bg-gray-100 transition flex gap-4 items-center w-full justify-center"
                >
                    <i data-feather="log-out"></i>
                    Logout
                </button>
            </form>
        </div>
    </div>
</div>
