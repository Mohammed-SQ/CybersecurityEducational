<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payment.aspx.cs" Inherits="CybersecurityEducational.Payment" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberShield Academy - Secure Payment</title>
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

        .payment-section {
            padding: 6rem 2rem;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #00d4ff;
            box-shadow: 0 0 30px rgba(0, 212, 255, 0.4);
            border-radius: 20px;
            margin: 4rem auto;
            max-width: 800px;
        }

        .payment-section h2 {
            font-family: 'Orbitron', sans-serif;
            font-size: 3.5rem;
            text-shadow: 0 0 10px #00d4ff;
            animation: glitch 2s linear infinite;
        }

        @keyframes glitch {
            2%, 64% { transform: translate(2px, 0) skew(0deg); }
            4%, 60% { transform: translate(-2px, 0) skew(0deg); }
            62% { transform: translate(0, 0) skew(5deg); }
        }

        .payment-card {
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
        }

        .payment-card h4 {
            font-size: 2rem;
        }

        .payment-card p {
            font-size: 1.5rem;
        }

        .payment-info {
            font-size: 1.6rem;
            font-weight: bold;
            color: #ffffff;
            text-align: center;
            margin-bottom: 2rem;
            text-shadow: 0 0 5px #00d4ff;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.3);
            border: 1px solid #00d4ff;
            font-family: 'Roboto', sans-serif;
            font-size: 1.3rem;
            height: 50px;
        }

            .form-control:focus {
                background: rgba(255, 255, 255, 0.4);
                border-color: #ff00ff;
                box-shadow: 0 0 10px rgba(255, 0, 255, 0.5);
            }

        .btn-pay {
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border: none;
            padding: 1rem 2rem;
            font-weight: 600;
            color: white;
            border-radius: 5px;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            font-size: 1.5rem;
        }

            .btn-pay::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: 0.5s;
            }

            .btn-pay:hover::before {
                left: 100%;
            }

            .btn-pay:hover {
                transform: scale(1.1);
                box-shadow: 0 0 25px rgba(0, 212, 255, 0.9), 0 0 15px rgba(255, 0, 255, 0.9);
            }

        .error-message {
            background-color: rgba(255, 0, 0, 0.2);
            border: 1px solid #ff5555;
            padding: 1rem;
            margin: 1rem 0;
            border-radius: 5px;
            color: #ff5555;
            text-align: center;
            display: none;
            font-size: 1.3rem;
        }

        .success-message {
            background-color: rgba(0, 255, 0, 0.2);
            border: 1px solid #00ff00;
            padding: 1rem;
            margin: 1rem 0;
            border-radius: 5px;
            color: #00ff00;
            text-align: center;
            display: none;
            font-size: 1.3rem;
        }

        .input-icon {
            position: relative;
        }

            .input-icon i {
                position: absolute;
                top: 50%;
                left: 15px; /* Adjusted for better horizontal alignment */
                transform: translateY(-50%);
                color: #00d4ff;
                font-size: 1.1rem;
                z-index: 1;
                line-height: 1;
            }

            .input-icon input {
                padding-left: 40px; /* Adjusted to fit icon */
                position: relative;
                z-index: 0;
                vertical-align: middle;
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
                    <li class="nav-item"><a class="nav-link" href="index.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.aspx#courses">Courses</a></li>
                    <li class="nav-item"><a class="nav-link active" href="index.aspx#pricing">Pricing</a></li>
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

    <!-- Error Message (if any) -->
    <% if (Session["ErrorMessage"] != null) { %>
    <div class="container">
        <div class="error-message" style="display: block;">
            <%= Session["ErrorMessage"] %>
        </div>
    </div>
    <% Session["ErrorMessage"] = null; %>
    <% } %>

    <!-- Payment Section -->
    <section class="payment-section container animate__animated animate__fadeIn">
        <h2 class="text-center mb-4">Secure Payment</h2>
        <div class="payment-card">
            <p class="payment-info" id="paymentInfo">You are about to upgrade to the <span id="roleText">Novice</span> role for <span id="priceText">$0.00</span>/month.</p>
            <div class="error-message" id="errorMessage"></div>
            <div class="success-message" id="successMessage"></div>
            <form id="paymentForm" runat="server" method="post">
                <input type="hidden" name="amount" id="amountInput">
                <div class="mb-3 input-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" class="form-control" id="cardholderName" name="cardholderName" placeholder="Cardholder Name" required>
                </div>
                <div class="mb-3 input-icon">
                    <i class="fas fa-credit-card"></i>
                    <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="Card Number" maxlength="19" required>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3 input-icon">
                        <i class="fas fa-calendar-alt"></i>
                        <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" maxlength="5" required>
                    </div>
                    <div class="col-md-6 mb-3 input-icon">
                        <i class="fas fa-lock"></i>
                        <input type="text" class="form-control" id="cvv" name="cvv" placeholder="CVV" maxlength="3" required>
                    </div>
                </div>
                <asp:Button ID="ConfirmPaymentButton" runat="server" Text="Confirm Payment" CssClass="btn btn-pay w-100" OnClick="ProcessPayment" />
            </form>
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
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const plans = {
                'free': { title: 'Cyber Novice', price: 0, role: 'Novice' },
                'standard': { title: 'Cyber Pro', price: 11.99, role: 'Pro' },
                'premium': { title: 'Cyber Elite', price: 19.99, role: 'Elite' }
            };

            const urlParams = new URLSearchParams(window.location.search);
            const plan = urlParams.get('plan') ? urlParams.get('plan').toLowerCase() : 'free';
            const selectedPlan = plans[plan] || plans['free'];

            document.getElementById('amountInput').value = selectedPlan.price.toFixed(2);
            document.getElementById('roleText').textContent = selectedPlan.role;
            document.getElementById('priceText').textContent = '$' + selectedPlan.price.toFixed(2);

            const paymentForm = document.getElementById('paymentForm');
            const errorMessage = document.getElementById('errorMessage');
            const successMessage = document.getElementById('successMessage');
            const cardNumber = document.getElementById('cardNumber');
            const expiryDate = document.getElementById('expiryDate');
            const cvv = document.getElementById('cvv');

            cardNumber.addEventListener('input', (e) => {
                let value = e.target.value.replace(/\D/g, '');
                value = value.match(/.{1,4}/g)?.join(' ') || value;
                e.target.value = value.slice(0, 19);
            });

            expiryDate.addEventListener('input', (e) => {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 2) {
                    value = value.slice(0, 2) + '/' + value.slice(2);
                }
                e.target.value = value.slice(0, 5);
            });

            cvv.addEventListener('input', (e) => {
                e.target.value = e.target.value.replace(/\D/g, '').slice(0, 3);
            });

            function isValidCardNumber(number) {
                number = number.replace(/\D/g, '');
                if (number.length < 13 || number.length > 19) return false;
                let sum = 0;
                let isEven = false;
                for (let i = number.length - 1; i >= 0; i--) {
                    let digit = parseInt(number[i]);
                    if (isEven) {
                        digit *= 2;
                        if (digit > 9) digit -= 9;
                    }
                    sum += digit;
                    isEven = !isEven;
                }
                return sum % 10 === 0;
            }

            function isValidExpiryDate(date) {
                const regex = /^(0[1-9]|1[0-2])\/[0-9]{2}$/;
                if (!regex.test(date)) return false;
                const [month, year] = date.split('/').map(Number);
                const now = new Date();
                const currentYear = now.getFullYear() % 100;
                const currentMonth = now.getMonth() + 1;
                return (year > currentYear) || (year === currentYear && month >= currentMonth);
            }

            paymentForm.addEventListener('submit', (e) => {
                errorMessage.style.display = 'none';
                successMessage.style.display = 'none';

                const cardholderName = document.getElementById('cardholderName').value.trim();
                const cardNum = cardNumber.value;
                const expiry = expiryDate.value;
                const cvvValue = cvv.value;

                if (!cardholderName) {
                    errorMessage.textContent = 'Cardholder name is required.';
                    errorMessage.style.display = 'block';
                    console.log('Validation Error: Cardholder name is required.');
                    return;
                }

                if (!isValidCardNumber(cardNum)) {
                    errorMessage.textContent = 'Invalid card number.';
                    errorMessage.style.display = 'block';
                    console.log('Validation Error: Invalid card number - ' + cardNum);
                    return;
                }

                if (!isValidExpiryDate(expiry)) {
                    errorMessage.textContent = 'Invalid or expired date (MM/YY).';
                    errorMessage.style.display = 'block';
                    console.log('Validation Error: Invalid or expired date - ' + expiry);
                    return;
                }

                if (!cvvValue.match(/^\d{3}$/)) {
                    errorMessage.textContent = 'CVV must be exactly 3 digits.';
                    errorMessage.style.display = 'block';
                    console.log('Validation Error: CVV must be exactly 3 digits - ' + cvvValue);
                    return;
                }

                console.log('Form validation passed, submitting form...');
            });
        });
    </script>
</body>
</html>