# Airport API

## Data base

### User
**id** - int  
**name** - string  
**surname** - string  
**login** - string, *unique*  
**password** - string
**passport** - string  

### Company
**id** - int  
**name** - string  
**description** - string

### Review
**id** - int  
**company_id** - int (FK for Company)  
**text** - string  
**rating** - int  
**user_id** - int (FK for User)

### Plane
**id** - int  
**name** - string  
**company_id** - int (FK for Company)  
**capacity** - int  

### Place
**id** - int  
**planeId** - int (FK for Plane)  
**name** - string  

### Flight
**id** - int  
**nameFrom** - string  
**nameTo** - string  
**dateFrom** - string  
**dateTo** - string  
**planeId** - int (FK for Plane)  

### Ticket  
**id** - int  
**userId** - int  
**placeId** - int  
**flightId** - int  

### Auth service

**GET** localhost:8080/users?**login**=bt@gmail.com&**password**=1301  
Returns user with following username if it exists and password matches. Empty if error occured

**POST** localhost:8080/users?**name**=Bethany&**surname**=Tusen&**login**=bt@gmail.com&**password**=1301&**passport**=AE12  
Creates user with this data. id must be autoincremented. email must be *unique*. Returns created user if success, empty if error occured

**PUT** localhost:8080/users?**id**=1&**name**=Bethany&**surname**=Tusen&**login**=bt@gmail.com&**password**=1301&&**passport**=AE12  
Updated user with this data. email must be *unique*. Returns updated user if success, empty if error occured

### Flight service

**GET** localhost:8080/companies  
Returns list of companies

**POST** localhost:8080/companies?**name**=BritishAirlines&**description**=SomeDescription  
Creates a company. Return true if everything was OK. false if error occured

**PUT** localhost:8080/companies?**id**=1&**name**=BritishAirlines&**description**=SomeDescription  
Updates a company. Return true if everything was OK. false if error occured

**DELETE** localhost:8080/companies?**id**=1  
Deletes a company. Return true if everything was OK. false if error occured

**POST** localhost:8080/planes?**name**=Boing&**company_id**=1&**capacity**=50  
Creates a plane. Return true if everything was OK. false if error occured

**PUT** localhost:8080/planes?**id**=1&**name**=Boing&**capacity**=50  
Updates a plane. Return true if everything was OK. false if error occured

**DELETE** localhost:8080/planes?**id**=1  
Deletes a plane. Return true if everything was OK. false if error occured

**GET** localhost:8080/flights  
Returns a list of all flights   

**POST** localhost:8080/flights?**date_from**=13/01/20&**date_to**=14/01/20&**name_from**=Borispol&**name_to**=GHE&**plane_id**=3  
Creates a flight

### Review client

**POST** locahlost:8080/reviews?**company_id**=1&**text**=Bad service!&**rating**=2.0  
Creates a review  

**DELETE**  locahlost:8080/reviews?**id**=1  
Deletes a review with following id
