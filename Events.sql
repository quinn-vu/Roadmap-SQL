-- EVENTS
-- Event: Automatically executes according to a scheduled time or interval (a second, daily, weekly, monthly, etc.).
-- Creating an Event does not immediately delete the records. 
-- However, when its scheduled execution happens, the changes are applied to the real table.
-- Once a DELETE statement has successfully committed, the deleted records cannot simply be recovered using another SELECT statement.
-- You would generally need: A database backup, An audit or archive table. Appropriate database recovery mechanisms.
-- This is why you should be careful when creating automated DELETE Events.

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 1 day
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age>=60;
END $$
DELIMITER ; 

SHOW VARIABLES LIKE 'event%';
