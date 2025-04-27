<%@ Page Language="C#" AutoEventWireup="true" CodeFile="account.aspx.cs" Inherits="CybersecurityEducational.Account" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Security - CyberShield Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <style>
        body {
            font-family: 'Orbitron', sans-serif;
            background: linear-gradient(135deg, #0a0a23 0%, #1a1a3d 100%);
            color: #e0e0e0;
            position: relative;
            overflow-x: hidden;
        }

        .binary-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.1;
            pointer-events: none;
            background: repeating-linear-gradient(0deg, transparent, transparent 2px, #00d4ff 2px, #00d4ff 4px);
            animation: binary-scroll 20s linear infinite;
        }

        @keyframes binary-scroll {
            0% { background-position: 0 0; }
            100% { background-position: 0 100px; }
        }

        .navbar {
            background: linear-gradient(90deg, #0a0a23, #1a1a3d) !important;
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
            padding: 0.8rem 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            color: #00d4ff !important;
            text-shadow: 0 0 10px #00d4ff;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            color: #ff00ff !important;
            text-shadow: 0 0 20px #ff00ff;
        }

        .nav-link {
            color: #e0e0e0 !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            color: #00d4ff !important;
            text-shadow: 0 0 10px #00d4ff;
            transform: scale(1.05);
        }

        .logout-btn {
            background: #ff0000;
            padding: 0.5rem 1.2rem !important;
            font-weight: 600;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #cc0000;
            transform: scale(1.1);
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.5);
        }

        h1 {
            font-size: 3rem;
            font-weight: 900;
            text-shadow: 0 0 15px rgba(0, 212, 255, 0.7);
            animation: glitch 2s linear infinite;
        }

        @keyframes glitch {
            2%, 64% { transform: translate(2px, 0) skew(0deg); }
            4%, 60% { transform: translate(-2px, 0) skew(0deg); }
            62% { transform: translate(0, 0) skew(5deg); }
        }

        .nav-tabs {
            border-bottom: 2px solid #00d4ff;
        }

        .nav-tabs .nav-link {
            color: #e0e0e0;
            border: none;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
        }

        .nav-tabs .nav-link:hover, .nav-tabs .nav-link.active {
            color: #00d4ff !important;
            border-bottom: 3px solid #00d4ff;
            text-shadow: 0 0 10px #00d4ff;
        }

        .card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #00d4ff;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
        }

        .card-header {
            padding: 1rem;
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            text-align: center;
        }

        .btn-animated {
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 0 10px rgba(0, 212, 255, 0.5);
        }

        .btn-animated:hover {
            transform: translateY(-3px);
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.8);
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #00d4ff;
            color: #e0e0e0;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: #ff00ff;
            box-shadow: 0 0 10px rgba(255, 0, 255, 0.5);
            color: #e0e0e0;
        }

        .form-control.is-invalid {
            border-color: #dc3545;
        }

        .form-text, .invalid-feedback {
            color: #e0e0e0;
        }

        .invalid-feedback {
            display: none;
        }

        .was-validated .form-control:invalid,
        .form-control.is-invalid {
            border-color: #dc3545;
        }

        .was-validated .form-control:invalid ~ .invalid-feedback,
        .form-control.is-invalid ~ .invalid-feedback {
            display: block;
        }

        footer {
            background: #0a0a23 !important;
            border-top: 1px solid #00d4ff;
        }

        footer a:hover {
            color: #00d4ff !important;
            text-shadow: 0 0 10px #00d4ff;
        }

        .message {
            display: none;
            margin-top: 1rem;
        }

        .form-content {
            display: block;
        }

        .success-message {
            display: none;
        }
    </style>
</head>
<body>
    <div class="binary-bg"></div>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand animate__animated animate__pulse animate__infinite" href="index.html">
                <i class="fas fa-shield-alt me-2"></i>CyberShield Academy
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="account.aspx">Account</a></li>
                    <li class="nav-item"><a class="nav-link" href="security_lab.html">Security Lab</a></li>
                    <li class="nav-item"><a class="nav-link" href="payment_demo.html">Payment Demo</a></li>
                    <li class="nav-item" id="userInfo" style="display: none;">
                        <span class="nav-link text-white">
                            <i class="fas fa-user me-2"></i><span id="usernameDisplay"></span>
                        </span>
                    </li>
                    <li class="nav-item" id="logoutLink" style="display: none;">
                        <a class="nav-link text-white logout-btn" href="account.aspx?logout=true"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <form id="mainForm" runat="server" novalidate>
        <div class="container">
            <div class="row mb-5">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="mb-4">Account Security Ops</h1>
                    <p class="lead">Master secure authentication to protect digital assets.</p>
                    <div class="alert alert-info">
                        <strong>Educational Purpose:</strong> Demonstrates secure authentication methods.
                    </div>
                </div>
            </div>

            <div class="row mb-5">
                <div class="col-lg-10 mx-auto">
                    <ul class="nav nav-tabs mb-4" id="accountTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="register-tab" data-bs-toggle="tab" data-bs-target="#register" type="button" role="tab" aria-controls="register" aria-selected="true">Secure Registration</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="login-tab" data-bs-toggle="tab" data-bs-target="#login" type="button" role="tab" aria-controls="login" aria-selected="false">Secure Login</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="2fa-tab" data-bs-toggle="tab" data-bs-target="#2fa" type="button" role="tab" aria-controls="2fa" aria-selected="false">Two-Factor Authentication</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="payment-tab" data-bs-toggle="tab" data-bs-target="#payment" type="button" role="tab" aria-controls="payment" aria-selected="false">Payment Details</button>
                        </li>
                    </ul>

                    <div class="tab-content" id="accountTabsContent">
                        <!-- Secure Registration Tab -->
                        <div class="tab-pane fade show active" id="register" role="tabpanel" aria-labelledby="register-tab">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border-success mb-4">
                                        <div class="card-header bg-success text-white">
                                            <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i> Secure Registration</h5>
                                        </div>
                                        <asp:Panel ID="RegistrationPanel" runat="server" CssClass="card-body">
                                            <asp:Label ID="RegisterMessage" runat="server" CssClass="message text-danger" Visible="False"></asp:Label>
                                            <div class="form-content">
                                                <div class="mb-3">
                                                    <label for="regUsername" class="form-label">Username</label>
                                                    <asp:TextBox ID="regUsername" runat="server" CssClass="form-control" MaxLength="20" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="form-text">5-20 lowercase letters only.</div>
                                                    <div class="invalid-feedback">Invalid username.</div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="regEmail" class="form-label">Email</label>
                                                    <asp:TextBox ID="regEmail" runat="server" CssClass="form-control" TextMode="Email" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Invalid email.</div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="regPassword" class="form-label">Password</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="regPassword" runat="server" CssClass="form-control" TextMode="Password" required="true" aria-required="true"></asp:TextBox>
                                                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                    </div>
                                                    <div class="form-text">Minimum 8 characters, letters and numbers only.</div>
                                                    <div class="invalid-feedback">Password requirements not met.</div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="regConfirmPassword" class="form-label">Confirm Password</label>
                                                    <asp:TextBox ID="regConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Passwords do not match.</div>
                                                </div>

                                                <asp:Button ID="RegisterButton" runat="server" CssClass="btn btn-success btn-animated" Text="Create Account" OnClick="RegisterButton_Click" />
                                            </div>
                                            <div class="success-message" id="RegistrationSuccess" runat="server"></div>
                                        </asp:Panel>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">Security Features</h5>
                                        </div>
                                        <div class="card-body">
                                            <ul class="list-group">
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-check-circle text-success me-3"></i>
                                                    <div>
                                                        <strong>Input Validation</strong>
                                                        <p class="mb-0">Ensures proper username and email formats.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-check-circle text-success me-3"></i>
                                                    <div>
                                                        <strong>Strong Passwords</strong>
                                                        <p class="mb-0">Requires secure passwords.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-check-circle text-success me-3"></i>
                                                    <div>
                                                        <strong>Secure Storage</strong>
                                                        <p class="mb-0">Stores user credentials securely.</p>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Secure Login Tab -->
                        <div class="tab-pane fade" id="login" role="tabpanel" aria-labelledby="login-tab">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border-primary mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0"><i class="fas fa-sign-in-alt me-2"></i> Secure Login</h5>
                                        </div>
                                        <asp:Panel ID="LoginPanel" runat="server" CssClass="card-body">
                                            <asp:Label ID="LoginMessage" runat="server" CssClass="message text-danger" Visible="False"></asp:Label>
                                            <div class="form-content">
                                                <div class="mb-3">
                                                    <label for="loginEmail" class="form-label">Email</label>
                                                    <asp:TextBox ID="loginEmail" runat="server" CssClass="form-control" TextMode="Email" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Enter your email.</div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="loginPassword" class="form-label">Password</label>
                                                    <asp:TextBox ID="loginPassword" runat="server" CssClass="form-control" TextMode="Password" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Enter your password.</div>
                                                </div>

                                                <asp:Button ID="LoginButton" runat="server" CssClass="btn btn-primary btn-animated" Text="Log In" OnClick="LoginButton_Click" />
                                            </div>
                                            <div class="success-message" id="LoginSuccess" runat="server"></div>
                                        </asp:Panel>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">Login Security</h5>
                                        </div>
                                        <div class="card-body">
                                            <ul class="list-group">
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-shield-alt text-success me-3"></i>
                                                    <div>
                                                        <strong>Brute Force Protection</strong>
                                                        <p class="mb-0">Limits login attempts.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-user-shield text-success me-3"></i>
                                                    <div>
                                                        <strong>Account Lockout</strong>
                                                        <p class="mb-0">Locks after failed attempts.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-lock text-success me-3"></i>
                                                    <div>
                                                        <strong>Secure Sessions</strong>
                                                        <p class="mb-0">Protects user sessions.</p>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Two-Factor Authentication Tab -->
                        <div class="tab-pane fade" id="2fa" role="tabpanel" aria-labelledby="2fa-tab">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border-primary mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0"><i class="fas fa-key me-2"></i> Two-Factor Authentication</h5>
                                        </div>
                                        <asp:Panel ID="twoFactorDemo" runat="server" CssClass="card-body">
                                            <div class="text-center mb-4">
                                                <i class="fas fa-mobile-alt fa-4x text-primary mb-3"></i>
                                                <h5>Verification Code</h5>
                                                <p>Enter the 6-digit code sent to your device.</p>
                                            </div>

                                            <div class="form-content">
                                                <div class="mb-4">
                                                    <label for="verificationCode" class="form-label">Verification Code</label>
                                                    <asp:TextBox ID="verificationCode" runat="server" CssClass="form-control form-control-lg text-center" MaxLength="6" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Enter a valid 6-digit code.</div>
                                                </div>

                                                <div class="d-grid gap-2">
                                                    <asp:Button ID="Verify2FAButton" runat="server" CssClass="btn btn-primary btn-animated" Text="Verify" OnClick="Verify2FAButton_Click" />
                                                </div>
                                            </div>

                                            <div class="success-message" id="TwoFactorSuccess" runat="server"></div>

                                            <div class="alert alert-info mt-4">
                                                <small>For demo, use code: <strong>123456</strong></small>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">2FA Benefits</h5>
                                        </div>
                                        <div class="card-body">
                                            <ul class="list-group">
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-shield-alt text-success me-3"></i>
                                                    <div>
                                                        <strong>Enhanced Security</strong>
                                                        <p class="mb-0">Prevents password-only attacks.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-user-shield text-success me-3"></i>
                                                    <div>
                                                        <strong>Phishing Protection</strong>
                                                        <p class="mb-0">Mitigates stolen credentials.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-bell text-success me-3"></i>
                                                    <div>
                                                        <strong>Attack Awareness</strong>
                                                        <p class="mb-0">Alerts on unauthorized access.</p>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Details Tab -->
                        <div class="tab-pane fade" id="payment" role="tabpanel" aria-labelledby="payment-tab">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border-primary mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i> Payment Details</h5>
                                        </div>
                                        <asp:Panel ID="PaymentPanel" runat="server" CssClass="card-body">
                                            <asp:Label ID="PaymentMessage" runat="server" CssClass="message text-danger" Visible="False"></asp:Label>
                                            <div class="form-content">
                                                <div class="mb-3">
                                                    <label for="cardName" class="form-label">Cardholder Name</label>
                                                    <asp:TextBox ID="cardName" runat="server" CssClass="form-control" placeholder="John Doe" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Cardholder name is required.</div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="cardNumber" class="form-label">Card Number</label>
                                                    <asp:TextBox ID="cardNumber" runat="server" CssClass="form-control" placeholder="1234 5678 9012 3456" MaxLength="16" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Enter a valid 16-digit card number.</div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-6">
                                                        <label for="expiryMonth" class="form-label">Expiry Month</label>
                                                        <asp:TextBox ID="expiryMonth" runat="server" CssClass="form-control" placeholder="MM" MaxLength="2" required="true" aria-required="true"></asp:TextBox>
                                                        <div class="invalid-feedback">Enter a valid month (01-12).</div>
                                                    </div>
                                                    <div class="col-6">
                                                        <label for="expiryYear" class="form-label">Expiry Year</label>
                                                        <asp:TextBox ID="expiryYear" runat="server" CssClass="form-control" placeholder="YYYY" MaxLength="4" required="true" aria-required="true"></asp:TextBox>
                                                        <div class="invalid-feedback">Enter a valid year (e.g., 2025).</div>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="cvv" class="form-label">CVV</label>
                                                    <asp:TextBox ID="cvv" runat="server" CssClass="form-control" placeholder="123" MaxLength="4" required="true" aria-required="true"></asp:TextBox>
                                                    <div class="invalid-feedback">Enter a valid CVV (3 or 4 digits).</div>
                                                </div>

                                                <asp:Button ID="SavePaymentButton" runat="server" CssClass="btn btn-primary btn-animated" Text="Save Payment Details" OnClick="SavePaymentButton_Click" />
                                            </div>
                                            <div class="success-message" id="PaymentSuccess" runat="server"></div>
                                        </asp:Panel>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">Payment Security</h5>
                                        </div>
                                        <div class="card-body">
                                            <ul class="list-group">
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-lock text-success me-3"></i>
                                                    <div>
                                                        <strong>Secure Storage</strong>
                                                        <p class="mb-0">Card details are stored securely.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-shield-alt text-success me-3"></i>
                                                    <div>
                                                        <strong>Data Validation</strong>
                                                        <p class="mb-0">Ensures valid card information.</p>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex align-items-center">
                                                    <i class="fas fa-user-shield text-success me-3"></i>
                                                    <div>
                                                        <strong>User Authentication</strong>
                                                        <p class="mb-0">Linked to your account.</p>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">© 2025 CyberShield Academy.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="#" class="text-white me-3">Privacy Policy</a>
                    <a href="#" class="text-white">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Load user session from localStorage
        let user = JSON.parse(localStorage.getItem('user')) || null;
        if (user) {
            document.getElementById('userInfo').style.display = 'block';
            document.getElementById('logoutLink').style.display = 'block';
            document.getElementById('usernameDisplay').textContent = user.username;
        }

        // Logout function
        function logout() {
            localStorage.removeItem('user');
            user = null;
            document.getElementById('userInfo').style.display = 'none';
            document.getElementById('logoutLink').style.display = 'none';
            window.location.href = 'account.aspx?logout=true';
        }

        // Password toggle visibility
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('regPassword');
        if (togglePassword && passwordInput) {
            togglePassword.addEventListener('click', () => {
                const type = passwordInput.type === 'password' ? 'text' : 'password';
                passwordInput.type = type;
                togglePassword.querySelector('i').classList.toggle('fa-eye');
                togglePassword.querySelector('i').classList.toggle('fa-eye-slash');
            });
        }

        // Client-side validation for Bootstrap
        (function () {
            'use strict';
            const forms = document.querySelectorAll('.form-content');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    let isValid = true;
                    const emailInput = form.querySelector('#loginEmail');
                    const passwordInput = form.querySelector('#loginPassword');

                    // Reset validation feedback
                    form.querySelectorAll('.invalid-feedback').forEach(feedback => {
                        feedback.style.display = 'none';
                    });
                    form.querySelectorAll('.form-control').forEach(input => {
                        input.classList.remove('is-invalid');
                    });

                    // Validate email in login form
                    if (emailInput && !emailInput.value) {
                        emailInput.classList.add('is-invalid');
                        emailInput.nextElementSibling.style.display = 'block';
                        isValid = false;
                    }

                    // Validate password in login form
                    if (passwordInput && !passwordInput.value) {
                        passwordInput.classList.add('is-invalid');
                        passwordInput.nextElementSibling.style.display = 'block';
                        isValid = false;
                    }

                    if (!isValid) {
                        event.preventDefault();
                        event.stopPropagation();
                    } else {
                        form.classList.add('was-validated');
                    }
                }, false);
            });
        })();

        // Button Animations
        document.querySelectorAll('.btn-animated').forEach(button => {
            button.addEventListener('click', () => {
                button.classList.add('animate__animated', 'animate__pulse');
            });
        });

        // Navbar Scroll Effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.style.padding = '0.5rem 0';
                navbar.style.boxShadow = '0 0 30px rgba(0, 212, 255, 0.7)';
            } else {
                navbar.style.padding = '0.8rem 0';
                navbar.style.boxShadow = '0 0 20px rgba(0, 212, 255, 0.5)';
            }
        });
    </script>
</body>
</html>