<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.Base64" %>
<%
    String vehicleId = request.getParameter("id");  
    String model = "", rentPrice = "", imageBase64 = "";

    if (vehicleId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacab", "root", "root");
            PreparedStatement stmt = conn.prepareStatement("SELECT vehicle_model, vehicle_rent, vehicle_image FROM vehicles WHERE vehicle_id = ?");
            stmt.setInt(1, Integer.parseInt(vehicleId)); // Ensure vehicleId is an integer
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                model = rs.getString("vehicle_model");
                rentPrice = rs.getString("vehicle_rent");

                byte[] imgData = rs.getBytes("vehicle_image");
                if (imgData != null) {
                    imageBase64 = Base64.getEncoder().encodeToString(imgData);
                }
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Your Cab</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        /* General Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a1a, #0d0d0d);
            color: #e0e0e0;
            line-height: 1.6;
        }

        .page_header {
            background: linear-gradient(135deg, #222, #333);
            color: white;
            padding: 20px 0;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        }

        .page_header_sub_wrapper {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 90%;
            margin: 0 auto;
        }

        .company_logo h1 {
            font-size: 2.5rem;
            color: #ff4444;
        }

        .user_indicator {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user_indicator img {
            width: 25px;
            height: 25px;
            transition: transform 0.3s ease;
        }

        .user_indicator img:hover {
            transform: scale(1.2);
        }

        .user_indicator a {
            color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .user_indicator a:hover {
            color: #ff4444;
        }

        .container {
            max-width: 800px;
            margin-top: 50px;
            background: rgba(0, 0, 0, 0.8);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.7);
            padding: 20px;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            padding: 20px;
            background: #333;
        }

        .card h3 {
            color: #ff4444;
        }

        .form-label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #444;
            padding: 10px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: #444;
            color: #fff;
        }

        .form-control:focus {
            border-color: #ff4444;
            box-shadow: 0 0 10px rgba(255, 68, 68, 0.5);
        }

        .r_item_name {
            font-size: 2rem;
            font-weight: bold;
            color: #ff4444;
            margin-bottom: 20px;
        }

        .r_price_wrapper {
            font-size: 1.5rem;
            color: #e0e0e0;
            margin-bottom: 20px;
        }

        .r_price_wrapper p {
            margin: 0;
        }

        .r_price_wrapper button {
            background: linear-gradient(135deg, #ff4444, #cc0000);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .r_price_wrapper button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(255, 68, 68, 0.5);
        }

        .img-fluid {
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }
    </style>
</head>
<body>
<div class="page_header">
    <div class="page_header_sub_wrapper">
        <div class="company_logo">
            <h1>MegaCityCab</h1>
        </div>
        <div class="user_indicator">
            <img src="assert/online-shopping.png" width="25" height="25" alt="Shopping Cart">
            <img src="assert/heart.png" width="25" height="25" alt="Wishlist">
            <img src="assert/user.png" width="25" height="25" alt="User">
            <p id="u_name">User</p>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="card">
        <h3 class="text-center">Book Your Ride</h3>

        <% if (!imageBase64.isEmpty()) { %>
            <div class="text-center">
                <img src="data:image/jpeg;base64,<%= imageBase64 %>" class="img-fluid" style="max-height: 200px;">
            </div>
        <% } %>

        <p class="text-center mt-3"><strong>Vehicle Model:</strong> <%= model %></p>
        <p class="text-center"><strong>Rent Price:</strong> LKR <%= rentPrice %></p>

        <form action="storeBooking.jsp" method="post" class="mt-3">
            <input type="hidden" name="vehicle_id" value="<%= vehicleId != null ? vehicleId : "" %>">
            <input type="hidden" name="vehicle_model" value="<%= model != null ? model : "" %>">
            <input type="hidden" name="rent_price" value="<%= rentPrice != null ? rentPrice : "" %>">

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-user"></i> Full Name</label>
                    <input type="text" name="full_name" class="form-control" placeholder="Enter your name" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-map-marker-alt"></i> Address</label>
                    <input type="text" name="address" class="form-control" placeholder="Enter your address" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-id-card"></i> NIC</label>
                    <input type="text" name="nic" class="form-control" placeholder="Enter NIC" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-phone"></i> Phone</label>
                    <input type="text" name="phone" class="form-control" placeholder="Enter phone number" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><i class="fab fa-whatsapp"></i> WhatsApp</label>
                    <input type="text" name="whatsapp" class="form-control" placeholder="Enter WhatsApp number" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" name="email" class="form-control" placeholder="Enter email" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-map-marker-alt"></i> From Location</label>
                    <input type="text" name="from_location" class="form-control" placeholder="From location" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-map-marker-alt"></i> To Location</label>
                    <input type="text" name="to_location" class="form-control" placeholder="To location" required>
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-primary w-100"><i class="fas fa-ticket-alt"></i> Download Ticket</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
