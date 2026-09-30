-- ============================================================
-- library.sql
-- A small, complete SQL program: a library management database.
-- Works on MySQL. Run with:  mysql -u root -p < library.sql
-- or inside the mysql prompt:  source /path/to/library.sql;
-- ============================================================

-- 1. Create and select the database
DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;

-- 2. Create tables
CREATE TABLE authors (
    author_id   INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    country     VARCHAR(50)
);

CREATE TABLE books (
    book_id     INT PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(200) NOT NULL,
    author_id   INT,
    genre       VARCHAR(50),
    copies      INT DEFAULT 1,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE members (
    member_id   INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    join_date   DATE
);

CREATE TABLE loans (
    loan_id     INT PRIMARY KEY AUTO_INCREMENT,
    book_id     INT,
    member_id   INT,
    loan_date   DATE,
    return_date DATE,
    FOREIGN KEY (book_id)   REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 3. Insert sample data
INSERT INTO authors (name, country) VALUES
    ('George Orwell',      'UK'),
    ('Chetan Bhagat',      'India'),
    ('J.K. Rowling',       'UK');

INSERT INTO books (title, author_id, genre, copies) VALUES
    ('1984',                       1, 'Dystopian', 3),
    ('Animal Farm',                1, 'Satire',    2),
    ('Five Point Someone',         2, 'Fiction',   4),
    ('Harry Potter and the Stone', 3, 'Fantasy',   5);

INSERT INTO members (name, join_date) VALUES
    ('Vivek',  '2026-01-15'),
    ('Aarav',  '2026-02-20'),
    ('Priya',  '2026-03-10');

INSERT INTO loans (book_id, member_id, loan_date, return_date) VALUES
    (1, 1, '2026-09-01', '2026-09-10'),
    (3, 1, '2026-09-05', NULL),          -- not yet returned
    (4, 2, '2026-09-12', NULL),          -- not yet returned
    (2, 3, '2026-09-15', '2026-09-20');

-- ============================================================
-- 4. Example queries (this is the "program" part)
-- ============================================================

-- (a) List every book with its author
SELECT b.title, a.name AS author, b.genre, b.copies
FROM books b
JOIN authors a ON b.author_id = a.author_id
ORDER BY b.title;

-- (b) Books currently on loan (not yet returned)
SELECT m.name AS member, b.title, l.loan_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books   b ON l.book_id   = b.book_id
WHERE l.return_date IS NULL;

-- (c) How many books each author has in the library
SELECT a.name AS author, COUNT(b.book_id) AS total_books
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
GROUP BY a.name
ORDER BY total_books DESC;

-- (d) Members who have borrowed at least one book
SELECT DISTINCT m.name
FROM members m
JOIN loans l ON m.member_id = l.member_id;
