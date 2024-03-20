SELECT payment_types.type, guests.name, guests.phone, guests.address
FROM guests JOIN payment_types
ON guests.id IN (
				SELECT guest_id
                FROM payments
                WHERE payments.type_id = payment_types.id
                );
                
                