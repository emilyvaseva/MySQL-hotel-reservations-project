SELECT rooms.number,
rooms.sight,
bookings.id
FROM bookings JOIN room_booking
ON bookings.id = room_booking.booking_id
RIGHT OUTER JOIN rooms ON room_booking.room_id = rooms.id
