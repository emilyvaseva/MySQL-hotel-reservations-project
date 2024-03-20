SELECT booking_id as BookingId, SUM(amount) as SumOfAllPaymentsForBooking
FROM payments
GROUP BY booking_id