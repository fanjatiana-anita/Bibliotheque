<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <h2>Authentification</h2>
    <form action="${pageContext.request.contextPath}/doLogin" method="post">
        <label for="pseudo">Pseudo:</label>
        <input type="text" id="pseudo" name="pseudo">
        <label for="pwd">Mot de passe:</label>
        <input type="text" id="pwd" name="pwd">
        <input type="submit" value="S'authentifier">
    </form>
</body>
</html>
