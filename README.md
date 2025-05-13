# USSD Library System

## Developers
- NSHIMIYIMANA JMV [22RP01712]
- UWASE Claudine [22RP02496]

## Project Setup Instructions

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
``` 