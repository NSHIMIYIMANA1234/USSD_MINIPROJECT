# USSD Library System

## Project Overview
This project is a USSD-based library management system designed to provide easy access to library services via mobile phones.

## Group Members
- NSHIMIYIMANA JMV [Group Member 15] - 22RP01712
- UWASE Claudine [Group Member 15] - 22RP02496

## USSD Flow Diagram
```
Start
 │
 │
 ├── Is phone number registered?
 │         │
 │         ├── Yes
 │         │     │
 │         │     ▼
 │         │   Welcome Back Menu
 │         │   1. View my borrowed books
 │         │   2. Search book
 │         │   3. Borrow book
 │         │   4. Exit
 │         │
 │         │   ├── 1: Show list of borrowed books (or "No book borrowed")
 │         │   ├── 2: Enter book category → Show results
 │         │   └── 3: Enter book name → If available, borrow; else, show not found
 │         │
 │         └── No
 │               │
 │               ▼
 │           Welcome to MOB Library
 │           1. Register
 │               │
 │               ▼
 │           Enter full name
 │               │
 │               ▼
 │           Enter phone number
 │               │
 │               ├── If phone number already registered: "Enter another phone number"
 │               └── If not registered:
 │                     │
 │                     ▼
 │                 Enter password
 │                     │
 │                     ▼
 │                 Re-enter password
 │                     │
 │                     ▼
 │                 "You have successfully registered with [phone number]" with message
 │
End

## Requirements
- PHP 7.4 or higher
- MySQL/MariaDB
- XAMPP or similar local server
- Africa's Talking API Account
- Composer

## Installation

1. Clone the repository:
```bash
git clone https://github.com/NSHIMIYIMANA1234/USSD_MINIPROJECT.git
cd USSD_MINIPROJECT
```

2. Install dependencies:
```bash
composer install
```

3. Create a database and import the schema:
```bash
mysql -u your_username -p your_database < ussd_library_system.sql
```

4. Configure your environment:
- Copy `.env.example` to `.env`
- Update the database credentials
- Add your Africa's Talking API credentials

5. Configure your USSD service:
- Set up your Africa's Talking USSD service
- Configure the callback URL to point to your server
- Set up your sender ID for SMS

## Configuration

1. Database Configuration:
- Update database credentials in `db.php`
- Ensure proper database permissions

2. Africa's Talking Configuration:
- Add your API key in `sms.php`
- Configure your sender ID
- Set up proper USSD callback URL

## Usage

1. Dial your USSD code: *384*29993#
2. Follow the menu prompts:
   - Register as a new user
   - Search for books
   - Borrow books
   - View borrowed books

## SMS Notifications

The system sends SMS notifications for:
- Successful registration
- Book borrowing confirmation
- Book return reminders
- Search results
- Error notifications

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, please contact [your-email@example.com]


