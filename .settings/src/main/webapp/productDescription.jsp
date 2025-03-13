<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/main.css">
    <link rel="stylesheet" href="CSS/cDescription.css">
    <title>Cab Description</title>
</head>
<body>
<div class="page_main_wrapper">
    <div class="page_header">
        <div class="page_header">
		        <div class="page_header_sub_wrapper">
		            <div class="company_logo">
		                <h1>MegaCityCab</h1>
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
		                <p id="u_name">Ruvidu</p>
		                <a href="logout.jsp">Logout</a>
		            </div>
		        </div>
		    </div>
    </div>

    <div class="page_body">
        <div class="p_des_main_wrapper">
            <%
                String url = "jdbc:mysql://localhost:3306/megacab";
                String user = "root";
                String password = "root";
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                int vehicleId = Integer.parseInt(request.getParameter("id"));
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, user, password);
                    String query = "SELECT * FROM vehicles WHERE vehicle_id = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, vehicleId);
                    rs = pstmt.executeQuery();
                    
                    if (rs.next()) {
                        String model = rs.getString("vehicle_model");
                        String price = rs.getString("vehicle_rent");
                        String name = rs.getString("vehicle_name");
                        String number = rs.getString("vehicle_number");
                        String type = rs.getString("vehicle_type");
                        
                        // Convert image BLOB to base64 for display
                        byte[] imgData = rs.getBytes("vehicle_image");
                        String base64Image = "";
                        if (imgData != null) {
                            base64Image = "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(imgData);
                        }
            %>
            <div class="left_p_dec">
                <div class="item_image">
                    <img src="<%= base64Image %>" width="100%" height="100%" alt="Vehicle Image">
                </div>
            </div>
            <div class="right_p_dec">
                <p class="r_item_name"><%= model %></p>
                
                    <p class="r_item_name"><%= name %></p>
                
                    <p class="r_item_name"><%= type %></p>
                
                <div class="r_price_wrapper">
                    <p>LKR <%= price %></p>
                   
                </div>
                <div class="r_price_wrapper">
                <a href="chekout.jsp?id=<%= request.getParameter("id") %>">
    					<button class="">Rent Now</button>
				</a>
				</div>
            </div>
            <%
                    } else {
                        out.println("<p>Vehicle not found.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (con != null) con.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>
        </div>
    </div>
</div>
</body>
</html>