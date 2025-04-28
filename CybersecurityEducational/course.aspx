<%@ Page Language="C#" AutoEventWireup="true" CodeFile="course.aspx.cs" Inherits="CybersecurityEducational.Course" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberShield Academy - Course Tutorial</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
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
            0% { background-position: 0 0; }
            100% { background-position: 0 100px; }
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

        /* Header Section */
        .course-header {
            background: linear-gradient(135deg, rgba(13, 110, 253, 0.8), rgba(10, 88, 202, 0.8)), url('https://via.placeholder.com/1500x600?text=Cyber+Matrix');
            background-blend-mode: overlay;
            background-size: cover;
            background-position: center;
            padding: 5rem 0;
            color: white;
            text-shadow: 0 0 15px rgba(0, 0, 0, 0.7);
            position: relative;
        }

        .course-header h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: 3.5rem;
            font-weight: 900;
            animation: glitch 2s linear infinite;
        }

        @keyframes glitch {
            2%, 64% { transform: translate(2px, 0) skew(0deg); }
            4%, 60% { transform: translate(-2px, 0) skew(0deg); }
            62% { transform: translate(0, 0) skew(5deg); }
        }

        .course-header p.lead {
            font-size: 1.3rem;
            margin-bottom: 2rem;
        }

        /* Overview Section */
        .overview-section {
            padding: 3rem 0;
        }

        .overview-card {
            background: rgba(255, 255, 261, 0.05);
            border: 1px solid #00d4ff;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            border-radius: 15px;
            padding: 2rem;
            transition: all 0.3s ease;
        }

        .overview-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
        }

        .overview-card h2 {
            font-family: 'Orbitron', sans-serif;
            font-size: 2rem;
            color: #00d4ff;
            margin-bottom: 1rem;
        }

        .overview-card p {
            font-size: 1.1rem;
            color: #e0e0e0;
        }

        /* Video Section */
        .video-section {
            padding: 3rem 0;
            background: #1a1a3d;
        }

        .video-container iframe {
            width: 100%;
            height: 400px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.5);
        }

        .video-placeholder {
            width: 100%;
            height: 400px;
            background: rgba(255, 0, 0, 0.2);
            border: 2px dashed #ff5555;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ff5555;
            font-size: 1.2rem;
            text-align: center;
            padding: 1rem;
        }

        /* Practice Section */
        .practice-section {
            padding: 3rem 0;
        }

        .practice-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #00d4ff;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            transition: all 0.3s ease;
        }

        .practice-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
        }

        .practice-card h5 {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.5rem;
            color: #00d4ff;
            margin-bottom: 1rem;
        }

        .practice-card p {
            font-size: 1.1rem;
            color: #e0e0e0;
        }

        .practice-card img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            margin-top: 1rem;
            box-shadow: 0 0 10px rgba(0, 212, 255, 0.3);
        }

        .step-number {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            background: linear-gradient(45deg, #00d4ff, #ff00ff);
            border-radius: 50%;
            font-size: 1.2rem;
            font-weight: bold;
            margin-right: 1rem;
        }

        /* Subsection Heading */
        .subsection-heading {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.8rem;
            color: #ff00ff;
            margin-top: 2rem;
            margin-bottom: 1rem;
            text-shadow: 0 0 10px #ff00ff;
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
                    <li class="nav-item"><a class="nav-link active" href="#courses">Courses</a></li>
                    <% if (Session["Username"] == null) { %>
                        <li class="nav-item"><a class="nav-link" href="#pricing">Pricing</a></li>
                    <% } %>
                    <li class="nav-item"><a class="nav-link" href="security_lab.aspx">Security Lab</a></li>
                    <li class="nav-item"><a class="nav-link" href="account.aspx">Account</a></li>
                    <% if (Session["Username"] != null) { %>
                        <li class="nav-item">
                            <span class="nav-link text-white">
                                <i class="fas fa-user me-2"></i><%= Session["Username"] %>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white logout-btn" href="index.aspx?logout=true"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="account.aspx"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Course Header -->
    <section class="course-header">
        <div class="container">
            <h1 id="courseTitle">Course Title</h1>
            <p class="lead" id="courseDescription">Course Description</p>
        </div>
    </section>

    <!-- Overview Section -->
    <section class="overview-section">
        <div class="container">
            <h2 class="text-center fw-bold mb-5 animate__animated animate__fadeIn">Course Overview</h2>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="overview-card animate__animated animate__fadeIn">
                        <h2 id="overviewTitle">Overview</h2>
                        <p id="overviewDescription"></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Video Section -->
    <section class="video-section">
        <div class="container">
            <h2 class="text-center fw-bold mb-5 animate__animated animate__fadeIn">Watch the Tutorial Video</h2>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="video-container" id="videoContainer">
                        <!-- Video will be dynamically inserted here -->
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Practice Section -->
    <section class="practice-section">
        <div class="container">
            <h2 class="text-center fw-bold mb-5 animate__animated animate__fadeIn">How to Practice</h2>
            <div id="practiceSteps">
                <!-- Practice steps will be dynamically inserted here -->
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
                        <li class="mb-2"><a href="course.aspx?courseId=web-security" class="text-white text-decoration-none">Web Security</a></li>
                        <li class="mb-2"><a href="course.aspx?courseId=web-security#sql-injection" class="text-white text-decoration-none">SQL Injection</a></li>
                        <li class="mb-2"><a href="course.aspx?courseId=network-defense" class="text-white text-decoration-none">Network Defense</a></li>
                        <li class="mb-2"><a href="course.aspx?courseId=secure-coding" class="text-white text-decoration-none">Secure Coding</a></li>
                        <li><a href="#courses" class="text-white text-decoration-none">All Missions</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
                    <h5 class="mb-3">Resources</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-white text-decoration-none">Blog</a></li>
                        <li class="mb-2"><a href="#" class="text-white text-decoration-none">Webinars</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Community</a></li>
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
            // Course data
            const courses = {
                'web-security': {
                    title: 'Web Security Ops',
                    description: 'Learn how to infiltrate web vulnerabilities like XSS and SQL injection to fortify defenses.',
                    overview: 'This course teaches you how to identify and mitigate common web vulnerabilities, such as Cross-Site Scripting (XSS) and SQL injection, through hands-on practice and real-world scenarios.',
                    hasVideo: true,
                    videoEmbed: '<iframe width="100%" height="400" src="https://www.youtube.com/embed/VIDEO_ID_WEB_SECURITY" frameborder="0" allowfullscreen></iframe>',
                    practiceSteps: [
                        { 
                            title: 'XSS Vulnerability Testing', 
                            description: '<h3 class="subsection-heading" id="xss">Cross-Site Scripting (XSS)</h3>' +
                                         '<p>Follow these steps to practice identifying and mitigating XSS vulnerabilities:</p>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">1</span>Download the XSS Testing Tool</h5>' +
                                         '<p>Download the XSS testing tool from the provided link: <a href="https://example.com/xss-tool.zip" target="_blank">xss-tool.zip</a>.</p>' +
                                         '</div>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">2</span>Extract the File</h5>' +
                                         '<p>Unzip the downloaded file using a tool like WinRAR or 7-Zip to a folder on your desktop.</p>' +
                                         '</div>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">3</span>Place in C: Drive</h5>' +
                                         '<p>Move the extracted folder to your C: drive, e.g., <code>C:\\XSSTool</code>, to set up your testing environment.</p>' +
                                         '</div>'
                        },
                        { 
                            title: 'SQL Injection Defense', 
                            description: '<h3 class="subsection-heading" id="sql-injection">SQL Injection Defense</h3>' +
                                         '<p>Follow these steps to practice identifying and preventing SQL injection vulnerabilities:</p>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">1</span>Download the SQL Injection Scanner Tool</h5>' +
                                         '<p>Download the SQL Injection Scanner tool from the provided link: <a href="http://securityproject-001-site1.qtempurl.com/courses/SQLInjectionScanner.zip" target="_blank">SQLInjectionScanner.zip</a>.</p>' +
                                         '</div>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">2</span>Disable Windows Defender Real-Time Protection (Temporarily)</h5>' +
                                         '<p>This tool may be flagged by Windows Defender. To avoid issues, temporarily disable Windows Defender Real-Time Protection:<br>' +
                                         '1. Click the Start menu and type "Windows Security". Select the "Windows Security" app.<br><img src="/securityproject-001/WindowsSearch.png" alt="Search for Windows Security"><br>' +
                                         '2. In the Windows Security app, click on "Virus & threat protection".<br><img src="/securityproject-001/WindowsSecurityHome.png" alt="Windows Security Home"><br>' +
                                         '3. Click on "Manage settings" under "Virus & threat protection settings".<br><img src="/securityproject-001/VirusThreatProtection.png" alt="Virus & Threat Protection"><br>' +
                                         '4. Turn off "Real-time protection". You should see it set to "Off".<br><img src="/securityproject-001/RealTimeProtectionOff.png" alt="Real-Time Protection Off"><br>' +
                                         '<strong>Important:</strong> Re-enable Windows Defender after completing this course to keep your system secure.</p>' +
                                         '</div>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">3</span>Disable Microsoft Defender SmartScreen (Temporarily)</h5>' +
                                         '<p>Microsoft Defender SmartScreen may also block the tool. To disable it temporarily:<br>' +
                                         '1. In the Windows Security app, click on "App & browser control".<br><img src="/securityproject-001/WindowsSecurityHome.png" alt="Windows Security Home"><br>' +
                                         '2. Click on "Reputation-based protection settings".<br><img src="/securityproject-001/AppBrowserControl.png" alt="App & Browser Control"><br>' +
                                         '3. Turn off "Check apps and files". You should see it set to "Off".<br><img src="/securityproject-001/CheckAppsFilesOff.png" alt="Check Apps and Files Off"><br>' +
                                         '<strong>Important:</strong> Re-enable SmartScreen after completing this course to maintain your system’s security.</p>' +
                                         '</div>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">4</span>Extract the File</h5>' +
                                         '<p>Unzip the downloaded file using a tool like WinRAR or 7-Zip to a folder on your desktop.</p>' +
                                         '</div>' +
                                         '<div class="practice-card animate__animated animate__fadeInUp">' +
                                         '<h5><span class="step-number">5</span>Place in C: Drive</h5>' +
                                         '<p>Move the extracted folder to your C: drive, e.g., <code>C:\\SQLInjectionScanner</code>, to set up your testing environment.</p>' +
                                         '</div>'
                        }
                    ]
                },
                'network-defense': {
                    title: 'Network Defense Tactics',
                    description: 'Secure networks against advanced intrusions with elite strategies.',
                    overview: 'This course focuses on securing networks by implementing firewalls, detecting intrusions, and monitoring traffic to prevent cyber attacks.',
                    hasVideo: false,
                    practiceSteps: [
                        { title: 'Step 1: Download the Firewall Configuration Script', description: 'Download the firewall configuration script from this link: <a href="https://example.com/firewall-script.zip" target="_blank">firewall-script.zip</a>.' },
                        { title: 'Step 2: Open the Script', description: 'Extract the zip file and open the script in a text editor like Notepad or Visual Studio Code.' },
                        { title: 'Step 3: Save to C: Drive', description: 'Save the script in your C: drive under <code>C:\\FirewallConfig</code> for easy access during setup.' }
                    ]
                },
                'secure-coding': {
                    title: 'Secure Coding Protocols',
                    description: 'Code like a pro to eliminate vulnerabilities in your applications.',
                    overview: 'This course guides you through writing secure code by validating inputs, using secure APIs, and testing for vulnerabilities in your applications.',
                    hasVideo: true,
                    videoEmbed: '<iframe width="100%" height="400" src="https://www.youtube.com/embed/VIDEO_ID_SECURE_CODING" frameborder="0" allowfullscreen></iframe>',
                    practiceSteps: [
                        { title: 'Step 1: Download the Sample Code Project', description: 'Download the sample code project from this link: <a href="https://example.com/secure-coding-project.zip" target="_blank">secure-coding-project.zip</a>.' },
                        { title: 'Step 2: Extract and Open the Project', description: 'Unzip the file and open the project in an IDE like Visual Studio or IntelliJ IDEA.' },
                        { title: 'Step 3: Place in C: Drive', description: 'Move the project folder to your C: drive, e.g., <code>C:\\SecureCodingProject</code>, to begin practicing.' }
                    ]
                }
            };

            // Get courseId from URL
            const urlParams = new URLSearchParams(window.location.search);
            const courseId = urlParams.get('courseId');
            const course = courses[courseId] || { title: 'Course Not Found', description: 'Please select a valid course.', overview: 'No overview available.', practiceSteps: [], hasVideo: false };

            // Update header
            document.getElementById('courseTitle').textContent = course.title;
            document.getElementById('courseDescription').textContent = course.description;

            // Update overview section
            document.getElementById('overviewTitle').textContent = course.title;
            document.getElementById('overviewDescription').textContent = course.overview;

            // Update video section
            const videoContainer = document.getElementById('videoContainer');
            if (course.hasVideo && course.videoEmbed) {
                videoContainer.innerHTML = course.videoEmbed;
            } else {
                videoContainer.innerHTML = '<div class="video-placeholder">Video Content Not Available for This Course</div>';
            }

            // Populate practice steps
            const practiceSteps = document.getElementById('practiceSteps');
            course.practiceSteps.forEach((step) => {
                const stepCard = document.createElement('div');
                stepCard.className = 'practice-card animate__animated animate__fadeInUp';
                stepCard.innerHTML = `
                    <h5>${step.title}</h5>
                    <div>${step.description}</div>
                `;
                practiceSteps.appendChild(stepCard);
            });
        });
    </script>
</body>
</html>