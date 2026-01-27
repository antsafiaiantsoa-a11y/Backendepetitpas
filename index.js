const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const session = require("express-session");
const bcrypt = require("bcryptjs");

const app = express();
const port = 3000;

app.use(cors({
  origin: "http://localhost:5174", 
  credentials: true
}));
app.use(express.json());
// ✅ rendre les images accessibles
app.use("/image", express.static("public/image"));

app.use(session({
  name: "sid",
  secret: "dev",
  resave: false,
  saveUninitialized: false,
  cookie: { secure: false, sameSite: "lax" }
}));

const conn = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "epetitpas"
});

conn.connect((err) => {
  if (err) {
    console.error("Erreur de connexion à la BDD :", err.message);
  } else {
    console.log("Connecté à la base de données MySQL");
  }
});

// 🔐 API d'inscription
app.post("/register", (req, res) => {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ error: "Tous les champs sont obligatoires." });
  }

  conn.query("SELECT * FROM users WHERE email = ?", [email], (err, results) => {
    if (err) return res.status(500).json({ error: "Erreur serveur." });
    if (results.length > 0) {
      return res.status(400).json({ error: "Cet email existe déjà." });
    }

    bcrypt.hash(password, 10, (err, hashedPassword) => {
      if (err) return res.status(500).json({ error: "Erreur lors du hachage." });

      conn.query(
        "INSERT INTO users (full_name, email, password_hash, accepted_terms, created_at) VALUES (?, ?, ?, ?, NOW())",
        [username, email, hashedPassword, true],
        (err, result) => {
          if (err) return res.status(500).json({ error: "Erreur lors de l'inscription." });

          // Récupérer l'utilisateur créé pour renvoyer ses infos
          conn.query(
            "SELECT id, full_name, email FROM users WHERE id = ?",
            [result.insertId],
            (err, userResult) => {
              if (err) return res.status(500).json({ error: "Erreur serveur." });

              res.status(201).json({
                message: "Inscription réussie !",
                user: userResult[0] // renvoie l'utilisateur créé
              });
            }
          );
        }
      );
    });
  });
});

// 🔑 API de connexion
app.post("/api/login", (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: "Email et mot de passe requis." });
  }

  conn.query("SELECT * FROM users WHERE email = ?", [email], (err, results) => {
    if (err) return res.status(500).json({ error: "Erreur serveur." });
    if (results.length === 0) return res.status(400).json({ error: "Utilisateur introuvable." });

    const user = results[0];

    bcrypt.compare(password, user.password_hash, (err, isMatch) => {
      if (err) return res.status(500).json({ error: "Erreur interne." });
      if (!isMatch) return res.status(400).json({ error: "Mot de passe incorrect." });

      // Connexion réussie
      req.session.userId = user.id;
      res.json({
        userid: user.id,
        token: "fake-jwt-token-" + user.id
      });
    });
  });
});

// GET profil
app.get("/api/users", (req, res) => {
  if (!req.session.userId) return res.status(401).json({ error: "Non autorisé" });

  conn.query(
    "SELECT id, full_name, email, avatar FROM users WHERE id = ?",
    [req.session.userId],
    (err, results) => {
      if (err) return res.status(500).json({ error: "Erreur serveur" });
      res.json(results[0]);
    }
  );
});

// PUT modification du profil
app.put("/api/users", (req, res) => {
  const { full_name, email } = req.body;
  if (!req.session.userId) return res.status(401).json({ error: "Non autorisé" });
  if (!full_name || !email) return res.status(400).json({ error: "Champs manquants" });

  conn.query(
    "UPDATE users SET full_name = ?, email = ? WHERE id = ?",
    [full_name, email, req.session.userId],
    (err) => {
      if (err) return res.status(500).json({ error: "Erreur serveur" });

      // Retourne les nouvelles infos
      conn.query(
        "SELECT id, full_name, email, avatar FROM users WHERE id = ?",
        [req.session.userId],
        (err, results) => {
          if (err) return res.status(500).json({ error: "Erreur serveur" });
          res.json({ message: "Profil mis à jour", user: results[0] });
        }
      );
    }
  );
});

conn.connect(err => {
  if(err) console.error("Erreur BDD:", err);
  else console.log("Connecté à MySQL !");
});

// 🔹 API pour récupérer les formations
app.get("/api/formations", (req, res) => {
  conn.query("SELECT * FROM formations", (err, results) => {
    if(err) return res.status(500).json({ error: err });
    res.json(results);
  });
});


app.listen(port, () => {
  console.log(`🚀 Serveur API lancé sur http://localhost:${port}`);
});
