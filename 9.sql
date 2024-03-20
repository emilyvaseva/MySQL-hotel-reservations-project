DROP PROCEDURE IF EXISTS get_bookings_by_date_range;
DELIMITER //

CREATE PROCEDURE get_bookings_by_date_range (
  IN start_date DATE,
  IN end_date DATE
)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE booking_id INT;
  DECLARE checkin_date DATE;
  DECLARE checkout_date DATE;
  DECLARE booking_price DECIMAL(10, 2);

  DECLARE bookings_cur CURSOR FOR
    SELECT id, checkin, checkout, price
    FROM bookings
    WHERE checkin >= start_date AND checkout <= end_date;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN bookings_cur;

  bookings_loop: LOOP
    
    FETCH bookings_cur INTO booking_id, checkin_date, checkout_date, booking_price;
    
    IF done THEN
      LEAVE bookings_loop;
    END IF;
    
    SELECT CONCAT('Reservation #', booking_id, ' from ', checkin_date, ' to ', checkout_date, ' for $', booking_price) AS booking_info;
    
  END LOOP;

  CLOSE bookings_cur;

END //

DELIMITER ;

CALL get_bookings_by_date_range('2023-01-01', '2023-01-31');