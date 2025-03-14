<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Meca City Cab Service</title>
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
            background-image: url('assert/car.jpg'); /* Add a Japanese-inspired background image */
            background-size: cover;
            background-position: center;
        }
        .login_main_wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .login_form_wrapper {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .login_image_wrapper img {
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
    </style>
</head>
<body>
    <input type="hidden" id="Response" value="<%=request.getAttribute("Response")%>">
    <div class="login_main_wrapper">
        <!-- Body Section -->
        <div class="page_body_main_wrapper">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-md-6">
                        <div class="login_form_wrapper p-5 rounded shadow-lg">
                            <h2 class="mb-4 text-center">Login to Your Account</h2>
                            <p class="text-muted text-center mb-4">Fill your details below</p>
                            <form id="loginForm" action="Login" method="get">
                                <div class="mb-3">
                                    <label for="username" class="form-label">User Name</label>
                                    <input type="text" name="name" id="username" class="form-control" placeholder="User Name" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" name="pass" id="password" class="form-control" placeholder="Your Password" required>
                                </div>
                                <div class="mb-3 text-end">
                                    <a href="forgot.jsp" class="text-decoration-none">Forgot Password?</a>
                                </div>
                                <div class="mb-3 text-center">
                                    <p class="mb-0">Don't have an account? <a href="register.jsp" class="text-decoration-none">Register</a></p>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" id="loginBtn" class="btn btn-primary btn-lg">Login</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-6 d-none d-md-block">
                        <div class="login_image_wrapper text-center">
                            <img src="assert/logo.jpg" alt="Login Image" class="img-fluid rounded-circle shadow-lg">
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
    <!-- Custom JS -->
    <script>
    $(document).ready(function () {
        const response = $("#Response").val();
        
        // Success or failure response handling
        if (response === "success") {
            Swal.fire({
                title: "Success!",
                text: "You have successfully logged in.",
                icon: "success",
                confirmButtonColor: "#3085d6",
            }).then(() => {
                window.location.href = "index.jsp"; // Redirect after success
            });
        } else if (response === "failed") {
            Swal.fire({
                title: "Error!",
                text: "Invalid username or password.",
                icon: "error",
                confirmButtonColor: "#d33",
            });
        }

        // Validate the form before submitting
        $("#loginForm").submit(function (event) {
            const username = $("#username").val().trim();
            const password = $("#password").val().trim();

            // Validate username and password
            if (username === "") {
                Swal.fire({
                    title: "Validation Error!",
                    text: "Username cannot be empty.",
                    icon: "error",
                    confirmButtonColor: "#d33",
                });
                event.preventDefault(); // Prevent form submission
                return false;
            }

            if (password === "") {
                Swal.fire({
                    title: "Validation Error!",
                    text: "Password cannot be empty.",
                    icon: "error",
                    confirmButtonColor: "#d33",
                });
                event.preventDefault(); // Prevent form submission
                return false;
            }

            if (password.length < 6) {
                Swal.fire({
                    title: "Validation Error!",
                    text: "Password must be at least 6 characters long.",
                    icon: "error",
                    confirmButtonColor: "#d33",
                });
                event.preventDefault(); // Prevent form submission
                return false;
            }

            // Allow form submission if all validations pass
            return true;
        });
    });
</script>
</body>
</html>