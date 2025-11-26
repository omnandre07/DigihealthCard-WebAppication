<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="main_project.Dbconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Patient Registration - DigiHealthCard</title>
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

    .register-container {
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

    .register-panel {
      flex: 1;
      background: rgba(255, 255, 255, 0.96);
      backdrop-filter: blur(8px);
      padding: 3rem 2.5rem;
      display: flex;
      flex-direction: column;
    }

    .register-header {
      margin-bottom: 2.5rem;
      text-align: center;
    }

    .register-header h2 {
      color: var(--primary-blue);
      font-size: 1.75rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .register-header p {
      color: var(--gray-dark);
      font-size: 0.9rem;
    }

    .register-form {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.25rem;
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }

    .form-group.full-width {
      grid-column: span 2;
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

    .register-button {
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
      grid-column: span 2;
    }

    .register-button:hover {
      background-color: #1d4ed8;
      transform: translateY(-1px);
    }

    .login-footer {
      margin-top: 2rem;
      text-align: center;
      font-size: 0.875rem;
      color: var(--gray-dark);
    }

    .login-footer a {
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 500;
      display: inline-flex;
      align-items: center;
      gap: 0.4rem;
      transition: color 0.2s ease;
    }

    .login-footer a:hover {
      color: var(--dark-blue);
      text-decoration: underline;
    }

    .copyright {
      margin-top: 1.5rem;
      color: var(--gray-dark);
      font-size: 0.8rem;
    }

    .message {
      color: var(--error-red);
      background-color: rgba(220, 38, 38, 0.1);
      padding: 0.875rem 1rem;
      border-radius: 8px;
      font-size: 0.875rem;
      margin-top: 1rem;
      text-align: center;
      border: 1px solid rgba(220, 38, 38, 0.2);
      animation: fadeIn 0.3s ease-out;
      grid-column: span 2;
    }

    .success-message {
      color: var(--success-green);
      background-color: rgba(22, 163, 74, 0.1);
      border: 1px solid rgba(22, 163, 74, 0.2);
    }

    @media (max-width: 768px) {
      .register-container {
        flex-direction: column;
        margin: 1rem;
        border-radius: 12px;
      }

      .welcome-panel {
        padding: 2rem 1.5rem;
      }

      .register-panel {
        padding: 2rem 1.5rem;
      }

      .register-form {
        grid-template-columns: 1fr;
      }

      .form-group.full-width,
      .register-button,
      .message {
        grid-column: span 1;
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
  <div class="register-container">
    <div class="welcome-panel">
      <h1>Join DigiHealthCard</h1>
      <p>
        Register to securely access your health records, manage appointments, and connect with your healthcare providers.
      </p>
    </div>

    <div class="register-panel">
      <div class="register-header">
        <h2>Patient Registration</h2>
        <p>Create your account to get started</p>
      </div>

      <form method="post" class="register-form">
        <div class="form-group">
          <label for="name">Full Name</label>
          <input type="text" id="name" name="name" placeholder="Enter your full name" required>
        </div>

        <div class="form-group">
          <label for="age">Age</label>
          <input type="number" id="age" name="age" placeholder="Enter your age" min="1" required>
        </div>

        <div class="form-group full-width">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" placeholder="Enter your email" required>
        </div>

        <div class="form-group">
          <label for="contact">Contact Number</label>
          <input type="tel" id="contact" name="contact" placeholder="Enter phone number" required>
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Create password" required minlength="8">
        </div>

        <div class="form-group">
          <label for="confirm">Confirm Password</label>
          <input type="password" id="confirm" name="confirm" placeholder="Confirm password" required>
        </div>

        <button type="submit" class="register-button">Register Now</button>

        <%-- Display messages --%>
        <%
          String name = request.getParameter("name");
          String ageStr = request.getParameter("age");
          String email = request.getParameter("email");
          String contact = request.getParameter("contact");
          String password = request.getParameter("password");
          String confirm = request.getParameter("confirm");

          if (name != null && ageStr != null && email != null && contact != null && password != null && confirm != null) {
              if (!password.equals(confirm)) {
        %>
        <div class="message">Passwords do not match</div>
        <%
              } else {
                  try {
                      Connection con = Dbconnection.connect();
                      PreparedStatement check = con.prepareStatement("SELECT * FROM patient WHERE email = ?");
                      check.setString(1, email);
                      ResultSet rs = check.executeQuery();

                      if (rs.next()) {
        %>
        <div class="message">Email already registered</div>
        <%
                      } else {
                          PreparedStatement pst = con.prepareStatement(
                              "INSERT INTO patient(name, age, email, contact, password) VALUES (?, ?, ?, ?, ?)");
                          pst.setString(1, name);
                          pst.setInt(2, Integer.parseInt(ageStr));
                          pst.setString(3, email);
                          pst.setString(4, contact);
                          pst.setString(5, password);
                          pst.executeUpdate();
        %>
        <div class="message success-message">Registration successful! Redirecting to login...</div>
        <script>setTimeout(() => window.location.href = 'patientLogin.jsp', 2000);</script>
        <%
                      }
                  } catch (Exception e) {
        %>
        <div class="message">Error: <%= e.getMessage() %></div>
        <%
                  }
              }
          }
        %>
      </form>

      <div class="login-footer">
        <a href="patientLogin.jsp"><i class="bi bi-box-arrow-in-right"></i> Already have an account? Login</a>
        <div class="copyright">
          &copy; <span id="current-year"></span> DigiHealthCard. All rights reserved.
        </div>
      </div>
    </div>
  </div>

  <script>
    // Set current year in footer
    document.getElementById('current-year').textContent = new Date().getFullYear();
  </script>
</body>
</html>