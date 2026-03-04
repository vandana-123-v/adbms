mysql> CREATE DATABASE testdb;
Query OK, 1 row affected (0.01 sec)

mysql> USE testdb;
Database changed
mysql> show database;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'database' at line 1
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| college            |
| employee1          |
| greatest           |
| information_schema |
| mysql              |
| office             |
| performance_schema |
| sys                |
| testdb             |
+--------------------+
9 rows in set (0.01 sec)

mysql> DELIMITER //
mysql> CREATE OR REPLACE PROCEDURE find_greatest (
    ->     num1 IN NUMBER,
    ->     num2 IN NUMBER,
    ->     num3 IN NUMBER
    -> )
    -> IS
    ->     greatest_num NUMBER;
    -> BEGIN
    ->     IF num1 >= num2 AND num1 >= num3 THEN
    ->         greatest_num := num1;
    ->     ELSIF num2 >= num1 AND num2 >= num3 THEN
    ->         greatest_num := num2;
    ->     ELSE
    ->         greatest_num := num3;
    ->     END IF;
    -> 
    ->     DBMS_OUTPUT.PUT_LINE('Greatest number is: ' || greatest_num);
    -> END;
    -> /
    -> delimiter;
    -> CALL find_greatest;
    -> BEGIN
    ->     find_greatest(10, 25, 15);
    -> END;
    -> /
    -> ^C
mysql> 
mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE FindGreatest(
    ->     IN num1 INT,
    ->     IN num2 INT,
    ->     IN num3 INT,
    ->     OUT greatest INT
    -> )
    -> BEGIN
    ->     IF num1 >= num2 AND num1 >= num3 THEN
    ->         SET greatest = num1;
    ->     ELSEIF num2 >= num1 AND num2 >= num3 THEN
    ->         SET greatest = num2;
    ->     ELSE
    ->         SET greatest = num3;
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL FindGreatest(10, 25, 15, @result);
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT @result;
+---------+
| @result |
+---------+
|      25 |
+---------+
1 row in set (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE FindFactorial(
    ->     IN num INT
    -> )
    -> BEGIN
    ->     DECLARE i INT DEFAULT 1;
    ->     DECLARE fact BIGINT DEFAULT 1;
    -> 
    ->     WHILE i <= num DO
    ->         SET fact = fact * i;
    ->         SET i = i + 1;
    ->     END WHILE;
    -> 
    ->     SELECT fact AS Factorial;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL FindFactorial(5);
+-----------+
| Factorial |
+-----------+
|       120 |
+-----------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE FindGrade(
    ->     IN mark INT
    -> )
    -> BEGIN
    ->     DECLARE grade VARCHAR(2);
    -> 
    ->     IF mark >= 90 THEN
    ->         SET grade = 'A+';
    ->     ELSEIF mark >= 80 THEN
    ->         SET grade = 'A';
    ->     ELSEIF mark >= 70 THEN
    ->         SET grade = 'B';
    ->     ELSEIF mark >= 60 THEN
    ->         SET grade = 'C';
    ->     ELSEIF mark >= 50 THEN
    ->         SET grade = 'D';
    ->     ELSE
    ->         SET grade = 'F';
    ->     END IF;
    -> 
    ->     SELECT grade AS Grade;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL FindGrade(85);
+-------+
| Grade |
+-------+
| A     |
+-------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE ReverseNumber(
    ->     IN num INT
    -> )
    -> BEGIN
    ->     DECLARE reversed INT DEFAULT 0;
    ->     DECLARE remainder INT;
    -> 
    ->     WHILE num > 0 DO
    ->         SET remainder = num % 10;
    ->         SET reversed = (reversed * 10) + remainder;
    ->         SET num = num DIV 10;
    ->     END WHILE;
    -> 
    ->     SELECT reversed AS Reversed_Number;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL ReverseNumber(1234);
+-----------------+
| Reversed_Number |
+-----------------+
|            4321 |
+-----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE SumSeries(
    ->     IN n INT
    -> )
    -> BEGIN
    ->     DECLARE i INT DEFAULT 1;
    ->     DECLARE total INT DEFAULT 0;
    -> 
    ->     WHILE i <= n DO
    ->         SET total = total + i;
    ->         SET i = i + 1;
    ->     END WHILE;
    -> 
    ->     SELECT total AS Sum_of_Series;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL SumSeries(5);
+---------------+
| Sum_of_Series |
+---------------+
|            15 |
+---------------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE accounts (
    ->     account_id INT PRIMARY KEY,
    ->     balance DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO accounts VALUES (101, 5000);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO accounts VALUES (102, 15000);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO accounts VALUES (100, 10000);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO accounts VALUES (103, 1000);
Query OK, 1 row affected (0.03 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE WithdrawAmount(
    ->     IN acc_id INT,
    ->     IN withdraw_amt DECIMAL(10,2)
    -> )
    -> BEGIN
    ->     DECLARE current_balance DECIMAL(10,2);
    -> 
    ->     -- Check if account exists
    ->     SELECT balance INTO current_balance
    ->     FROM accounts
    ->     WHERE account_id = acc_id;
    -> 
    ->     IF current_balance IS NULL THEN
    ->         SELECT 'Account does not exist' AS Message;
    -> 
    ->     ELSEIF (current_balance - withdraw_amt) < 1000 THEN
    ->         SELECT 'Insufficient balance. Minimum balance of 1000 must be maintained' AS Message;
    -> 
    ->     ELSE
    ->         UPDATE accounts
    ->         SET balance = balance - withdraw_amt
    ->         WHERE account_id = acc_id;
    -> 
    ->         SELECT 'Withdrawal successful' AS Message,
    ->                (current_balance - withdraw_amt) AS New_Balance;
    ->     END IF;
    -> 
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL WithdrawAmount(101, 2000);
+-----------------------+-------------+
| Message               | New_Balance |
+-----------------------+-------------+
| Withdrawal successful |     3000.00 |
+-----------------------+-------------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE FUNCTION SumOfDigits(num INT)
    -> RETURNS INT
    -> DETERMINISTIC
    -> BEGIN
    ->     DECLARE sum INT DEFAULT 0;
    ->     DECLARE remainder INT;
    -> 
    ->     WHILE num > 0 DO
    ->         SET remainder = num % 10;
    ->         SET sum = sum + remainder;
    ->         SET num = num DIV 10;
    ->     END WHILE;
    -> 
    ->     RETURN sum;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> SELECT SumOfDigits(1234) AS Result;
+--------+
| Result |
+--------+
|     10 |
+--------+
1 row in set (0.00 sec)

mysql> CREATE TABLE employee (
    ->     emp_id INT PRIMARY KEY,
    ->     emp_name VARCHAR(50),
    ->     salary DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE FUNCTION GetSalary(e_id INT)
    -> RETURNS DECIMAL(10,2)
    -> DETERMINISTIC
    -> BEGIN
    ->     DECLARE emp_salary DECIMAL(10,2);
    -> 
    ->     SELECT salary INTO emp_salary
    ->     FROM employee
    ->     WHERE emp_id = e_id;
    -> 
    ->     RETURN emp_salary;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> SELECT GetSalary(101) AS Salary;
+--------+
| Salary |
+--------+
|   NULL |
+--------+
1 row in set (0.00 sec)

