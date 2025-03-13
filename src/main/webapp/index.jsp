<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCityCab</title>
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
        .page_main_wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .page_header {
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
        .hero {
            margin-bottom: 20px;
        }
        .header_image {
            background-image: url('assert/car.jpg'); /* Japanese-inspired hero image */
            background-size: cover;
            background-position: center;
            height: 300px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .page_body {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .head_compo1 h2 {
            color: #e74c3c;
            margin-bottom: 20px;
        }
        .supplier_item {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .p_item {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: calc(33.33% - 20px);
            text-align: center;
        }
        .pheader {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .instock_compo p {
            font-size: 1.2rem;
            color: #333;
        }
        .p_img img {
            max-width: 100%;
            border-radius: 10px;
        }
        .item_name {
            font-size: 1.2rem;
            color: #333;
            margin: 10px 0;
        }
        .item_price {
            font-size: 1.2rem;
            color: #e74c3c;
            margin: 10px 0;
        }
        .item_add_cart_flex {
            display: flex;
            justify-content: center;
        }
        .item_add_cart {
            background-color: #e74c3c;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .item_add_cart:hover {
            background-color: #c0392b;
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
</head>
<body>
    <div class="page_main_wrapper">
        <!-- Header Section -->
        <div class="page_header">
            <div class="page_header_sub_wrapper">
                <div class="company_logo">
                    <h1>MegaCityCab</h1>
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
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>

        <!-- Hero Section -->
        <div class="hero">
            <div class="header_image"></div>
        </div>

        <!-- Body Section -->
        <div class="page_body">
            <div class="head_compo1">
                <h2>Top Vehicles Available</h2>
            </div>

            <div class="supplier_item">
                <%
                    // Database connection and querying vehicle details
                    String url = "jdbc:mysql://localhost:3306/megacab";
                    String user = "root";
                    String password = "root";
                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Connect to the database
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(url, user, password);
                        stmt = con.createStatement();
                        String query = "SELECT * FROM vehicles";
                        rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            String model = rs.getString("vehicle_model");
                            String price = rs.getString("vehicle_rent");
                            byte[] imgData = rs.getBytes("vehicle_image");
                            String base64Image = "";
                            if (imgData != null) {
                                base64Image = "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(imgData);
                            }
                %>

                <div class="p_item">
                    <div class="pheader">
                        <div class="instock_compo">
                            <p><%= model %></p>
                        </div>
                        <img src="assert/thumbs-up.png" width="25" height="25" alt="" />
                    </div>
                    <div class="p_img">
                        <img src="<%= base64Image %>" width="100%" height="100%" alt="Vehicle Image">
                    </div>
                    <p class="item_name"><%= model %></p>
                    <p class="item_price">LKR <%= price %></p>
                    <div class="item_add_cart_flex">
                        <div onclick="window.location.href='productDescription.jsp?id=<%= rs.getInt("vehicle_id") %>'" class="item_add_cart">
                            Rent Now
                        </div>
                    </div>
                </div>

                <%
                        }
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (con != null) con.close();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>

        <!-- Footer Section -->
        <div class="page_footer">
            <div class="footer_Section">
                <div class="footer_main_wrapper">
                    <div class="container_one">
                        <h2>MEGA CITY CAB</h2>
                        <h3>Subscribe</h3>
                        <p>Get 10% off your first ride</p>
                        <input type="email" placeholder="Enter your email">
                        <button>Subscribe</button>
                    </div>
                    <div class="container_one flexgrow_one">
                        <h3>Contact</h3>
                        <p>Email: megacitycab@gmail.com</p>
                        <p>Phone: +94719208046</p>
                    </div>
                    <div class="container_one flexgrow_two">
                        <h3>Account</h3>
                        <p>My Account</p>
                        <p>Login / Register</p>
                        <p>Cart</p>
                    </div>
                </div>
                <p id="footer_copyright">@ Copyright MegaCityCab 2025. All rights reserved</p>
            </div>
        </div>
    </div>
</body>
</html>