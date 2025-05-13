<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'util.php';
require_once 'sms.php';
require_once 'db.php';
include 'menu.php';

// Log raw input for debugging
error_log("Raw POST data: " . file_get_contents('php://input'));

$sessionId = filter_input(INPUT_POST, 'sessionId', FILTER_DEFAULT);
$phoneNumber = filter_input(INPUT_POST, 'phoneNumber', FILTER_DEFAULT);
$serviceCode = filter_input(INPUT_POST, 'serviceCode', FILTER_DEFAULT);
$text = filter_input(INPUT_POST, 'text', FILTER_DEFAULT);

// Add error logging
error_log("USSD Request - SessionId: $sessionId, Phone: $phoneNumber, ServiceCode: $serviceCode, Text: $text");

// Ensure proper USSD response format
header('Content-Type: text/plain');

if (!$sessionId || !$phoneNumber || !$serviceCode) {
    error_log("USSD Error - Missing required parameters");
    echo "END Invalid request parameters";
    exit;
}

try {
    $db = new Database();
    $conn = $db->getConnection();
} catch (Exception $e) {
    error_log("Database connection failed: " . $e->getMessage());
    echo "END System error. Please try again later.";
    exit;
}

$isRegistered = false;
try {
    $stmt = $conn->prepare("SELECT id FROM users WHERE phone_number = ?");
    $stmt->execute([$phoneNumber]);
    $isRegistered = $stmt->rowCount() > 0;
} catch (PDOException $e) {
    error_log("Database query failed: " . $e->getMessage());
    echo "END System error. Please try again later.";
    exit;
}

$menu = new Menu($phoneNumber, $conn);
$text = $menu->middleware($text);

if ($text === null || trim($text) === "") {
    if (!$isRegistered) {
        $menu->mainMenuUnregistered();
    } else {
        $menu->userMenu();
    }
} else if (!$isRegistered) {
    $textArray = explode("*", $text);
    $menu->menuRegister($textArray);
} else {
    $textArray = explode("*", $text);
    $menu->menuUserActions($textArray);
}
?> 