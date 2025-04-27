<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="CybersecurityEducational.Index" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberShield Academy - Elite Cybersecurity Training</title>
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

        /* Binary Background Animation */
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
            0% {
                background-position: 0 0;
            }

            100% {
                background-position: 0 100px;
            }
        }

        /* Navbar Styling */
        .navbar {
            background: linear-gradient(90deg, #0a0a23, #1a1a3d) !important;
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-family: 'Orbitron', sans-serif;
            font-size: 2rem;
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
            font-family: 'Roboto', sans-serif;
            font-weight: 500;
            color: #e0e0e0 !important;
            padding: 0.5rem 1.2rem !important;
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

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, rgba(13, 110, 253, 0.8), rgba(10, 88, 202, 0.8)), url('https://via.placeholder.com/1500x600?text=Cyber+Matrix');
            background-blend-mode: overlay;
            background-size: cover;
            background-position: center;
            padding: 8rem 0;
            color: white;
            text-shadow: 0 0 15px rgba(0, 0, 0, 0.7);
            position: relative;
        }

            .hero-section h1 {
                font-family: 'Orbitron', sans-serif;
                font-size: 4.5rem;
                font-weight: 900;
                animation: glitch 2s linear infinite;
            }

        @keyframes glitch {
            2%, 64% {
                transform: translate(2px, 0) skew(0deg);
            }

            4%, 60% {
                transform: translate(-2px, 0) skew(0deg);
            }

            62% {
                transform: translate(0, 0) skew(5deg);
            }
        }

        .hero-section p.lead {
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }

        .btn-animated {
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 0 10px rgba(0, 212, 255, 0.5);
            font-weight: 600;
        }

            .btn-animated:hover {
                transform: translateY(-3px);
                box-shadow: 0 0 20px rgba(0, 212, 255, 0.8);
            }

        /* Comments Ticker */
        .comments-ticker {
            background: rgba(0, 0, 0, 0.85);
            padding: 1rem 0;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            z-index: 10;
            white-space: nowrap;
            overflow: hidden;
        }

        .ticker-content {
            display: inline-block;
            animation: ticker 30s linear infinite;
            font-size: 1.2rem;
        }

        @keyframes ticker {
            0% {
                transform: translateX(100%);
            }

            100% {
                transform: translateX(-100%);
            }
        }

        /* Feature Cards */
        .feature-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #00d4ff;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            border-radius: 15px;
            transition: all 0.3s ease;
        }

            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
            }

        .feature-icon {
            width: 70px;
            height: 70px;
            line-height: 70px;
            font-size: 2rem;
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(0, 212, 255, 0.7);
            }

            70% {
                box-shadow: 0 0 0 15px rgba(0, 212, 255, 0);
            }

            100% {
                box-shadow: 0 0 0 0 rgba(0, 212, 255, 0);
            }
        }

        /* Courses Section */
        .lab-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #00d4ff;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            border-radius: 15px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            height: 350px;
        }

            .lab-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
            }

            .lab-card .card-img-top {
                width: 100%;
                height: 150px;
                object-fit: cover;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }

            .lab-card .card-body {
                padding: 1.5rem;
                height: calc(100% - 150px);
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .lab-card h5 {
                font-family: 'Orbitron', sans-serif;
                font-size: 1.4rem;
                margin-bottom: 1rem;
            }

            .lab-card p {
                font-size: 1rem;
                flex-grow: 1;
            }

        .course-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            opacity: 0;
            transition: opacity 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .lab-card:hover .course-overlay {
            opacity: 1;
        }

        .course-overlay .btn-explore {
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            color: white;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

            .course-overlay .btn-explore:hover {
                transform: scale(1.1);
                box-shadow: 0 0 15px rgba(0, 212, 255, 0.7);
            }

        /* Course Modal Styling */
        .modal-content {
            background: linear-gradient(135deg, #0a0a23, #1a1a3d);
            border: 2px solid #00d4ff;
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
            border-radius: 15px;
        }

        .modal-header {
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border-bottom: none;
        }

        .modal-title {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            text-shadow: 0 0 10px #00d4ff;
        }

        .modal-body {
            display: flex;
            flex-direction: column;
            gap: 0;
            padding: 20px;
            margin: 0;
        }

        .course-content {
            display: flex;
            flex-wrap: nowrap;
            gap: 0;
            padding: 0;
            margin: 0;
            align-items: flex-start;
        }

        .course-info {
            flex: 1;
            min-width: 0;
            padding: 0;
            margin: 0;
        }

        .course-image-container {
            flex: 1;
            min-width: 0;
            padding: 0;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .course-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.5);
            margin: 0;
            padding: 0;
        }

        .modal-body .course-details {
            margin-top: 1rem;
        }

            .modal-body .course-details p {
                margin-bottom: 1rem;
                font-weight: bold;
            }

        .modal-body .certification-available, .video-available, .estimated-time {
            display: flex;
            align-items: center;
        }

            .modal-body .certification-available .icon,
            .modal-body .video-available .icon,
            .modal-body .estimated-time .icon {
                margin-right: 0.5rem;
                font-size: 1.2rem;
            }

            .modal-body .certification-available.available, .video-available.available, .estimated-time {
                color: #00ff00;
            }

            .modal-body .certification-available.not-available, .video-available.not-available {
                color: #ff0000;
            }

        .modal-body ul {
            list-style: none;
            padding-left: 0;
            margin-top: 1rem;
        }

            .modal-body ul li {
                margin-bottom: 1rem;
                font-size: 1.1rem;
            }

                .modal-body ul li::before {
                    content: "• ";
                    color: #00d4ff;
                    font-weight: bold;
                }

        .modal-body {
            border-top: 1px solid rgba(0, 212, 255, 0.3);
            margin: 1rem 0;
        }

        .modal-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

            .modal-footer .fun-fact {
                font-size: 0.9rem;
                color: #00d4ff;
                text-shadow: 0 0 5px #00d4ff;
            }

            .modal-footer .btn-secondary {
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid #00d4ff;
                color: #e0e0e0;
            }

            .modal-footer .btn-primary {
                background: linear-gradient(45deg, #00d4ff, #ff00ff);
                border: none;
                text-shadow: 0 0 5px #00d4ff;
            }

                .modal-footer .btn-primary:hover {
                    box-shadow: 0 0 15px rgba(0, 212, 255, 0.7);
                }

        /* Pricing Section */
        #pricing {
            background: #1a1a3d;
        }

        .pricing-card {
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border: 2px solid #00d4ff;
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
            border-radius: 20px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

            .pricing-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 0 30px rgba(0, 212, 255, 0.8);
            }

            .pricing-card.popular {
                border: 3px solid #ff00ff;
                box-shadow: 0 0 30px rgba(255, 0, 255, 0.7);
            }

        .pricing-header {
            padding: 2rem;
            text-align: center;
            position: relative;
        }

        .discount-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #ffc107;
            color: #000;
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 1rem;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(255, 193, 7, 0.7);
            animation: glow 1.5s infinite alternate;
        }

        @keyframes glow {
            from {
                box-shadow: 0 0 5px #ffc107;
            }

            to {
                box-shadow: 0 0 15px #ffc107;
            }
        }

        .popular-badge {
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background: #ff00ff;
            color: #fff;
            padding: 0.4rem 1.2rem;
            border-radius: 20px;
            font-size: 1rem;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(255, 0, 255, 0.7);
        }

        .pricing-title {
            font-size: 1.8rem;
            margin-bottom: 1rem;
            color: #fff;
            text-shadow: 0 0 5px rgba(255, 255, 255, 0.5);
        }

        .pricing-price {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

            .pricing-price .currency {
                font-size: 2.5rem;
                color: #fff;
                margin-right: 0.5rem;
            }

            .pricing-price .amount {
                font-size: 3rem;
                color: #fff;
                font-weight: bold;
            }

            .pricing-price .real-price-container {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                margin-left: 1rem;
            }

            .pricing-price .real-price {
                font-size: 1.3rem;
                color: #ff5555;
                text-decoration: line-through;
                text-shadow: 0 0 3px rgba(255, 85, 85, 0.5);
            }

            .pricing-price .period {
                font-size: 1rem;
                color: #e0e0e0;
                text-shadow: 0 0 3px rgba(224, 224, 224, 0.5);
            }

        .pricing-subtext {
            font-size: 1rem;
            color: #e0e0e0;
            margin-bottom: 0;
            text-shadow: 0 0 3px rgba(224, 224, 224, 0.5);
        }

        .pricing-features {
            padding: 1.5rem;
            background: rgba(0, 0, 0, 0.5);
        }

            .pricing-features ul {
                list-style: none;
                padding: 0;
            }

            .pricing-features li {
                font-size: 1rem;
                margin-bottom: 0.5rem;
                text-shadow: 0 0 3px rgba(224, 224, 224, 0.5);
            }

        .pricing-footer {
            padding: 1.5rem;
        }

        .pricing-button {
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

            .pricing-button.free-trial {
                background: #6f42c1;
            }

            .pricing-button:hover {
                transform: translateY(-3px);
                box-shadow: 0 0 15px rgba(0, 123, 255, 0.7);
            }

            .pricing-button.free-trial:hover {
                box-shadow: 0 0 15px rgba(111, 66, 193, 0.7);
            }

        /* Pop-Up Ads */
        .popup-ad {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: linear-gradient(135deg, #0a0a23, #1a1a3d);
            border: 2px solid #00d4ff;
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0, 212, 255, 0.7);
            padding: 1.5rem;
            z-index: 1000;
            max-width: 450px;
            text-align: center;
            display: none;
            animation: glow 1.5s infinite alternate;
        }

        @keyframes glow {
            from {
                box-shadow: 0 0 10px #00d4ff;
            }

            to {
                box-shadow: 0 0 30px #00d4ff;
            }
        }

        .popup-ad img {
            width: 250px;
            height: 200px;
            border-radius: 10px;
            margin: 1rem 0;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.5);
        }

        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 999;
            display: none;
        }

        .close-popup {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 1.5rem;
            cursor: pointer;
            color: #ff5555;
            transition: all 0.3s ease;
        }

            .close-popup:hover {
                color: #ff0000;
                transform: rotate(90deg);
            }

        /* Footer Styling */
        footer {
            background: #0a0a23 !important;
            border-top: 1px solid #00d4ff;
            padding: 3rem 0;
        }

            footer h5 {
                font-family: 'Orbitron', sans-serif;
                font-weight: 700;
            }

            footer a:hover {
                color: #00d4ff !important;
                text-shadow: 0 0 10px #00d4ff;
            }

        /* Error Message Styling */
        .error-message {
            background-color: rgba(255, 0, 0, 0.2);
            border: 1px solid #ff5555;
            padding: 1rem;
            margin: 1rem 0;
            border-radius: 5px;
            color: #ff5555;
            text-align: center;
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
                    <li class="nav-item"><a class="nav-link" href="#courses">Courses</a></li>
                    <% if (Session["Username"] == null) { %>
                    <li class="nav-item"><a class="nav-link" href="#pricing">Pricing</a></li>
                    <% } %>
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
        <div class="error-message">
            <%= Session["ErrorMessage"] %>
        </div>
    </div>
    <% Session["ErrorMessage"] = null; %>
    <% } %>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 animate__animated animate__fadeInLeft">
                    <h1 class="display-4 fw-bold mb-4">Defend the Future: Master Cybersecurity</h1>
                    <p class="lead mb-4">Unleash your potential with elite training to combat cyber threats in a digital battlefield.</p>
                    <div class="d-grid gap-2 d-md-flex">
                        <a href="account.aspx" class="btn btn-primary btn-lg px-4 me-md-2 btn-animated">Launch Mission</a>
                        <a href="#courses" class="btn btn-outline-light btn-lg px-4 btn-animated">Explore Ops</a>
                    </div>
                    <div class="mt-4">
                        <span class="badge bg-dark text-light me-2"><i class="fas fa-users me-1"></i> 15,000+ Agents</span>
                        <span class="badge bg-dark text-light me-2"><i class="fas fa-star me-1"></i> 4.9/5 Rating</span>
                        <span class="badge bg-dark text-light"><i class="fas fa-lock me-1"></i> Elite Certified</span>
                    </div>
                </div>
                <div class="col-lg-6 animate__animated animate__fadeInRight">
                    <img src="https://via.placeholder.com/600x400?text=Cyber+Matrix" alt="Cybersecurity Ops" class="img-fluid rounded shadow">
                </div>
            </div>
        </div>
    </section>

    <!-- Moving Comments Ticker -->
    <section class="comments-ticker">
        <div class="ticker-content">
            <span class="mx-3"><i class="fas fa-skull-crossbones text-danger me-2"></i> Alert: "Just stopped a phishing attack thanks to Web Security Ops!" - Agent K</span>
            <span class="mx-3"><i class="fas fa-shield-alt text-success me-2"></i> Live Feedback: "Network Defense Tactics saved my company from a DDoS!" - Agent R</span>
            <span class="mx-3"><i class="fas fa-star text-warning me-2"></i> New Review: "5/5 stars—Secure Coding Protocols changed how I code!" - Agent M</span>
            <span class="mx-3"><i class="fas fa-lock text-info me-2"></i> Pro Tip: "Always use a VPN on public Wi-Fi to stay safe!" - CyberShield Team</span>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="py-5 bg-dark">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 mx-auto">
                    <h2 class="fw-bold mb-3 animate__animated animate__fadeIn">Why CyberShield Academy?</h2>
                    <p class="lead">Elite training for the ultimate cyber defense.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-4 animate__animated animate__fadeInUp">
                    <div class="card feature-card">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-white rounded-circle mb-4"><i class="fas fa-code"></i></div>
                            <h5 class="card-title">Live Hacking Sims</h5>
                            <p class="card-text">Engage in real-time hacking simulations to master defense tactics.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 animate__animated animate__fadeInUp">
                    <div class="card feature-card">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-white rounded-circle mb-4"><i class="fas fa-skull-crossbones"></i></div>
                            <h5 class="card-title">Dark Web Insights</h5>
                            <p class="card-text">Learn from real dark web threats with expert-led demos.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 animate__animated animate__fadeInUp">
                    <div class="card feature-card">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-white rounded-circle mb-4"><i class="fas fa-shield-alt"></i></div>
                            <h5 class="card-title">Zero-Day Defense</h5>
                            <p class="card-text">Stay ahead with strategies to counter the latest exploits.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Courses Section -->
    <section id="courses" class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 mx-auto">
                    <h2 class="fw-bold mb-3 animate__animated animate__fadeIn">Elite Cyber Ops Training</h2>
                    <p class="lead">Arm yourself with cutting-edge skills to dominate the cyber battlefield.</p>
                </div>
            </div>
            <div class="row g-4">
                <!-- Course 1: Web Security Ops -->
                <div class="col-lg-4 col-md-6">
                    <div class="card lab-card">
                        <img src="https://via.placeholder.com/400x150?text=Web+Security+Ops" alt="Web Security Ops" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">Web Security Ops</h5>
                            <p class="card-text">Infiltrate web vulnerabilities like XSS and SQL injection to fortify defenses.</p>
                            <div class="course-overlay">
                                <button class="btn btn-explore explore-course" data-course-id="web-security">Explore</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Course 2: Network Defense Tactics -->
                <div class="col-lg-4 col-md-6">
                    <div class="card lab-card">
                        <img src="https://via.placeholder.com/400x150?text=Network+Defense+Tactics" alt="Network Defense Tactics" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">Network Defense Tactics</h5>
                            <p class="card-text">Secure networks against advanced intrusions with elite strategies.</p>
                            <div class="course-overlay">
                                <button class="btn btn-explore explore-course" data-course-id="network-defense">Explore</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Course 3: Secure Coding Protocols -->
                <div class="col-lg-4 col-md-6">
                    <div class="card lab-card">
                        <img src="https://via.placeholder.com/400x150?text=Secure+Coding+Protocols" alt="Secure Coding Protocols" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">Secure Coding Protocols</h5>
                            <p class="card-text">Code like a pro to eliminate vulnerabilities in your applications.</p>
                            <div class="course-overlay">
                                <button class="btn btn-explore explore-course" data-course-id="secure-coding">Explore</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Course 4: Ethical Hacking Ops -->
                <div class="col-lg-4 col-md-6">
                    <div class="card lab-card">
                        <img src="https://via.placeholder.com/400x150?text=Ethical+Hacking+Ops" alt="Ethical Hacking Ops" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">Ethical Hacking Ops</h5>
                            <p class="card-text">Master penetration testing to expose and fix critical vulnerabilities.</p>
                            <div class="course-overlay">
                                <button class="btn btn-explore explore-course" data-course-id="ethical-hacking">Explore</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Course 5: Incident Response Unit -->
                <div class="col-lg-4 col-md-6">
                    <div class="card lab-card">
                        <img src="https://via.placeholder.com/400x150?text=Incident+Response+Unit" alt="Incident Response Unit" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">Incident Response Unit</h5>
                            <p class="card-text">Lead rapid response to neutralize cyber breaches effectively.</p>
                            <div class="course-overlay">
                                <button class="btn btn-explore explore-course" data-course-id="incident-response">Explore</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Course 6: Cloud Security Defense -->
                <div class="col-lg-4 col-md-6">
                    <div class="card lab-card">
                        <img src="https://via.placeholder.com/400x150?text=Cloud+Security+Defense" alt="Cloud Security Defense" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">Cloud Security Defense</h5>
                            <p class="card-text">Protect cloud systems from advanced threats with elite tactics.</p>
                            <div class="course-overlay">
                                <button class="btn btn-explore explore-course" data-course-id="cloud-security">Explore</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5">
                <a href="account.aspx" class="btn btn-lg btn-outline-primary btn-animated">Launch All Missions</a>
            </div>
        </div>
    </section>

    <!-- Pricing Section (Hidden if Logged In) -->
    <% if (Session["Username"] == null) { %>
    <section id="pricing" class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 mx-auto">
                    <h2 class="fw-bold mb-3 animate__animated animate__fadeIn">Select Your Cyber Plan</h2>
                    <p class="lead">Unlock elite tools for your cyber defense journey.</p>
                </div>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6 animate__animated animate__fadeInUp">
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h4 class="pricing-title">Cyber Novice</h4>
                            <div class="pricing-price">
                                <span class="currency">$</span>
                                <span class="amount">0</span>
                                <div class="real-price-container">
                                    <s class="real-price">$7.99</s>
                                    <span class="period">/month</span>
                                </div>
                            </div>
                            <p class="pricing-subtext">Start your learning journey</p>
                        </div>
                        <div class="pricing-features">
                            <ul>
                                <li><i class="fas fa-check text-success me-2"></i> 3 Basic Missions</li>
                                <li><i class="fas fa-check text-success me-2"></i> Cyber Quizzes</li>
                                <li><i class="fas fa-check text-success me-2"></i> Community Access</li>
                                <li><i class="fas fa-times text-danger me-2"></i> Advanced Labs</li>
                                <li><i class="fas fa-times text-danger me-2"></i> Certification Prep</li>
                                <li><i class="fas fa-times text-danger me-2"></i> Elite Mentoring</li>
                            </ul>
                        </div>
                        <div class="pricing-footer">
                            <button class="pricing-button free-trial w-100" id="freePlanBtn">Start My Free Trial for 30 Days</button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 animate__animated animate__fadeInUp">
                    <div class="pricing-card popular">
                        <div class="pricing-header">
                            <span class="popular-badge">Most Chosen</span>
                            <h4 class="pricing-title">Cyber Pro</h4>
                            <div class="pricing-price">
                                <span class="currency">$</span>
                                <span class="amount">11.99</span>
                                <div class="real-price-container">
                                    <s class="real-price">$29</s>
                                    <span class="period">/month</span>
                                </div>
                            </div>
                            <p class="pricing-subtext">Advance your skills</p>
                        </div>
                        <div class="pricing-features">
                            <ul>
                                <li><i class="fas fa-check text-success me-2"></i> 3 Basic Missions</li>
                                <li><i class="fas fa-check text-success me-2"></i> Cyber Quizzes</li>
                                <li><i class="fas fa-check text-success me-2"></i> Community Access</li>
                                <li><i class="fas fa-check text-success me-2"></i> Advanced Labs</li>
                                <li><i class="fas fa-check text-success me-2"></i> Certification Prep</li>
                                <li><i class="fas fa-times text-danger me-2"></i> Elite Mentoring</li>
                            </ul>
                        </div>
                        <div class="pricing-footer">
                            <button class="pricing-button w-100" id="standardPlanBtn">Get Started</button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 animate__animated animate__fadeInUp">
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <span class="discount-badge">50% OFF</span>
                            <h4 class="pricing-title">Cyber Elite</h4>
                            <div class="pricing-price">
                                <span class="currency">$</span>
                                <span class="amount">19.99</span>
                                <div class="real-price-container">
                                    <s class="real-price">$49.99</s>
                                    <span class="period">/month</span>
                                </div>
                            </div>
                            <p class="pricing-subtext">Master your expertise</p>
                        </div>
                        <div class="pricing-features">
                            <ul>
                                <li><i class="fas fa-check text-success me-2"></i> 3 Basic Missions</li>
                                <li><i class="fas fa-check text-success me-2"></i> Cyber Quizzes</li>
                                <li><i class="fas fa-check text-success me-2"></i> Community Access</li>
                                <li><i class="fas fa-check text-success me-2"></i> Advanced Labs</li>
                                <li><i class="fas fa-check text-success me-2"></i> Certification Prep</li>
                                <li><i class="fas fa-check text-success me-2"></i> Elite Mentoring</li>
                            </ul>
                        </div>
                        <div class="pricing-footer">
                            <button class="pricing-button w-100" id="premiumPlanBtn">Get Started</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <% } %>

    <!-- Call to Action -->
    <section class="py-5 bg-primary text-white">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 animate__animated animate__fadeIn">
                    <h2 class="fw-bold mb-3">Join the Cyber Elite Now!</h2>
                    <p class="lead mb-0">Become a defender of the digital realm with CyberShield Academy.</p>
                </div>
                <div class="col-lg-4 text-lg-end mt-4 mt-lg-0 animate__animated animate__fadeIn">
                    <a href="account.aspx" class="btn btn-light btn-lg px-4 btn-animated">Engage Now</a>
                </div>
            </div>
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
                        <li class="mb-2"><a href="#courses" class="text-white text-decoration-none">Web Security</a></li>
                        <li class="mb-2"><a href="#courses" class="text-white text-decoration-none">Network Defense</a></li>
                        <li class="mb-2"><a href="#courses" class="text-white text-decoration-none">Secure Coding</a></li>
                        <li><a href="#courses" class="text-white text-decoration-none">All Missions</a></li>
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

    <!-- Course Info Modal -->
    <div class="modal fade" id="courseInfoModal" tabindex="-1" aria-labelledby="courseInfoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="courseInfoModalLabel">Mission Briefing</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="courseInfoContent">
                </div>
                <div class="modal-footer">
                    <span class="fun-fact"></span>
                    <div>
                        <button type="button" class="btn btn-secondary btn-animated" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary btn-animated enroll-btn">🚀 Enroll Now!</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pop-Up Ads -->
    <div class="popup-overlay" id="popupOverlay1"></div>
    <div class="popup-ad animate__animated animate__zoomIn" id="popupAd1">
        <i class="fas fa-times close-popup" data-popup="1"></i>
        <h5>Last Chance!</h5>
        <h4>Save on Cyber Elite!</h4>
        <img src="https://via.placeholder.com/250x200?text=Cyber+Elite+Offer" alt="Cyber Elite Offer">
        <p>Act Now—Offer Ends Soon!</p>
        <button class="btn btn-success btn-lg w-100 btn-animated" id="specialOfferPopupBtn">Claim This Now</button>
    </div>

    <div class="popup-overlay" id="popupOverlay2"></div>
    <div class="popup-ad animate__animated animate__zoomIn" id="popupAd2">
        <i class="fas fa-times close-popup" data-popup="2"></i>
        <h5>Stay Secure!</h5>
        <h4>Free Cyber Tips!</h4>
        <img src="https://via.placeholder.com/250x200?text=Cyber+Tips" alt="Cyber Tips">
        <p>Essential Security Secrets!</p>
        <button class="btn btn-primary btn-lg w-100 btn-animated" id="downloadTipsBtn">Get Tips Now</button>
    </div>

    <div class="popup-overlay" id="popupOverlay3"></div>
    <div class="popup-ad animate__animated animate__zoomIn" id="popupAd3">
        <i class="fas fa-times close-popup" data-popup="3"></i>
        <h5>Secure Your Spot!</h5>
        <h4>Cyber Elite Webinar!</h4>
        <img src="https://via.placeholder.com/250x200?text=Webinar+Event" alt="Webinar Event">
        <p>Limited Seats Available!</p>
        <button class="btn btn-warning btn-lg w-100 btn-animated text-white" id="registerWebinarBtn">Join Now</button>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Course data
            const courses = {
                'web-security': {
                    title: 'Web Security Ops',
                    description: 'Infiltrate web vulnerabilities like XSS and SQL injection to fortify defenses.',
                    image: 'https://via.placeholder.com/600x300?text=Web+Security+Ops',
                    hasVideo: true,
                    hasCertificate: true,
                    hours: 12,
                    details: [
                        'Learn Secure Principles',
                        'Master Injection Defense',
                        'Explore Session Security'
                    ],
                    trivia: '💡 Fun Fact: The first XSS vulnerability was discovered in 1996!'
                },
                'network-defense': {
                    title: 'Network Defense Tactics',
                    description: 'Secure networks against advanced intrusions with elite strategies.',
                    image: 'https://via.placeholder.com/600x300?text=Network+Defense+Tactics',
                    hasVideo: false,
                    hasCertificate: true,
                    hours: 15,
                    details: [
                        'Learn Firewall Strategies',
                        'Master Intrusion Detection',
                        'Explore Network Monitoring'
                    ],
                    trivia: '💡 Fun Fact: The largest DDoS attack peaked at 2.5 Tbps!'
                },
                'secure-coding': {
                    title: 'Secure Coding Protocols',
                    description: 'Code like a pro to eliminate vulnerabilities in your applications.',
                    image: 'https://via.placeholder.com/600x300?text=Secure+Coding+Protocols',
                    hasVideo: true,
                    hasCertificate: true,
                    hours: 10,
                    details: [
                        'Learn Secure Principles',
                        'Master Injection Defense',
                        'Explore Session Security'
                    ],
                    trivia: '💡 Fun Fact: Over 80% of app vulnerabilities stem from coding errors!'
                },
                'ethical-hacking': {
                    title: 'Ethical Hacking Ops',
                    description: 'Master penetration testing to expose and fix critical vulnerabilities.',
                    image: 'https://via.placeholder.com/600x300?text=Ethical+Hacking+Ops',
                    hasVideo: true,
                    hasCertificate: true,
                    hours: 20,
                    details: [
                        'Learn Penetration Testing',
                        'Master Exploit Development',
                        'Explore Vulnerability Assessment'
                    ],
                    trivia: '💡 Fun Fact: Ethical hackers are also called "white hat" hackers!'
                },
                'incident-response': {
                    title: 'Incident Response Unit',
                    description: 'Lead rapid response to neutralize cyber breaches effectively.',
                    image: 'https://via.placeholder.com/600x300?text=Incident+Response+Unit',
                    hasVideo: false,
                    hasCertificate: false,
                    hours: 14,
                    details: [
                        'Learn Breach Analysis',
                        'Master Response Strategies',
                        'Explore Recovery Planning'
                    ],
                    trivia: '💡 Fun Fact: The average time to detect a breach is 280 days!'
                },
                'cloud-security': {
                    title: 'Cloud Security Defense',
                    description: 'Protect cloud systems from advanced threats with elite tactics.',
                    image: 'https://via.placeholder.com/600x300?text=Cloud+Security+Defense',
                    hasVideo: true,
                    hasCertificate: true,
                    hours: 18,
                    details: [
                        'Learn Cloud Architecture',
                        'Master Threat Detection',
                        'Explore Data Encryption'
                    ],
                    trivia: '💡 Fun Fact: 70% of companies store sensitive data in the cloud.'
                }
            };

            // Handle Explore buttons
            document.querySelectorAll('.explore-course').forEach(button => {
                button.addEventListener('click', () => {
                    const courseId = button.getAttribute('data-course-id');
                    const course = courses[courseId];
                    const modalContent = document.getElementById('courseInfoContent');
                    modalContent.innerHTML = `
                        <div class="course-header">
                            <h4>${course.title}</h4>
                            <p class="lead">${course.description}</p>
                        </div>
                        <div class="course-content">
                            <div class="course-info">
                                <div class="course-details">
                                    <p class="certification-available ${course.hasCertificate ? 'available' : 'not-available'}">
                                        <span class="icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Earn a CyberShield Certificate upon completion">🏆</span>
                                        <strong>CyberShield Certificate ${course.hasCertificate ? 'after completion' : 'not available'}</strong>
                                    </p>
                                    <p class="video-available ${course.hasVideo ? 'available' : 'not-available'}">
                                        <span class="icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Video tutorials available for this course">🎥</span>
                                        <strong>Video Content ${course.hasVideo ? 'available' : 'not available'}</strong>
                                    </p>
                                    <p class="estimated-time">
                                        <span class="icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Estimated time to complete the course">🕒</span>
                                        <strong>Duration Time ${course.hours} hours</strong>
                                    </p>
                                    <ul>
                                        ${course.details.map(detail => `<li>${detail}</li>`).join('')}
                                    </ul>
                                </div>
                            </div>
                            <div class="course-image-container">
                                <img src="${course.image}" alt="${course.title}" class="course-image">
                            </div>
                        </div>
                    `;

                    document.querySelector('.modal-footer .fun-fact').textContent = course.trivia;

                    // Initialize tooltips
                    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                    tooltipTriggerList.map(function (tooltipTriggerEl) {
                        return new bootstrap.Tooltip(tooltipTriggerEl);
                    });

                    const modal = new bootstrap.Modal(document.getElementById('courseInfoModal'));
                    modal.show();

                    // Set enroll button behavior
                    const enrollBtn = document.querySelector('#courseInfoModal .enroll-btn');
                    enrollBtn.setAttribute('data-course-id', courseId);
                });
            });

            // Handle Enroll buttons
            document.querySelectorAll('.enroll-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    const courseId = btn.getAttribute('data-course-id');
                    <% if (Session["Username"] != null) { %>
                        window.location.href = `course.aspx?courseId=${courseId}`;
                    <% } else { %>
                        window.location.href = 'account.aspx';
                    <% } %>
                });
            });

            // Pop-Up Logic
            const popups = [
                { overlay: document.getElementById('popupOverlay1'), ad: document.getElementById('popupAd1'), delay: 30000 },
                { overlay: document.getElementById('popupOverlay2'), ad: document.getElementById('popupAd2'), delay: 75000 },
                { overlay: document.getElementById('popupOverlay3'), ad: document.getElementById('popupAd3'), delay: 135000 }
            ];

            let currentPopupIndex = 0;
            let isPopupVisible = false;

            const showNextPopup = () => {
                if (isPopupVisible || currentPopupIndex >= popups.length) return;
                const currentPopup = popups[currentPopupIndex];
                currentPopup.overlay.style.display = 'block';
                currentPopup.ad.style.display = 'block';
                isPopupVisible = true;
            };

            const closePopup = (index) => {
                const currentPopup = popups[index];
                currentPopup.ad.classList.remove('animate__zoomIn');
                currentPopup.ad.classList.add('animate__zoomOut');
                setTimeout(() => {
                    currentPopup.overlay.style.display = 'none';
                    currentPopup.ad.style.display = 'none';
                    isPopupVisible = false;
                    currentPopupIndex++;
                    if (currentPopupIndex < popups.length) setTimeout(showNextPopup, 5000);
                }, 500);
            };

            popups.forEach((popup, index) => {
                setTimeout(() => { if (index === 0) showNextPopup(); }, popup.delay);
            });

            document.querySelectorAll('.close-popup').forEach(closeBtn => {
                closeBtn.addEventListener('click', () => {
                    const popupIndex = parseInt(closeBtn.getAttribute('data-popup')) - 1;
                    closePopup(popupIndex);
                });
            });

            document.getElementById('specialOfferPopupBtn')?.addEventListener('click', () => {
                closePopup(0);
                window.location.href = 'account.aspx?offer=special';
            });

            document.getElementById('downloadTipsBtn')?.addEventListener('click', () => {
                closePopup(1);
                window.location.href = 'resources.aspx?download=tips';
            });

            document.getElementById('registerWebinarBtn')?.addEventListener('click', () => {
                closePopup(2);
                window.location.href = 'events.aspx?event=webinar';
            });

            // Handle Pricing Buttons
            document.getElementById('freePlanBtn')?.addEventListener('click', () => {
                window.location.href = 'account.aspx?plan=free';
            });

            document.getElementById('standardPlanBtn')?.addEventListener('click', () => {
                window.location.href = 'account.aspx?plan=standard';
            });

            document.getElementById('premiumPlanBtn')?.addEventListener('click', () => {
                window.location.href = 'account.aspx?plan=premium';
            });
        });
    </script>
</body>
</html>