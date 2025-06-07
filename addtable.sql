-- Create a table named 'students'
CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER,
    grade TEXT
);

-- Insert some data
INSERT INTO students (id, name, age, grade) VALUES
(1, 'Alice', 14, 'A'),
(2, 'Bob', 15, 'B'),
(3, 'Charlie', 13, 'A');

-- Select all data
SELECT * FROM students;

-- Update data
UPDATE students SET grade = 'A+' WHERE name = 'Bob';

-- Delete a student by id
DELETE FROM students WHERE id = 3;
