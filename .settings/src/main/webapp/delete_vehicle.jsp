<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int vehicleId = -1;
    if (request.getParameter("id") != null) {
        vehicleId = Integer.parseInt(request.getParameter("id"));
    } else {
        response.sendRedirect("admin_dashboard.jsp?error=NoID");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Vehicle</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin-top: 100px;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #b02a37;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="card text-center p-4">
        <h3 class="text-danger"><i class="fas fa-exclamation-triangle"></i> Confirm Deletion</h3>
        <p class="text-dark">Are you sure you want to delete this vehicle? This action cannot be undone.</p>

        <form action="DeleteVehicleServlet" method="post">
            <input type="hidden" name="vehicleId" value="<%= vehicleId %>">
            <button type="submit" class="btn btn-danger w-100"><i class="fas fa-trash-alt"></i> Yes, Delete</button>
        </form>

        <a href="admin_dashboard.jsp" class="btn btn-outline-secondary w-100 mt-3"><i class="fas fa-times"></i> Cancel</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
