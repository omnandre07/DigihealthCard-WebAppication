<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="main_project.Dbconnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Patient Login - DigiHealthCard</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>
    :root {
      --primary-blue: #2563eb;
      --dark-blue: #1e3a8a;
      --light-blue: #e0f7ff;
      --white: #ffffff;
      --gray-light: #f8fafc;
      --gray-medium: #e2e8f0;
      --gray-dark: #64748b;
      --error-red: #dc2626;
      --success-green: #16a34a;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', 'Roboto', system-ui, sans-serif;
      background: linear-gradient(135deg, var(--light-blue), var(--primary-blue), var(--dark-blue));
      background-size: 300% 300%;
      animation: gradientBG 12s ease infinite;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #1e293b;
      line-height: 1.6;
    }

    .login-container {
      width: 100%;
      max-width: 1000px;
      margin: 2rem;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
      display: flex;
      animation: fadeIn 0.8s ease-out;
    }

    .welcome-panel {
      flex: 1;
      background: rgba(37, 99, 235, 0.9);
      color: var(--white);
      padding: 3.5rem;
      display: flex;
      flex-direction: column;
      justify-content: center;
      position: relative;
      overflow: hidden;
    }

    .welcome-panel::before {
      content: '';
      position: absolute;
      top: -50%;
      right: -50%;
      width: 100%;
      height: 200%;
      background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
      transform: rotate(30deg);
    }

    .welcome-panel h1 {
      font-size: 2.25rem;
      font-weight: 700;
      margin-bottom: 1.5rem;
      position: relative;
      z-index: 1;
    }

    .welcome-panel p {
      font-size: 1rem;
      opacity: 0.9;
      position: relative;
      z-index: 1;
    }

    .login-panel {
      flex: 1;
      background: rgba(255, 255, 255, 0.96);
      backdrop-filter: blur(8px);
      padding: 3rem 2.5rem;
      display: flex;
      flex-direction: column;
    }

    .login-header {
      margin-bottom: 2.5rem;
      text-align: center;
    }

    .login-header h2 {
      color: var(--primary-blue);
      font-size: 1.75rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .login-header p {
      color: var(--gray-dark);
      font-size: 0.9rem;
    }

    .login-form {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }

    .form-group label {
      font-weight: 500;
      color: var(--dark-blue);
      font-size: 0.9rem;
    }

    .form-group input {
      padding: 0.875rem 1rem;
      border: 1px solid var(--gray-medium);
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.2s ease;
    }

    .form-group input:focus {
      outline: none;
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
    }

    .login-button {
      background-color: var(--primary-blue);
      color: white;
      border: none;
      padding: 1rem;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s ease;
      margin-top: 0.5rem;
    }

    .login-button:hover {
      background-color: #1d4ed8;
      transform: translateY(-1px);
    }

    .login-footer {
      margin-top: 2rem;
      text-align: center;
      font-size: 0.875rem;
      color: var(--gray-dark);
    }

    .login-footer-links {
      display: flex;
      justify-content: center;
      gap: 1.5rem;
      margin-bottom: 1rem;
    }

    .login-footer-links a {
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 500;
      display: inline-flex;
      align-items: center;
      gap: 0.4rem;
      transition: color 0.2s ease;
    }

    .login-footer-links a:hover {
      color: var(--dark-blue);
      text-decoration: underline;
    }

    .copyright {
      margin-top: 1.5rem;
      color: var(--gray-dark);
      font-size: 0.8rem;
    }

    .error-message {
      color: var(--error-red);
      background-color: rgba(220, 38, 38, 0.1);
      padding: 0.875rem 1rem;
      border-radius: 8px;
      font-size: 0.875rem;
      margin-top: 1rem;
      text-align: center;
      border: 1px solid rgba(220, 38, 38, 0.2);
      animation: fadeIn 0.3s ease-out;
    }

    @media (max-width: 768px) {
      .login-container {
        flex-direction: column;
        margin: 1rem;
        border-radius: 12px;
      }

      .welcome-panel {
        padding: 2rem 1.5rem;
      }

      .login-panel {
        padding: 2rem 1.5rem;
      }
    }

    @keyframes gradientBG {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>
  <div class="login-container">
    <div class="welcome-panel">
      <h1>Welcome Back</h1>
      <p>
        Access your comprehensive health records, manage appointments, and connect with your healthcare providers through our secure patient portal.
      </p>
    </div>

    <div class="login-panel">
      <div class="login-header">
        <h2>Patient Login</h2>
        <p>Sign in to access your DigiHealthCard account</p>
      </div>

      <form method="post" class="login-form">
        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" placeholder="Enter your email" required>
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="login-button">Sign In</button>
      </form>

      <div class="login-footer">
        <div class="login-footer-links">
          <a href="index.jsp"><i class="bi bi-arrow-left"></i> Back to Home</a>
          <a href="patientRegister.jsp"><i class="bi bi-person-plus"></i> Create Account</a>
        </div>
        <div class="copyright">
          &copy; <span id="current-year"></span> DigiHealthCard. All rights reserved.
        </div>
      </div>

      <%-- Login Validation (original JSP code preserved) --%>
      <%
        Connection con = Dbconnection.connect();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (email != null && password != null) {
          try {
            PreparedStatement pst = con.prepareStatement("SELECT * FROM patient WHERE email=? AND password=?");
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rst = pst.executeQuery();
            if (rst.next()) {
              session.setAttribute("patient", email);
              response.sendRedirect("patientDashboard.jsp");
              return;
            } else {
      %>
              <div class="error-message">Invalid email or password. Please try again.</div>
      <%
            }
          } catch (Exception e) {
      %>
            <div class="error-message">System error. Please try again later.</div>
      <%
          }
        }
      %>
    </div>
  </div>

  <script>
    // Set current year in footer
    document.getElementById('current-year').textContent = new Date().getFullYear();
  </script>
</body>
</html>