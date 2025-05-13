# MOBI Library USSD System

## Group Members
- [NSHIMIYIMANA JMV] [Group Member 15] - [22RP01712]
-UWASE Claudine [Group Member 15] - [22RP02496]

A USSD-based library management system that allows users to register, search for books, and borrow books through their mobile phones.

## Features

- User Registration and Authentication
- Book Search by Category
- Book Borrowing System
- SMS Notifications
- Transaction Logging
- Book Availability Tracking

## Requirements

- PHP 7.4 or higher
- MySQL/MariaDB
- XAMPP or similar local server
- Africa's Talking API Account
- Composer

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ussd_libryarysystem.git
cd ussd_libryarysystem
```

2. Install dependencies:
```bash
composer install
```

3. Create a database and import the schema:
```bash
mysql -u your_username -p your_database < database.sql
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