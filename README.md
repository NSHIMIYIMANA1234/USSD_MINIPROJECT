# USSD Library System

## Project Overview
This project is a USSD-based library management system designed to provide easy access to library services via mobile phones.

Group Members
-[NSHIMIYIMANA JMV] [Group Member 15] - [22RP01712]
-UWASE Claudine [Group Member 15] - [22RP02496]


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



