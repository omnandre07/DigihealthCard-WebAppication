<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection" %>
<%
    String doctorEmail = (String) session.getAttribute("doctor");
    String name = "", specialization = "", contact = "";

    if (doctorEmail != null) {
        try {
            Connection con = Dbconnection.connect();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM doctor WHERE email=?");
            pst.setString(1, doctorEmail);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                specialization = rs.getString("specialization");
                contact = rs.getString("contact");
            }
            con.close();
        } catch (Exception e) {
            out.println("Error loading profile: " + e.getMessage());
        }
    } else {
        response.sendRedirect("doctorLogin.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Doctor Profile | DigiHealthCard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f1f5f9;
        margin: 0;
        color: #1e293b;
    }
    .container {
        max-width: 650px;
        margin: 3rem auto;
        background: #fff;
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    }
    h2 {
        margin-bottom: 1.5rem;
        color: #1e40af;
        font-weight: 600;
        text-align: center;
    }
    label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
    }
    input, select {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        font-size: 1rem;
        margin-bottom: 1rem;
        transition: border 0.3s;
    }
    input:focus, select:focus {
        border-color: #2563eb;
        outline: none;
    }
    .btn {
        display: inline-block;
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 500;
        border: none;
        cursor: pointer;
        text-decoration: none;
        transition: background 0.3s ease;
    }
    .btn-primary {
        background-color: #2563eb;
        color: white;
    }
    .btn-primary:hover {
        background-color: #1e40af;
    }
    .btn-secondary {
        background-color: #64748b;
        color: white;
    }
    .btn-secondary:hover {
        background-color: #475569;
    }
    .btn-group {
        display: flex;
        justify-content: space-between;
        gap: 1rem;
    }
</style>
</head>
<body>

<div class="container">
    <h2><i class="fas fa-user-edit"></i> Edit Doctor Profile</h2>
    <form action="updateDoctorProfile.jsp" method="post">
        <label for="name">Full Name</label>
        <input type="text" name="name" id="name" value="<%= name %>" required>

        <label for="specialization">Specialization</label>
        <input type="text" name="specialization" id="specialization" value="<%= specialization %>" required>

        <label for="contact">Contact Number</label>
        <input type="text" name="contact" id="contact" value="<%= contact %>" required>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Changes</button>
            <a href="doctorDashboard.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
