<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Meca City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <!-- Google Fonts for Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f4f4;
            background-image: url('assert/car.jpg'); /* Japanese-inspired background */
            background-size: cover;
            background-position: center;
        }
        .login_main_wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .register_form_wrapper {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }
        .register_image_wrapper img {
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .btn-primary {
            background-color: #e74c3c;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #c0392b;
        }
        .form-control {
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 10px;
        }
        .form-control:focus {
            border-color: #e74c3c;
            box-shadow: 0 0 5px rgba(231, 76, 60, 0.5);
        }
        .text-decoration-none {
            color: #e74c3c;
        }
        .text-decoration-none:hover {
            color: #c0392b;
        }
        .text-center {
            color: #333;
        }
        .footer_wrapper {
            background-color: rgba(0, 0, 0, 0.8);
            color: #e0e0e0;
            padding: 20px;
            text-align: center;
            margin-top: 20px;
            border-radius: 15px;
        }
        .footer_wrapper a {
            color: #e74c3c;
            text-decoration: none;
        }
        .footer_wrapper a:hover {
            color: #c0392b;
        }
    </style>
</head>
<body>
    <div class="login_main_wrapper">
        <!-- Body Section -->
        <div class="page_body_main_wrapper">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-md-6">
                        <div class="register_form_wrapper">
                            <h2 class="mb-4 text-center">Create Your Account</h2>
                            <p class="text-muted text-center mb-4">Fill your details below</p>
                            <!-- Display error messages -->
						        <% 
						            String errorMessages = (String) request.getAttribute("errorMessages");
						            if (errorMessages != null) {
						        %>
						            <div class="alert alert-danger">
						                <%= errorMessages %>
						            </div>
						        <% 
						            }
						        %>
                            <form action="register" method="post">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Customer Name</label>
                                    <input type="text" name="Name" id="name" class="form-control" placeholder="Customer Name" required>
                                </div>
                                <div class="mb-3">
                                    <label for="nic" class="form-label">NIC</label>
                                    <input type="text" name="NIC" id="nic" class="form-control" placeholder="Your NIC" required>
                                </div>
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address</label>
                                    <input type="text" name="Address" id="address" class="form-control" placeholder="Address" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" name="pass" id="password" class="form-control" placeholder="Your Password" required>
                                </div>
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="agree" required>
                                    <label class="form-check-label" for="agree">I agree to receive marketing, advertising, and promotional information via email.</label>
                                </div>
                                <div class="mb-3 text-center">
                                    <p>If you have an account <a href="login.jsp" class="text-decoration-none">Login?</a></p>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary btn-lg">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-6 d-none d-md-block">
                        <div class="register_image_wrapper text-center">
                            <img src="assert/logo.jpg" alt="Register Image" class="img-fluid rounded-circle shadow-lg">
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>