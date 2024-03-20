SELECT bookings.id,
guests.name,
guests.phone,
guests.address
FROM bookings JOIN guests
on bookings.guest_id = guests.id;