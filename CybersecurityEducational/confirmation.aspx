<%@ Page Language="C#" AutoEventWireup="true" CodeFile="confirmation.aspx.cs" Inherits="CybersecurityEducational.Confirmation" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberShield Academy - Payment Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #0a0a23 0%, #1a1a3d 100%);
            color: #e0e0e0;
            position: relative;
            overflow-x: hidden;
            margin: 0;
        }

        .binary-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.08;
            pointer-events: none;
            background: repeating-linear-gradient(0deg, transparent, transparent 2px, #00d4ff 2px, #00d4ff 4px);
            animation: binary-scroll 20s linear infinite;
            z-index: -1;
        }

        @keyframes binary-scroll {
            0% { background-position: 0 0; }
            100% { background-position: 0 100px; }
        }

        .navbar {
            background: linear-gradient(90deg, #0a0a23, #1a1a3d) !important;
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-family: 'Orbitron', sans-serif;
            font-size: 2rem;
            font-weight: 700;
            color: #00d4ff !important;
            text-shadow: 0 0 10px #00d4ff;
        }

        .navbar-brand:hover {
            color: #ff00ff !important;
            text-shadow: 0 0 20px #ff00ff;
        }

        .nav-link {
            font-family: 'Roboto', sans-serif;
            font-weight: 500;
            color: #e0e0e0 !important;
            padding: 0.5rem 1.2rem !important;
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
        }

        .logout-btn:hover {
            background: #cc0000;
            transform: scale(1.1);
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.5);
        }

        .confirmation-section {
            padding: 5rem 2rem;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #00d4ff;
            box-shadow: 0 0 30px rgba(0, 212, 255, 0.4);
            border-radius: 20px;
            margin: 4rem auto;
            max-width: 700px;
        }

        .confirmation-section h2 {
            font-family: 'Orbitron', sans-serif;
            font-size: 3rem;
            text-shadow: 0 0 10px #00d4ff;
            animation: glitch 2s linear infinite;
        }

        @keyframes glitch {
            2%, 64% { transform: translate(2px, 0) skew(0deg); }
            4%, 60% { transform: translate(-2px, 0) skew(0deg); }
            62% { transform: translate(0, 0) skew(5deg); }
        }

        .confirmation-card {
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
            position: relative;
            overflow: hidden;
        }

        .confirmation-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%);
            opacity: 0.3;
            z-index: 0;
        }

        .confirmation-card > * {
            position: relative;
            z-index: 1;
        }

        .success-icon {
            font-size: 4rem;
            color: #00ff00;
            text-shadow: 0 0 15px rgba(0, 255, 0, 0.7);
            margin-bottom: 1rem;
        }

        .success-message {
            color: #e0e0e0; /* Light gray color for the entire message */
            font-size: 1.2rem;
            font-weight: 400;
            text-shadow: 0 0 5px #00d4ff; /* Glowing effect */
        }

        .confirmation-details {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 1.5rem;
            margin: 1rem 0;
        }

        .confirmation-details p {
            margin: 0.5rem 0;
            font-size: 1.2rem;
        }

        .confirmation-details .label {
            color: #000000; /* Black color for "Payment ID:" and "Amount: $" */
            font-weight: 500;
        }

        .confirmation-details span {
            color: #e0e0e0; /* Light gray for the values */
            font-weight: 500;
        }

        .btn-explore {
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            color: white;
            border-radius: 5px;
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }

        .btn-explore:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.7);
        }

        .btn-secondary-action {
            background: transparent;
            border: 1px solid #00d4ff;
            color: #00d4ff;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-secondary-action:hover {
            background: #00d4ff;
            color: #fff;
            transform: scale(1.05);
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="binary-bg"></div>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand animate__animated animate__pulse animate__infinite" href="index.aspx">
                <i class="fas fa-shield-alt me-2"></i>CyberShield Academy
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.aspx#courses">Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.aspx#pricing">Pricing</a></li>
                    <li class="nav-item"><a class="nav-link" href="security_lab.aspx">Security Lab</a></li>
                    <li class="nav-item"><a class="nav-link" href="account.aspx">Account</a></li>
                    <% if (Session["Username"] != null) { %>
                    <li class="nav-item">
                        <span class="nav-link text-white">
                            <i class="fas fa-user me-2"></i><%= Session["Username"] ?? "Guest" %>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white logout-btn" href="index.aspx?logout=true"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                    </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Confirmation Section -->
    <section class="confirmation-section container animate__animated animate__fadeIn">
        <h2 class="text-center mb-4">Payment Confirmation</h2>
        <div class="confirmation-card text-center">
            <i class="fas fa-check-circle success-icon animate__animated animate__bounceIn"></i>
            <h4 class="text-center mb-3">Payment Successful!</h4>
            <p class="text-center mb-3 success-message">
                Congratulations! You have successfully upgraded to the <span id="roleText"></span> role.
            </p>
            <div class="confirmation-details">
                <p><span class="label">Payment ID:</span> <span id="paymentId"></span></p>
                <p><span class="label">Amount:</span> $<span id="amountText"></span></p>
            </div>
            <!-- Hidden fields to pass server-side values to JavaScript -->
            <input type="hidden" id="hiddenPaymentAmount" value="<%= Session["PaymentAmount"] ?? "0.00" %>" />
            <input type="hidden" id="hiddenUserRole" value="<%= Session["UserRole"] ?? "Novice" %>" />
            <a href="index.aspx#courses" class="btn btn-explore w-100 mb-2">Explore Your New Features</a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h5 class="mb-3">CyberShield Academy</h5>
                    <p>Elite cybersecurity training for the digital frontier.</p>
                    <div class="d-flex">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
                    <h5 class="mb-3">Missions</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="index.aspx#courses" class="text-white text-decoration-none">Web Security</a></li>
                        <li class="mb-2"><a href="index.aspx#courses" class="text-white text-decoration-none">Network Defense</a></li>
                        <li class="mb-2"><a href="index.aspx#courses" class="text-white text-decoration-none">Secure Coding</a></li>
                        <li><a href="index.aspx#courses" class="text-white text-decoration-none">All Missions</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
                    <h5 class="mb-3">Resources</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="resources.aspx" class="text-white text-decoration-none">Blog</a></li>
                        <li class="mb-2"><a href="events.aspx?event=webinar" class="text-white text-decoration-none">Webinars</a></li>
                        <li><a href="resources.aspx" class="text-white text-decoration-none">Community</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h5 class="mb-3">Legal</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-white text-decoration-none">Terms</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Privacy</a></li>
                    </ul>
                </div>
            </div>
            <hr class="my-3">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">© 2025 CyberShield Academy.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">For educational use only.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Launch confetti animation to celebrate
            confetti({
                particleCount: 100,
                spread: 70,
                origin: { y: 0.6 },
                colors: ['#00d4ff', '#ff00ff', '#00ff00']
            });

            // Get paymentId from query string
            const urlParams = new URLSearchParams(window.location.search);
            const paymentId = urlParams.get('paymentId') || 'N/A';

            // Get amount and role from hidden fields
            let amount = document.getElementById('hiddenPaymentAmount').value || '0.00';
            let role = document.getElementById('hiddenUserRole').value || 'Novice';

            // Fallback role determination based on amount
            const amountValue = parseFloat(amount);
            if (amountValue === 0) {
                role = 'Novice';
            } else if (amountValue === 11.99) {
                role = 'Pro';
            } else if (amountValue === 19.99) {
                role = 'Elite';
            }

            // Update the DOM with the values
            document.getElementById('paymentId').textContent = paymentId;
            document.getElementById('amountText').textContent = amount;
            document.getElementById('roleText').textContent = role;
        });
    </script>
</body>
</html>