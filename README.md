# PG and Hostel Management System (API-Based)

This is a PG and Hostel Management System built using Ruby on Rails (API Mode). It allows residents to book rooms and admins to manage hostels and rooms.

## Setup Instructions

### 1. Clone the repository
```bash
https://github.com/sandeepk275/hostel_management_system.git
cd pg-hostel-management-api

bundle install
rails db:create
rails db:migrate
rails s


# API Endpoints
# User Endpoints
	# POST /users/signup: Register a new user.
	# POST /users/login: Login to get a JWT token.
# Hostel Management API (Admin Only)
	# GET /hostels: List all hostels.
	# POST /hostels: Add a new hostel.
	# PUT /hostels/:id: Update hostel details.
	# DELETE /hostels/:id: Delete a hostel.
# Room Management API (Admin Only)
	# GET /hostels/:hostel_id/rooms: List rooms in a hostel.
	# POST /hostels/:hostel_id/rooms: Add a new room.
	# PUT /rooms/:id: Update room details.
	# DELETE /rooms/:id: Delete a room.
	# GET /rooms/search :Search rooms with query parameters like capacity, price, and availability
# Booking Management API
	# POST /rooms/:room_id/bookings: Create a booking.
	# GET /bookings: List bookings (Admins see all, residents see their own).
	# PUT /bookings/:id/approve: Admin approves a booking.
	# PUT /bookings/:id/reject: Admin rejects a booking.
	# DELETE /bookings/:id: Cancel a booking (Resident/Admin).
