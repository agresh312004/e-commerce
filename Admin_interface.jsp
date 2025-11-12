<!DOCTYPE html>
<%
            session = request.getSession(false);
        if (session == null || session.getAttribute("Admin_name") == null) {
            response.sendRedirect("Adminlog.jsp");
            return;
        }

%>



<html lang="en">
<head>
  <title>HOME PAGE</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
  <style>
    :root {
      --text: #ffffff;
      --btn-bg: rgba(255, 255, 255, 0.15);
      --btn-hover: rgba(255, 255, 255, 0.25);
      --shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
      --radius: 14px;
    }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      font-family: 'Inter', system-ui, sans-serif;
      color: var(--text);
      overflow: hidden;
      background: linear-gradient(270deg, #667eea, #764ba2, #ff6a00, #ffcc00);
      background-size: 800% 800%;
      animation: gradientAnimation 20s ease infinite;
      position: relative;
    }
    /* Animated gradient */
    @keyframes gradientAnimation {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }
    h1 {
    font-size: 3.5rem;
    margin-bottom: 60px;
    text-align: center;
      text-shadow: 2px 2px 20px rgba(0,0,0,0.3);
      animation: fadeInDown 1s ease-out forwards;
      z-index: 2;
      position: relative;
    }
    .btn-container {
      display: flex;
      gap: 40px;
      flex-wrap: wrap;
      z-index: 2;
      position: relative;
    }

    .btn {
      padding: 18px 50px;
      font-size: 1.25rem;
      font-weight: 700;
      color: var(--text);
      background: var(--btn-bg);
      border: 2px solid rgba(255,255,255,0.3);
      border-radius: var(--radius);
      cursor: pointer;
      box-shadow: var(--shadow);
      text-decoration: none;
      text-align: center;
      transition: all 0.4s ease;
      backdrop-filter: blur(10px);
      animation: floatUp 1.5s ease-in-out infinite alternate, fadeIn 1s ease forwards;
    }

    .btn:hover {
      background: var(--btn-hover);
      transform: translateY(-6px) scale(1.1);
      box-shadow: 0 18px 45px rgba(0,0,0,0.4);
      border-color: rgba(255,255,255,0.5);
    }

    /* Button animations */
    @keyframes floatUp {
      0% { transform: translateY(0); }
      100% { transform: translateY(-10px); }
    }

    @keyframes fadeIn {
      0% { opacity: 0; transform: translateY(20px); }
      100% { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeInDown {
      0% { opacity: 0; transform: translateY(-50px); }
      100% { opacity: 1; transform: translateY(0); }
    }

    /* Particle container */
    .particles {
      position: absolute;
      width: 100%;
      height: 100%;
      overflow: hidden;
      top: 0;
      left: 0;
      z-index: 1;
    }

    .particle {
      position: absolute;
      background: rgba(255, 255, 255, 0.5);
      border-radius: 50%;
      opacity: 0.6;
      animation: floatParticle linear infinite;
    }

    @keyframes floatParticle {
      0% { transform: translateY(0) translateX(0); opacity: 0.5; }
      50% { opacity: 1; }
      100% { transform: translateY(-100vh) translateX(50px); opacity: 0; }
    }
    @media(max-width: 600px) {
      .btn-container { flex-direction: column; gap: 25px; }
      h1 { font-size: 2.5rem; margin-bottom: 40px; }
      .btn { width: 200px; padding: 15px; }
    }
  </style>
</head>
<body>
  <h1>Connect Buyers & Sellers Seamlessly</h1>
  <div class="btn-container">
    <a href="Seller_Info.jsp" class="btn">Seller_Info</a>
    <a href="AdminConfirm.jsp" class="btn">Customer_Info</a>
     
  </div>
  <!-- Particle background -->
  <div class="particles" id="particles"></div>

  <script>
    const particlesContainer = document.getElementById('particles');
    const particleCount = 50;

    for(let i = 0; i < particleCount; i++){
      const particle = document.createElement('div');
      particle.classList.add('particle');
      const size = Math.random() * 6 + 4; // 4px - 10px
      particle.style.width = `${size}px`;
      particle.style.height = `${size}px`;
      particle.style.left = `${Math.random() * 100}%`;
      particle.style.animationDuration = `${Math.random() * 10 + 10}s`;
      particle.style.animationDelay = `${Math.random() * 10}s`;
      particlesContainer.appendChild(particle);
    }
  </script>
</body>
</html>
