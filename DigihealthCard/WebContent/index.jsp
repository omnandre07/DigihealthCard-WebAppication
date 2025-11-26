<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>DigiHealthCard - Digital Health Records</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="https://tse3.mm.bing.net/th/id/OIP.GrzlZMeYAhOc7Yn3vKo6_AHaHa?w=512&h=512&rs=1&pid=ImgDetMain&o=7&rm=3" type="image/png">
  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
  
  <style>
    :root {
      --primary: #1f4ed8;
      --primary-light: #e0e7ff;
      --primary-dark: #1839b0;
      --dark: #1e293b;
      --light: #f8fafc;
      --gray: #64748b;
    }
    
    
    body {
      font-family: 'Poppins', sans-serif;
      background-color: var(--light);
      color: var(--dark);
      line-height: 1.6;
      padding-top: 70px; /* For fixed navbar */
    }

    .navbar {
      background-color: white;
      padding: 15px 0;
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1000;
      box-shadow: 0 2px 15px rgba(0,0,0,0.08);
      transition: all 0.3s ease;
    }
    
    .navbar.scrolled {
      padding: 10px 0;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }

    .navbar-brand {
      font-weight: 700;
      color: var(--primary);
      font-size: 1.4rem;
    }
    
    .navbar-brand .logo-subtext {
      font-size: 0.75rem;
      font-weight: 400;
      color: var(--gray);
      margin-left: 8px;
      padding-left: 8px;
      border-left: 1px solid var(--gray);
    }
    
    .nav-link {
      font-weight: 500;
      color: var(--dark);
      padding: 8px 15px !important;
      margin: 0 5px;
      position: relative;
      transition: all 0.3s ease;
    }
    
    .nav-link:hover {
      color: var(--primary);
    }
    
    .nav-link:after {
      content: '';
      position: absolute;
      width: 0;
      height: 2px;
      background: var(--primary);
      bottom: 0;
      left: 0;
      transition: width 0.3s ease;
    }
    
    .nav-link:hover:after {
      width: 100%;
    }
    
    .nav-link.active {
      color: var(--primary);
    }
    
    .nav-link.active:after {
      width: 100%;
    }
    
    .btn-nav {
      background-color: var(--primary);
      color: white;
      border-radius: 6px;
      padding: 8px 20px;
      font-weight: 500;
      transition: all 0.3s ease;
    }
    
    .btn-nav:hover {
      background-color: var(--primary-dark);
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(31, 78, 216, 0.2);
    }

    
    .footer {
      background-color: var(--dark);
      color: white;
      padding: 60px 0 30px;
    }
    
    .footer-logo {
      font-size: 1.5rem;
      font-weight: 700;
      color: white;
      margin-bottom: 20px;
    }
    
    .footer-about {
      color: var(--gray);
      margin-bottom: 20px;
    }
    
    .footer-links h5 {
      font-size: 1.1rem;
      font-weight: 600;
      margin-bottom: 20px;
      position: relative;
      padding-bottom: 10px;
    }
    
    .footer-links h5:after {
      content: '';
      position: absolute;
      left: 0;
      bottom: 0;
      width: 40px;
      height: 2px;
      background: var(--primary);
    }
    
    .footer-links ul {
      list-style: none;
      padding: 0;
    }
    
    .footer-links li {
      margin-bottom: 12px;
    }
    
    .footer-links a {
      color: var(--gray);
      text-decoration: none;
      transition: all 0.3s ease;
    }
    
    .footer-links a:hover {
      color: white;
      padding-left: 5px;
    }
    
    .social-links {
      margin-top: 20px;
    }
    
    .social-links a {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 36px;
      height: 36px;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 50%;
      color: white;
      margin-right: 10px;
      transition: all 0.3s ease;
    }
    
    .social-links a:hover {
      background: var(--primary);
      transform: translateY(-3px);
    }
    
    .footer-bottom {
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      padding-top: 20px;
      margin-top: 40px;
      color: var(--gray);
      font-size: 0.9rem;
    }
    
    .footer-bottom a {
      color: var(--gray);
      text-decoration: none;
      transition: all 0.3s ease;
    }
    
    .footer-bottom a:hover {
      color: white;
    }


  .hero-section {
    height: 100vh;
    min-height: 700px;
    position: relative;
    display: flex;
    align-items: center;
    background: linear-gradient(135deg, #1f4ed8 0%, #1839b0 100%);
    margin-top: -70px;
    overflow: hidden;
  }
  
  .hero-background {
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    z-index: 0;
  }
  
  .particle {
    position: absolute;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    backdrop-filter: blur(5px);
  }
  
  .particle:nth-child(1) {
    width: 300px;
    height: 300px;
    top: -50px;
    right: -50px;
    background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, rgba(31,78,216,0) 70%);
  }
  
  .particle:nth-child(2) {
    width: 150px;
    height: 150px;
    bottom: 100px;
    left: 100px;
    background: rgba(255, 255, 255, 0.05);
  }
  
  .particle:nth-child(3) {
    width: 80px;
    height: 80px;
    top: 30%;
    right: 20%;
    background: rgba(255, 255, 255, 0.08);
  }
  
  .particle:nth-child(4) {
    width: 200px;
    height: 200px;
    bottom: -50px;
    left: -50px;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(31,78,216,0) 70%);
  }
  
  .particle:nth-child(5) {
    width: 120px;
    height: 120px;
    top: 60%;
    left: 30%;
    background: rgba(255, 255, 255, 0.06);
  }
  
  .hero-content {
    position: relative;
    z-index: 2;
    color: white;
    padding-right: 2rem;
  }
  
  .hero-badge {
    display: inline-block;
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px);
    padding: 8px 16px;
    border-radius: 50px;
    margin-bottom: 20px;
    font-size: 0.85rem;
    font-weight: 500;
    letter-spacing: 1px;
    border: 1px solid rgba(255, 255, 255, 0.2);
  }
  
  .hero-title {
    font-size: 3.2rem;
    font-weight: 800;
    line-height: 1.2;
    margin-bottom: 1.5rem;
    text-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .hero-title-highlight {
    color: #93c5fd;
    position: relative;
    display: inline-block;
  }
  .small-text {
  font-size: 0.6em; /* or use px like 14px */
  display: block;
  margin-top: 5px;
}
  
  
  .hero-title-highlight:after {
    content: '';
    position: absolute;
    bottom: 5px;
    left: 0;
    width: 100%;
    height: 8px;
    background: rgba(147, 197, 253, 0.4);
    z-index: -1;
    border-radius: 4px;
  }
  
  .hero-subtitle {
    font-size: 1.3rem;
    opacity: 0.9;
    margin: 0 0 2.5rem;
    max-width: 90%;
    line-height: 1.6;
  }
  
  .hero-cta {
    display: flex;
    gap: 1rem;
    margin-bottom: 3rem;
  }
  
  .btn-hero-primary {
    background: white;
    color: var(--primary);
    padding: 12px 25px;
    border-radius: 8px;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  }
  
  .btn-hero-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    color: var(--primary-dark);
  }
  
  .btn-hero-primary i {
    margin-right: 8px;
    font-size: 1.2rem;
  }
  
  .btn-hero-secondary {
    background: transparent;
    color: white;
    padding: 12px 25px;
    border-radius: 8px;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    transition: all 0.3s ease;
    border: 2px solid rgba(255, 255, 255, 0.3);
  }
  
  .btn-hero-secondary:hover {
    background: rgba(255, 255, 255, 0.1);
    border-color: rgba(255, 255, 255, 0.5);
    transform: translateY(-3px);
  }
  
  .btn-hero-secondary i {
    margin-right: 8px;
    font-size: 1.2rem;
  }
  
  .hero-stats {
    display: flex;
    gap: 2rem;
  }
  
  .stat-item {
    text-align: center;
  }
  
  .stat-number {
    font-size: 1.8rem;
    font-weight: 700;
    margin-bottom: 0.25rem;
  }
  
  .stat-label {
    font-size: 0.9rem;
    opacity: 0.8;
  }
  
  .hero-image-container {
    position: relative;
    height: 100%;
    min-height: 500px;
  }
  
  .hero-glass-card {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 80%;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    padding: 15px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    z-index: 2;
    overflow: hidden;
  }
  
  .hero-main-image {
    width: 100%;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    transition: transform 0.5s ease;
  }
  
  .hero-glass-card:hover .hero-main-image {
    transform: scale(1.02);
  }
  
  .hero-image-badge {
    position: absolute;
    bottom: -15px;
    right: -15px;
    background: var(--primary-dark);
    color: white;
    padding: 8px 16px;
    border-radius: 50px;
    font-size: 0.85rem;
    font-weight: 500;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    display: flex;
    align-items: center;
    gap: 8px;
  }
  
  .hero-image-badge i {
    font-size: 1rem;
  }
  
  .hero-shape-1 {
    position: absolute;
    width: 200px;
    height: 200px;
    background: rgba(147, 197, 253, 0.15);
    border-radius: 30px;
    top: 10%;
    left: 10%;
    transform: rotate(45deg);
    z-index: 1;
  }
  
  .hero-shape-2 {
    position: absolute;
    width: 150px;
    height: 150px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 20px;
    bottom: 10%;
    right: 10%;
    transform: rotate(-15deg);
    z-index: 1;
  }
  
  @media (max-width: 992px) {
    .hero-title {
      font-size: 2.5rem;
    }
    
    .hero-subtitle {
      font-size: 1.1rem;
    }
    
    .hero-cta {
      flex-direction: column;
      gap: 1rem;
    }
    
    .hero-stats {
      justify-content: space-between;
    }
  }
  
  @media (max-width: 768px) {
    .hero-section {
      text-align: center;
      padding-top: 100px;
      min-height: auto;
      height: auto;
      padding-bottom: 80px;
    }
    
    .hero-content {
      padding-right: 0;
    }
    
    .hero-subtitle {
      max-width: 100%;
      margin-left: auto;
      margin-right: auto;
    }
    
    .hero-cta {
      justify-content: center;
    }
    
    .hero-title {
      font-size: 2.2rem;
    }
    
    .hero-stats {
      justify-content: center;
      gap: 1.5rem;
      margin-top: 2rem;
    }
  }
    .section {
      padding: 80px 0;
    }
    
    .section-title {
      color: var(--primary);
      font-weight: 700;
      margin-bottom: 40px;
      text-align: center;
    }

    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.05);
      transition: all 0.3s ease;
      height: 100%;
    }
    
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }
    
    .card-icon {
      font-size: 2.5rem;
      color: var(--primary);
      margin-bottom: 15px;
    }

    .login-card {
      text-align: center;
      padding: 30px;
    }

    .contact-form {
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    }

    .btn-primary {
      background-color: var(--primary);
      border: none;
      padding: 10px 25px;
      border-radius: 6px;
      font-weight: 500;
      transition: all 0.3s ease;
    }
    
    .btn-primary:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(31, 78, 216, 0.2);
    }
    
    .btn-outline-light {
      border: 2px solid white;
    }

    @media (max-width: 768px) {
      .hero-title {
        font-size: 2rem;
      }
      
      .hero-subtitle {
        font-size: 1rem;
      }
      
      .navbar {
        padding: 10px 0;
      }
    }
  </style>
</head>
<body>


<nav class="navbar navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand" href="#">
      DigiHealthCard<span class="logo-subtext">Health Record Wallet</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" href="#home">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#services">Services</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#login">Login</a>
        </li>
        <li class="nav-item ms-lg-2">
          <a class="btn btn-nav" href="#contact">Contact Us</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


<section class="hero-section" id="home">
  <div class="hero-background">
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
  </div>
  
  <div class="container">
    <div class="row align-items-center">
      <div class="col-lg-6">
        <div class="hero-content">
          <div class="hero-badge">
            <span>Innovative Healthcare Solution</span>
          </div>
       <h1 class="hero-title">
  <span class="hero-title-highlight">Digital</span> Health Card<br>
 
</h1>
         <p class="hero-subtitle">
            Secure, accessible, and efficient management of your medical history in one place.
            Join thousands who've modernized their healthcare experience.
          </p>
          <div class="hero-cta">
            <a href="#login" class="btn btn-hero-primary">
              <i class="bi bi-arrow-right-circle-fill"></i> Get Started Now
            </a>
            
          </div>
          
          <div class="hero-stats">
            <div class="stat-item">
              <div class="stat-number">10K+</div>
              <div class="stat-label">Patients</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">500+</div>
              <div class="stat-label">Doctors</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">99.9%</div>
              <div class="stat-label">Uptime</div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 d-none d-lg-block">
        <div class="hero-image-container">
          <div class="hero-glass-card">
            <img src="https://tse2.mm.bing.net/th/id/OIP.9sU0FGX_Gq4TRA8eDhjBSgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3" 
                 alt="Doctor using tablet" 
                 class="hero-main-image">
           
          </div>
          <div class="hero-shape-1"></div>
          <div class="hero-shape-2"></div>
        </div>
      </div>
    </div>
  </div>
</section>


<section id="about" class="section bg-white">
  <div class="container">
    <h2 class="section-title">About DigiHealthCard</h2>
    <div class="row align-items-center">
      <div class="col-lg-6 mb-4 mb-lg-0">
        <img src="https://ictprojects.mt/wp-content/uploads/2021/07/Digital-Health-2-1170x654.jpg"
             alt="Digital Health" 
             class="img-fluid rounded-3">
      </div>
      <div class="col-lg-6">
        <h4 class="mb-3">Your Health. Your Control.</h4>
        <p class="mb-4">
          DigiHealthCard is a modern, centralized digital health record system built for both patients and healthcare providers.
          Eliminate paper clutter, reduce wait times, and take control of your medical history.
        </p>
        <ul class="list-unstyled">
          <li class="mb-3">
            <i class="bi bi-cloud-check-fill text-primary me-2"></i> Cloud-Powered Access
          </li>
          <li class="mb-3">
            <i class="bi bi-shield-lock-fill text-primary me-2"></i> Bank-Level Security
          </li>
          <li class="mb-3">
            <i class="bi bi-phone-fill text-primary me-2"></i> Mobile Friendly
          </li>
          <li class="mb-3">
            <i class="bi bi-speedometer2 text-primary me-2"></i> Fast & Efficient
          </li>
        </ul>
      </div>
    </div>
  </div>
</section>

<!-- Services Section -->
<section id="services" class="section bg-light">
  <div class="container">
    <h2 class="section-title">Our Services</h2>
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card">
          <div class="card-body text-center">
            <div class="card-icon">
              <i class="bi bi-file-medical"></i>
            </div>
            <h5>Digital Health Records</h5>
            <p>Maintain comprehensive and up-to-date medical information securely online.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card">
          <div class="card-body text-center">
            <div class="card-icon">
              <i class="bi bi-people"></i>
            </div>
            <h5>Doctor & Patient Portal</h5>
            <p>Connect with healthcare professionals and manage appointments with ease.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card">
          <div class="card-body text-center">
            <div class="card-icon">
              <i class="bi bi-gear"></i>
            </div>
            <h5>Admin Control Panel</h5>
            <p>Streamline user management and monitor activity through a secure dashboard.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Login Section -->
<section id="login" class="section bg-white">
  <div class="container">
    <h2 class="section-title">Login As</h2>
    <div class="row g-4 justify-content-center">
      <div class="col-md-4">
        <div class="card login-card">
          <i class="bi bi-person-fill card-icon"></i>
          <h5>Patient</h5>
          <a href="patientLogin.jsp" class="btn btn-primary mt-3">Login</a>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card login-card">
          <i class="bi bi-heart-pulse card-icon"></i>
          <h5>Doctor</h5>
          <a href="doctorLogin.jsp" class="btn btn-primary mt-3">Login</a>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card login-card">
          <i class="bi bi-shield-lock card-icon"></i>
          <h5>Admin</h5>
          <a href="adminLogin.jsp" class="btn btn-primary mt-3">Login</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Contact Section -->
<section id="contact" class="section bg-light">
  <div class="container">
    <h2 class="section-title">Contact Us</h2>
    <div class="row">
      <div class="col-lg-6 mb-4 mb-lg-0">
        <div class="contact-form">
          <h4 class="mb-4">Send us a message</h4>
          <form action="sendContactMessage.jsp" method="post">
            <div class="mb-3">
              <input type="text" class="form-control" name="name" placeholder="Name" required>
            </div>
            <div class="mb-3">
              <input type="email" class="form-control" name="email" placeholder="Email" required>
            </div>
            <div class="mb-3">
              <textarea class="form-control" name="message" rows="4" placeholder="Message" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
          </form>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="p-4">
          <h4 class="mb-4">Contact Information</h4>
         
          <div class="d-flex align-items-start mb-4">
            <i class="bi bi-envelope-fill text-primary me-3 mt-1"></i>
            <div>
              <h5>Email</h5>
              <p>digihealthcard@gmail.com</p>
            </div>
          </div>
          <div class="d-flex align-items-start">
            <i class="bi bi-telephone-fill text-primary me-3 mt-1"></i>
            <div>
              <h5>Phone</h5>
              <p>+1 (234) 567-8900</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Professional Footer -->
<footer class="footer">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 mb-5 mb-lg-0">
        <div class="footer-logo">DigiHealthCard</div>
        <p class="footer-about">
          Empowering patients and providers with secure, accessible digital health records management.
        </p>
        <div class="social-links">
          <a href="#"><i class="bi bi-facebook"></i></a>
          <a href="#"><i class="bi bi-twitter"></i></a>
          <a href="#"><i class="bi bi-linkedin"></i></a>
          <a href="#"><i class="bi bi-instagram"></i></a>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
        <div class="footer-links">
          <h5>Quick Links</h5>
          <ul>
            <li><a href="#home">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#services">Services</a></li>
            <li><a href="#login">Login</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
        <div class="footer-links">
          <h5>Services</h5>
          <ul>
            <li><a href="#">Health Records</a></li>
         
            <li><a href="#">E-Prescriptions</a></li>
            <li><a href="#">Telehealth</a></li>
          </ul>
        </div>
      </div>
      <div class="col-lg-4 col-md-4">
        <div class="footer-links">
          <h5>Contact Info</h5>
          <ul>
            <li><i class="bi bi-envelope-fill me-2"></i> digihealthcard@gmail.com</li>
            <li><i class="bi bi-telephone-fill me-2"></i> +1 (234) 567-8900</li>
          </ul>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <div class="row align-items-center">
        <div class="col-md-6 text-md-start text-center mb-3 mb-md-0">
          &copy; 2025 DigiHealthCard. All rights reserved.
        </div>
        <div class="col-md-6 text-md-end text-center">
          <a href="#" class="me-3">Privacy Policy</a>
          <a href="#" class="me-3">Terms of Service</a>
          <a href="#">Sitemap</a>
        </div>
      </div>
    </div>
  </div>
</footer>


</body>
</html>