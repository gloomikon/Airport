# Airport API

## Data base

### User
**id** - int  
**name** - string  
**surname** - string  
**email** - string, *unique*  
**password** - string

### Company
**id** - int  
**name** - string  
**description** - string

### Review
**id** - int  
**company_id** - int (FK for Company)  
**text** - string  
**rating** - double  
**user_id** - int (FK for User)

### Plane
**id** - int  
**name** - string  
**company_id** - int (FK for Company)  
**capacity** - int  

### Place
**id** - int  
**plane_id** - int (FK for Plane)  
**name** - string  
**user_id** - int (FK for User. Can be empty)  

### Flight
**id** - int  
**name_from** - string  
**name_to** - string  
**date_from** - date  
**date_to** - date  
**plane_id** - int (FK for Plane)  

### Auth client

**GET** localhost:8080/users?**id**=1  
Returns user with following id

**GET** localhost:8080/users?**email**=bt@gmail.com&**password**=1301  
Returns user with following username if it exists and password matches. Empty if error occured

**POST** localhost:8080/users?**name**=Bethany&**surname**=Tusen&**email**=bt@gmail.com&**password**=1301  
Creates user with this data. id must be autoincremented. email must be *unique*. Returns created user if success, empty if error occured

**PUT** localhost:8080/users?**id**=1?**name**=Bethany&**surname**=Tusen&**email**=bt@gmail.com&**password**=1301  
Updated user with this data. email must be *unique*. Returns updated user if success, empty if error occured

### Flight client

**GET** localhost:8080/companies?**id**=1  
Returns company with following id with field *rewies* contaning array of its reviews

**POST** localhost:8080/companies?**name**=BritishAirlines&**description**=SomeDescription  
Creates a company. Return true if everything was OK. false if error occured  

**POST** localhost:8080/planes?**name**=Boing&**company_id**=1&**capacity**=50  
Creates a plane. Return true if everything was OK. false if error occured  

**POST** localhost:8080/places?**plane_id**=1&**name**=A13  
Creates a place. Return true if everything was OK. false if error occured

**GET** localhost:8080/flights  
Returns a list of all flights. Response should look like array of these JSONs:  
{  
  "id": 1,  
   "name_from": ...,  
   "name_to": ...,  
   ...,  
   "plane": {  
     "id": 1,  
     "name": ...  
   },  
   "company": {  
     "id": 1,  
     "name": ...  
   },  
   "place": {  
     "id": 1,  
     "name": ...,  
     "user_id": ...  
   }  
 }  
 
**PUT** localhost:8080/places?**id**=1&**user_id**=1  
It should update place with following id, setting its user_id to given one  

**PUT** localhost:8080/places?**id**=1  
It should update place with following id, deleting its user id

**GET** localhost:8080/flights?**user_id**=1  
Returns a list of all flights of given user. Response should look like array of these JSONs:  
{  
  "id": 1,  
   "name_from": ...,  
   "name_to": ...,  
   ...,  
   "plane": {  
     "id": 1,  
     "name": ...  
   },  
   "company": {  
     "id": 1,  
     "name": ...  
   },  
   "place": {  
     "id": 1,  
     "name": ...,  
     "user_id": ...  
   }  
 }  

### Review client

**POST** locahlost:8080/reviews?**company_id**=1&**text**=Bad service!&**rating**=2.0  
Creates a review  

**DELETE**  locahlost:8080/reviews?**id**=1  
Deleted a review with following id
