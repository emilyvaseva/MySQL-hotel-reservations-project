DROP TRIGGER if exists after_payments_update;
delimiter |
CREATE TRIGGER after_payments_update AFTER UPDATE ON payments
FOR EACH ROW 
BEGIN
INSERT INTO payments_log(operation,
old_amount,
new_amount,
old_date,
new_date,
old_year,
new_year,
old_booking_id,
new_booking_id,
old_guest_id,
new_guest_id,
old_type_id,
new_type_id,
dateOfLog)
VALUES ('UPDATE',
OLD.amount,
CASE NEW.amount WHEN OLD.amount THEN NULL ELSE NEW.amount END,
OLD.date,
CASE NEW.date WHEN OLD.date THEN NULL ELSE NEW.date END,
OLD.year,
CASE NEW.year WHEN OLD.year THEN NULL ELSE NEW.year END,
OLD.booking_id,
CASE NEW.booking_id WHEN OLD.booking_id THEN NULL ELSE NEW.booking_id END,
OLD.guest_id,
CASE NEW.guest_id WHEN OLD.guest_id THEN NULL ELSE NEW.guest_id END,
OLD.type_id,
CASE NEW.type_id WHEN OLD.type_id THEN NULL ELSE NEW.type_id END,
NOW());
END;
|
Delimiter ;



UPDATE `hotel`.`payments` SET `date`='2023-02-03' WHERE `id`='4';

SELECT * FROM payments;