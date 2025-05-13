<?php
require_once 'sms.php';
require_once 'util.php';

class Menu {
    protected $phoneNumber;
    protected $conn;
    protected $smsService;

    function __construct($phoneNumber, $conn) {
        $this->phoneNumber = $phoneNumber;
        $this->conn = $conn;
        $this->smsService = new SmsService($phoneNumber);
    }

    // Log a transaction
    protected function logTransaction($userId, $action, $details = null) {
        try {
            $stmt = $this->conn->prepare("INSERT INTO transactions (user_id, action, details) VALUES (?, ?, ?)");
            $stmt->execute([$userId, $action, $details]);
        } catch (PDOException $e) {
            error_log("Transaction log failed: " . $e->getMessage());
        }
    }

    public function mainMenuUnregistered() {
        echo "CON Welcome to MOBI Library\n1. Register\n";
    }

    public function menuRegister($textArray) {
        $level = count($textArray);
        if ($level == 1) {
            echo "CON Enter your full name";
        } else if ($level == 2) {
            echo "CON Enter your phone number";
        } else if ($level == 3) {
            $phone = $textArray[2];
            // Format phone number to match Rwanda format
            if (strpos($phone, '+250') !== 0) {
                $phone = '+250' . ltrim($phone, '0');
            }
            $stmt = $this->conn->prepare("SELECT id FROM users WHERE phone_number = ?");
            $stmt->execute([$phone]);
            if ($stmt->rowCount() > 0) {
                echo "END Enter another phone number";
                return;
            }
            echo "CON Enter password";
        } else if ($level == 4) {
            echo "CON Re-enter password";
        } else if ($level == 5) {
            $name = $textArray[1];
            $phone = $textArray[2];
            // Format phone number to match Rwanda format
            if (strpos($phone, '+250') !== 0) {
                $phone = '+250' . ltrim($phone, '0');
            }
            $password = $textArray[3];
            $confirm = $textArray[4];
            
            if ($password !== $confirm) {
                echo "END Passwords do not match. Please try again.";
                return;
            }

            try {
                // Start transaction
                $this->conn->beginTransaction();

                // Insert user into database
                $stmt = $this->conn->prepare("INSERT INTO users (name, phone_number, password) VALUES (?, ?, ?)");
                $stmt->execute([$name, $phone, password_hash($password, PASSWORD_DEFAULT)]);
                $userId = $this->conn->lastInsertId();
                
                // Log the transaction
                $this->logTransaction($userId, 'register', "Registered with $phone");
                
                // Commit transaction
                $this->conn->commit();
                
                // Prepare and send welcome SMS
                $smsMessage = "Welcome to MOBI Library!\n\n";
                $smsMessage .= "Dear $name,\n\n";
                $smsMessage .= "Thank you for registering with MOBI Library. Your registration was successful.\n\n";
                $smsMessage .= "Your details:\n";
                $smsMessage .= "- Name: $name\n";
                $smsMessage .= "- Phone: $phone\n\n";
                $smsMessage .= "You can now access our library services by dialing *384*29993#\n\n";
                $smsMessage .= "Best regards,\nMOBI Library Team";
                
                error_log("Attempting to send registration SMS to: " . $phone);
                $smsStatus = sendSMS($phone, $smsMessage);
                error_log("Registration SMS Status: " . $smsStatus);
                
                if ($smsStatus === 'success') {
                    echo "END Registration successful! You will receive a confirmation SMS shortly.";
                } else {
                    echo "END Registration successful! However, we couldn't send the confirmation SMS. Please try again later.";
                }
            } catch (PDOException $e) {
                // Rollback transaction on error
                $this->conn->rollBack();
                error_log("Registration failed: " . $e->getMessage());
                echo "END Registration failed. Please try again later.";
            }
        }
    }

    public function userMenu() {
        // Log menu view
        $stmt = $this->conn->prepare("SELECT id FROM users WHERE phone_number = ?");
        $stmt->execute([$this->phoneNumber]);
        $userId = $stmt->fetchColumn();
        $this->logTransaction($userId, 'menu', "Viewed main menu");
        echo "CON Welcome back\n1. View my borrowed books\n2. Search book\n3. Borrow book\n4. Exit\n";
    }

    public function menuUserActions($textArray) {
        $level = count($textArray);
        $stmt = $this->conn->prepare("SELECT id FROM users WHERE phone_number = ?");
        $stmt->execute([$this->phoneNumber]);
        $userId = $stmt->fetchColumn();
        
        if ($level == 1) {
            $this->userMenu();
        } else if ($level == 2) {
            switch ($textArray[1]) {
                case 1:
                    $this->logTransaction($userId, 'view_borrowed', "Viewed borrowed books");
                    $this->myBorrowedBooks();
                    break;
                case 2:
                    $this->logTransaction($userId, 'search_prompt', "Prompted for book category");
                    echo "CON Enter book category";
                    break;
                case 3:
                    $this->logTransaction($userId, 'borrow_prompt', "Prompted for book name");
                    echo "CON Enter book name";
                    break;
                case 4:
                    $this->logTransaction($userId, 'exit', "Exited menu");
                    echo "END Thank you for using MOBI Library.";
                    break;
                default:
                    echo "END Invalid option.";
            }
        } else if ($level == 3) {
            switch ($textArray[1]) {
                case 2:
                    $this->logTransaction($userId, 'search', "Searched for category: {$textArray[2]}");
                    $this->searchBook($textArray[2]);
                    break;
                case 3:
                    $this->logTransaction($userId, 'borrow', "Tried to borrow: {$textArray[2]}");
                    $this->borrowBook($textArray[2]);
                    break;
                default:
                    echo "END Invalid option.";
            }
        } else if ($level == 4 && $textArray[1] == 3) {
            // Handle book borrowing confirmation
            if ($textArray[3] == 1) {
                $this->borrowBook($textArray[2], true);
            } else if ($textArray[3] == 2) {
                echo "END Book borrowing cancelled.";
            } else {
                echo "END Invalid option.";
            }
        } else {
            echo "END Invalid option.";
        }
    }

    protected function myBorrowedBooks() {
        try {
            $stmt = $this->conn->prepare("SELECT id FROM users WHERE phone_number = ?");
            $stmt->execute([$this->phoneNumber]);
            $userId = $stmt->fetchColumn();

            $stmt = $this->conn->prepare("SELECT b.title FROM borrowed_books bb JOIN books b ON bb.book_id = b.id WHERE bb.user_id = ?");
            $stmt->execute([$userId]);
            $books = $stmt->fetchAll(PDO::FETCH_COLUMN);
            if (!$books) {
                echo "END No books borrowed.";
            } else {
                $msg = "MOBI Library - Your Borrowed Books\n\n";
                $msg .= "Dear User,\n\n";
                $msg .= "Here are your currently borrowed books:\n\n";
                foreach ($books as $index => $book) {
                    $msg .= ($index + 1) . ". " . $book . "\n";
                }
                $msg .= "\nPlease return these books within 14 days of borrowing.\n\n";
                $msg .= "Thank you for using MOBI Library!";
                
                $smsResult = $this->smsService->sendSms($msg, $this->phoneNumber);
                if ($smsResult && isset($smsResult['status']) && $smsResult['status'] === 'success') {
                    echo "END You will receive an SMS with your borrowed books list shortly.";
                } else {
                    echo "END Failed to send SMS. Please try again later.";
                }
            }
        } catch (PDOException $e) {
            error_log("Fetch borrowed books failed: " . $e->getMessage());
            echo "END Failed. Please try again later.";
        }
    }

    protected function searchBook($category) {
        try {
            $stmt = $this->conn->prepare("SELECT id, title FROM books WHERE LOWER(category) LIKE LOWER(?) LIMIT 1");
            $stmt->execute(['%' . $category . '%']);
            $book = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!$book) {
                echo "CON The book not found\n1. Try another search\n98. Back\n99. Back to main menu\n2. Exit";
            } else {
                // Store book id in session or pass as part of the next input if needed
                echo "CON Your search available: {$book['title']}\n1. Borrow\n98. Back\n99. Back to main menu\n2. Exit";
            }
        } catch (PDOException $e) {
            error_log("Search book failed: " . $e->getMessage());
            echo "END Failed. Please try again later.";
        }
    }

    protected function borrowBook($bookNameOrId, $confirmStep = false) {
        try {
            $stmt = $this->conn->prepare("SELECT id FROM users WHERE phone_number = ?");
            $stmt->execute([$this->phoneNumber]);
            $userId = $stmt->fetchColumn();

            // Get user's name for the SMS
            $stmt = $this->conn->prepare("SELECT name FROM users WHERE id = ?");
            $stmt->execute([$userId]);
            $userName = $stmt->fetchColumn();

            // Try to get book by ID first, then by name
            if (is_numeric($bookNameOrId)) {
                $stmt = $this->conn->prepare("SELECT id, title, available_copies FROM books WHERE id = ?");
                $stmt->execute([$bookNameOrId]);
            } else {
                $stmt = $this->conn->prepare("SELECT id, title, available_copies FROM books WHERE title LIKE ? LIMIT 1");
                $stmt->execute(['%' . $bookNameOrId . '%']);
            }
            $book = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if (!$book) {
                // Send SMS for book not found
                $smsMessage = "MOBI Library - Book Search Result\n\n";
                $smsMessage .= "Dear $userName,\n\n";
                $smsMessage .= "We couldn't find the book you were looking for.\n";
                $smsMessage .= "Search term: $bookNameOrId\n\n";
                $smsMessage .= "Please try searching with a different title or category.\n\n";
                $smsMessage .= "Thank you for using MOBI Library!";
                
                error_log("Attempting to send 'book not found' SMS to: " . $this->phoneNumber);
                $smsStatus = sendSMS($this->phoneNumber, $smsMessage);
                error_log("SMS Status for 'book not found': " . $smsStatus);
                
                echo "END Book not found. You will receive an SMS with details.";
                return;
            }

            // If not yet confirmed, show confirmation menu
            if (!$confirmStep) {
                echo "CON Are you sure you want to borrow this book?\n1. Confirm\n2. Cancel\n3. Exit";
                return;
            }

            // If confirmed, check if already borrowed
            $stmt = $this->conn->prepare("SELECT id FROM borrowed_books WHERE user_id = ? AND book_id = ?");
            $stmt->execute([$userId, $book['id']]);
            if ($stmt->rowCount() > 0) {
                // Send SMS for already borrowed
                $smsMessage = "MOBI Library - Book Already Borrowed\n\n";
                $smsMessage .= "Dear $userName,\n\n";
                $smsMessage .= "You have already borrowed this book:\n";
                $smsMessage .= "Title: {$book['title']}\n\n";
                $smsMessage .= "Please return it before borrowing again.\n\n";
                $smsMessage .= "Thank you for using MOBI Library!";
                
                error_log("Attempting to send 'already borrowed' SMS to: " . $this->phoneNumber);
                $smsStatus = sendSMS($this->phoneNumber, $smsMessage);
                error_log("SMS Status for 'already borrowed': " . $smsStatus);
                
                echo "END You have already borrowed this book. You will receive an SMS with details.";
                return;
            }

            // Check available copies
            if ($book['available_copies'] <= 0) {
                // Send SMS for no available copies
                $smsMessage = "MOBI Library - Book Not Available\n\n";
                $smsMessage .= "Dear $userName,\n\n";
                $smsMessage .= "The book you tried to borrow is currently not available:\n";
                $smsMessage .= "Title: {$book['title']}\n\n";
                $smsMessage .= "Please try again later or choose another book.\n\n";
                $smsMessage .= "Thank you for using MOBI Library!";
                
                error_log("Attempting to send 'not available' SMS to: " . $this->phoneNumber);
                $smsStatus = sendSMS($this->phoneNumber, $smsMessage);
                error_log("SMS Status for 'not available': " . $smsStatus);
                
                echo "END No available copies for this book. You will receive an SMS with details.";
                return;
            }

            try {
                // Start transaction
                $this->conn->beginTransaction();

                // Decrement available copies
                $stmt = $this->conn->prepare("UPDATE books SET available_copies = available_copies - 1 WHERE id = ?");
                $stmt->execute([$book['id']]);
                
                // Record the borrowing
                $stmt = $this->conn->prepare("INSERT INTO borrowed_books (user_id, book_id, borrowed_at) VALUES (?, ?, NOW())");
                $stmt->execute([$userId, $book['id']]);
                
                // Commit transaction
                $this->conn->commit();
                
                // Prepare and send confirmation SMS for successful borrowing
                $smsMessage = "MOBI Library - Book Borrowed Successfully\n\n";
                $smsMessage .= "Dear $userName,\n\n";
                $smsMessage .= "You have successfully borrowed the following book:\n";
                $smsMessage .= "Title: {$book['title']}\n";
                $smsMessage .= "Borrowed Date: " . date('Y-m-d') . "\n";
                $smsMessage .= "Return Date: " . date('Y-m-d', strtotime('+14 days')) . "\n\n";
                $smsMessage .= "Please return the book within 14 days.\n\n";
                $smsMessage .= "Thank you for using MOBI Library!";
                
                error_log("Attempting to send 'successful borrow' SMS to: " . $this->phoneNumber);
                $smsStatus = sendSMS($this->phoneNumber, $smsMessage);
                error_log("SMS Status for 'successful borrow': " . $smsStatus);
                
                if ($smsStatus === 'success') {
                    echo "END Book borrowed successfully. You will receive a confirmation SMS shortly.";
                } else {
                    echo "END Book borrowed successfully. However, we couldn't send the confirmation SMS. Please try again later.";
                }
            } catch (PDOException $e) {
                // Rollback transaction on error
                $this->conn->rollBack();
                error_log("Database error during book borrowing: " . $e->getMessage());
                echo "END Failed to borrow book. Please try again later.";
            }
        } catch (PDOException $e) {
            error_log("Error in borrowBook: " . $e->getMessage());
            echo "END Failed. Please try again later.";
        }
    }

    public function middleware($text) {
        return $this->goBack($this->goMainMenu($text));
    }

    public function goBack($text) {
        $explodeText = explode("*", $text);
        while(array_search(Util::$GO_BACK, $explodeText) !== false) {
            $firstIndex = array_search(Util::$GO_BACK, $explodeText);
            array_splice($explodeText, $firstIndex-1, 2);
        }
        return join("*", $explodeText);
    }
    
    public function goMainMenu($text) {
        $explodeText = explode("*", $text);
        while(array_search(Util::$GO_MAIN_MENU, $explodeText) !== false) {
            $firstIndex = array_search(Util::$GO_MAIN_MENU, $explodeText);
            $explodeText = array_slice($explodeText, $firstIndex+1);
        }
        return join("*", $explodeText);
    }
}