SELECT payments.id,  SUM(payments.amount) AS SumOfAllPayments, 
payments.year, guests.name AS GuestName
FROM payments JOIN guests
ON guests.id = payments.guest_id
GROUP BY payments.id
ORDER BY guests.name
LIMIT 5;

