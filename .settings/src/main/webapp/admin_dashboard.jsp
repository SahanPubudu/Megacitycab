<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="CSS/main.css">
    <link rel="stylesheet" type="text/css" href="CSS/adminDash.css">
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
                        console.log("Response from server:", data); // Debugging

                        if (data.trim() === "success") {
                            alert("Booking deleted successfully");
                            let bookingRow = document.getElementById("booking-" + bookingId);
                            if (bookingRow) {
                                bookingRow.remove(); // Remove row dynamically
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
		                        <img src="assert/search.png" alt="" width="20" height="20" srcset="">
		                    </div>
		                </div>
		            </div>
                    <div class="user_indicator">
                        <img src="assert/online-shopping.png" width="25" height="25" alt="" srcset="">
                        <img src="assert/heart.png" width="25" height="25" alt="" srcset="">
                        <img src="assert/user.png" width="25" height="25" alt="" srcset="">
                        <p id="u_name">Admin</p>
                        <a href="logout.jsp">Logout</a>
                    </div>
                </div>
            </div>
            <div class="hero">
                <div class="s2_user_selection">
                    <div class="s22_indicator">
                        <div id="all_12">
                            <p>All Category</p>
                        </div>
                        <div class="s2_item">
                            <img src="assert/tracking.png" width="25" height="25" alt="">
                            <p>Track Order</p>
                        </div>
                        <div class="s2_item">
                            <img src="assert/scale.png" width="25" height="25" alt="">
                            <p>Track Order</p>
                        </div>
                        <div class="s2_item">
                            <img src="assert/customer-service.png" width="25" height="25" alt="">
                            <p>Track Order</p>
                        </div>
                        <div class="s2_item">
                            <img src="assert/help.png" width="25" height="25" alt="">
                            <p>Track Order</p>
                        </div>
                    </div>
                    <div class="s2_item">
                        <img src="assert/telephone.png" width="25" height="25" alt="">
                        <p>+94714973507</p>
                    </div>
                </div>
                <div class="admin-dash-main-wrapper">
                    <div class="admin-dash-left-wrapper">
                        <div class="tab-btn-main-wrapper">
                            <button class="w3-bar-item w3-button" onclick="openCity('London')">Manage Vehicles</button>
                            <button class="w3-bar-item w3-button" onclick="openCity('Paris')">Manage Rents</button>
                            <button class="w3-bar-item w3-button" onclick="openCity('Tokyo')">Add Vehicle</button>
                        </div>

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
                    
                    // Convert image BLOB to base64 for display
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
				               	<button  class="btn"><a href="edit_vehicle.jsp?id=<%= vehicleId %>">Edit</a></button>
                                <button  class="btn1"> <a href="delete_vehicle.jsp?id=<%= vehicleId %>">Delete</a></button>
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
        </div>
        <div class="page_footer">
            <div class="footer_Section">
                <div class="footer_main_wrapper">
                    <div class="container_one">
                        <h2>TechFix</h2>
                        <h3>Subcribe</h3>
                        <p>Get 10% off your first order</p>
                        <h3>Subcribe</h3>
                        <p>Get 10% off your first order</p>
                    </div>
                    <div class="container_one flexgrow_one">
                        <h3>Support</h3>
                        <p>Kurunegala road Kurunegala</p>
                        <p>TechFix@gmail.gom</p>
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
                    <div class="container_one flexgrow_four">
                        <h3>Download App</h3>
                        <p>save 3% with app new user only</p>
                        <div class="contact_icon">
                            <div>
                                <img src="assert/Untitled 1.png" width="80" height="80" alt="">
                            </div>
                            <div>
                                <img src="assert/GooglePlay.png" alt="" srcset=""><br>
                                <img src="assert/download-appstore.png" alt="" srcset="">
                            </div>
                        </div>
                        <div>
                            <img src="assert/Frame 741.png" alt="" srcset="">
                        </div>
                    </div>
                </div>
                <p id="footer_copyright">@ Copyright Rimel 2024. All right reserved</p>
            </div>
        </div>
    </div>
</body>
</html>
