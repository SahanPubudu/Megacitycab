<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Dashboard - Meca City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts for Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f4f4;
            background-image: url('assert/japanese-bg.png'); /* Japanese-inspired background */
            background-size: cover;
            background-position: center;
            margin: 0;
            padding: 0;
        }
        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .t1-header {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .page_header_sub_wrapper {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .company_logo h1 {
            font-size: 2rem;
            color: #e74c3c;
            margin: 0;
        }
        .page_search_bar input {
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 10px;
            width: 300px;
        }
        .user_indicator {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .user_indicator img {
            width: 25px;
            height: 25px;
        }
        .user_indicator a {
            color: #e74c3c;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .user_indicator a:hover {
            color: #c0392b;
        }
        .tab-btn-main-wrapper {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .tab-btn-main-wrapper button {
            background-color: #e74c3c;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .tab-btn-main-wrapper button:hover {
            background-color: #c0392b;
        }
        .w3-container.city {
            display: none;
            margin-top: 20px;
        }
        .w3-container.city h2 {
            color: #e74c3c;
            margin-bottom: 20px;
        }
        .table-container {
            overflow-x: auto;
        }
        .table-container table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .table-container th, .table-container td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .table-container th {
            background-color: #e74c3c;
            color: white;
        }
        .table-container td img {
            max-width: 100px;
            border-radius: 10px;
        }
        .btn, .btn1 {
            background-color: #e74c3c;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn:hover, .btn1:hover {
            background-color: #c0392b;
        }
        .form-container {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            flex: 1;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ddd;
            margin-bottom: 10px;
        }
        .page_footer {
            background-color: rgba(0, 0, 0, 0.8);
            color: #e0e0e0;
            padding: 20px;
            border-radius: 15px;
            margin-top: 20px;
        }
        .footer_main_wrapper {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }
        .container_one {
            flex: 1;
        }
        .container_one h2, .container_one h3 {
            color: #e74c3c;
        }
        .container_one input {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ddd;
            margin-bottom: 10px;
        }
        .container_one button {
            background-color: #e74c3c;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .container_one button:hover {
            background-color: #c0392b;
        }
        #footer_copyright {
            text-align: center;
            margin-top: 20px;
            color: rgba(255, 255, 255, 0.8);
        }
    </style>
    <script>
        function openCity(cityName) {
            var i;
            var x = document.getElementsByClassName("city");
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            document.getElementById(cityName).style.display = "block";
        }

        function deleteBooking(bookingId) {
            if (confirm("Are you sure you want to delete this booking?")) {
                fetch("DeleteBookingServlet?id=" + bookingId)
                    .then(response => response.text())
                    .then(data => {
                        if (data.trim() === "success") {
                            alert("Booking deleted successfully");
                            let bookingRow = document.getElementById("booking-" + bookingId);
                            if (bookingRow) {
                                bookingRow.remove();
                            } else {
                                alert("Booking row not found in the table.");
                            }
                        } else if (data.trim().startsWith("error")) {
                            alert("Server error: " + data);
                        } else {
                            alert("Error deleting booking");
                        }
                    })
                    .catch(error => console.error("Fetch error:", error));
            }
        }
    </script>
</head>
<body>
    <div class="admin-container">
        <!-- Header Section -->
        <div class="t1-header">
            <div class="page_header">
                <div class="page_header_sub_wrapper">
                    <div class="company_logo">
                        <h1>MegaCab</h1>
                    </div>
                    <div class="page_search_bar">
                        <div class="pgs_main_wrapper">
                            <input type="search" placeholder="Search for anything...." name="" id="">
                            <div class="search_icon">
                                <img src="assert/search.png" alt="" width="20" height="20">
                            </div>
                        </div>
                    </div>
                    <div class="user_indicator">
                        <img src="assert/online-shopping.png" width="25" height="25" alt="">
                        <img src="assert/heart.png" width="25" height="25" alt="">
                        <img src="assert/user.png" width="25" height="25" alt="">
                        <p id="u_name">Admin</p>
                        <a href="logout.jsp">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Body Section -->
        <div class="hero">
            <div class="admin-dash-main-wrapper">
                <div class="admin-dash-left-wrapper">
                    <div class="tab-btn-main-wrapper">
                        <button class="w3-bar-item w3-button" onclick="openCity('London')">Manage Vehicles</button>
                        <button class="w3-bar-item w3-button" onclick="openCity('Paris')">Manage Rents</button>
                        <button class="w3-bar-item w3-button" onclick="openCity('Tokyo')">Add Vehicle</button>
                    </div>

                    <!-- Manage Vehicles Section -->
                    <div id="London" class="w3-container city">
                        <h2>Manage Vehicles</h2>
                        <div class="table-container">
                            <table>
                                <tr>
                                    <th>Vehicle ID</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Model</th>
                                    <th>License Plate</th>
                                    <th>Type</th>
                                    <th>Rent (LKR)</th>
                                    <th>Actions</th>
                                </tr>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/megacab", "root", "root");
                                        java.sql.PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicles");
                                        java.sql.ResultSet rs = pst.executeQuery();
                                        
                                        while (rs.next()) {
                                            int vehicleId = rs.getInt("vehicle_id");
                                            String name = rs.getString("vehicle_name");
                                            String model = rs.getString("vehicle_model");
                                            String licensePlate = rs.getString("vehicle_number");
                                            String type = rs.getString("vehicle_type");
                                            double rent = rs.getDouble("vehicle_rent");
                                            byte[] imgData = rs.getBytes("vehicle_image");
                                            String base64Image = "";
                                            if (imgData != null) {
                                                base64Image = "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(imgData);
                                            }
                                %>
                                <tr>
                                    <td><%= vehicleId %></td>
                                    <td>
                                        <% if (!base64Image.isEmpty()) { %>
                                            <img src="<%= base64Image %>" alt="Vehicle Image" width="100">
                                        <% } else { %>
                                            No Image
                                        <% } %>
                                    </td>
                                    <td><%= name %></td>
                                    <td><%= model %></td>
                                    <td><%= licensePlate %></td>
                                    <td><%= type %></td>
                                    <td><%= rent %></td>
                                    <td>
                                        <button class="btn"><a href="edit_vehicle.jsp?id=<%= vehicleId %>">Edit</a></button>
                                        <button class="btn1"><a href="delete_vehicle.jsp?id=<%= vehicleId %>">Delete</a></button>
                                    </td>
                                </tr>
                                <%
                                        }
                                        con.close();
                                    } catch (Exception e) {
                                        out.println("Error: " + e.getMessage());
                                    }
                                %>
                            </table>
                        </div>
                    </div>

                    <!-- Manage Rents Section -->
                    <div id="Paris" class="w3-container city" style="display:none">
                        <h2>Manage Rents</h2>
                        <div class="table-container">
                            <table>
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Full Name</th>
                                    <th>Phone</th>
                                    <th>Email</th>
                                    <th>From</th>
                                    <th>To</th>
                                    <th>Vehicle</th>
                                    <th>Price (LKR)</th>
                                    <th>Actions</th>
                                </tr>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/megacab", "root", "root");
                                        java.sql.PreparedStatement pst = con.prepareStatement("SELECT * FROM checkout");
                                        java.sql.ResultSet rs = pst.executeQuery();
                                        
                                        while (rs.next()) {
                                            int bookingId = rs.getInt("id");
                                            String fullName = rs.getString("full_name");
                                            String phone = rs.getString("phone");
                                            String email = rs.getString("email");
                                            String fromLocation = rs.getString("from_location");
                                            String toLocation = rs.getString("to_location");
                                            String vehicleModel = rs.getString("vehicle_model");
                                            double rentPrice = rs.getDouble("rent_price");
                                %>
                                <tr id="booking-<%= bookingId %>">
                                    <td><%= bookingId %></td>
                                    <td><%= fullName %></td>
                                    <td><%= phone %></td>
                                    <td><%= email %></td>
                                    <td><%= fromLocation %></td>
                                    <td><%= toLocation %></td>
                                    <td><%= vehicleModel %></td>
                                    <td><%= rentPrice %></td>
                                    <td>
                                        <button onclick="deleteBooking(<%= bookingId %>)">Delete</button>
                                    </td>
                                </tr>
                                <%
                                        }
                                        con.close();
                                    } catch (Exception e) {
                                        out.println("Error: " + e.getMessage());
                                    }
                                %>
                            </table>
                        </div>
                    </div>

                    <!-- Add Vehicle Section -->
                    <div id="Tokyo" class="w3-container city" style="display:none">
                        <h2>Add Vehicle</h2>
                        <form action="AddVehicleServlet" method="post" enctype="multipart/form-data">
                            <div class="form-container">
                                <div class="form-group">
                                    <label>Vehicle Name:</label>
                                    <input type="text" name="name" required>
                                    <label>Vehicle Model:</label>
                                    <input type="text" name="model" required>
                                    <label>Vehicle Number:</label>
                                    <input type="text" name="number" required>
                                </div>
                                <div class="form-group">
                                    <label>Vehicle Type:</label>
                                    <input type="text" name="type" required>
                                    <label>Rent per Day:</label>
                                    <input type="number" name="rent" step="0.01" required>
                                    <label>Vehicle Image:</label>
                                    <input type="file" name="image" accept="image/*" required>
                                </div>
                            </div>
                            <button type="submit">Add Vehicle</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer Section -->
        <div class="page_footer">
            <div class="footer_Section">
                <div class="footer_main_wrapper">
                    <div class="container_one">
                        <h2>MegaCab</h2>
                        <h3>Subscribe</h3>
                        <p>Get 10% off your first ride</p>
                        <input type="email" placeholder="Enter your email">
                        <button>Subscribe</button>
                    </div>
                    <div class="container_one flexgrow_one">
                        <h3>Support</h3>
                        <p>Kurunegala Road, Kurunegala</p>
                        <p>megacab@gmail.com</p>
                        <p>+94717531951</p>
                    </div>
                    <div class="container_one flexgrow_two">
                        <h3>Account</h3>
                        <p>My Account</p>
                        <p>Login / Register</p>
                        <p>Cart</p>
                        <p>Wishlist</p>
                        <p>Shop</p>
                    </div>
                    <div class="container_one flexgrow_three">
                        <h3>Quick Link</h3>
                        <p>Privacy Policy</p>
                        <p>Terms of Use</p>
                        <p>FAQ</p>
                        <p>Contact</p>
                    </div>
                </div>
                <p id="footer_copyright">@ Copyright MegaCab 2024. All right reserved</p>
            </div>
        </div>
    </div>
</body>
</html>