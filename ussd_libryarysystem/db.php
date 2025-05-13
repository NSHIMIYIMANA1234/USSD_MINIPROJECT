<?php
class Database {
    private $host = 'localhost';
    private $db_name;
    private $username;
    private $password;
    private $conn;

    public function __construct() {
        $this->db_name = Util::$DB_NAME;
        $this->username = Util::$DB_USER;
        $this->password = Util::$DB_PASSWORD;
    }

    public function getConnection() {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name,
                $this->username,
                $this->password
            );
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $exception) {
            throw new Exception("Connection error: " . $exception->getMessage());
        }
        return $this->conn;
    }
} 