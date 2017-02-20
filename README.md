# Ripped

An Exercism-like application for the Turing School of Software and Design.

## Installation

 - clone down this repo `git clone https://github.com/turingschool-projects/ripped`
 - run `bundle install`
 - we're using a custom version of a gem for staging, so also run: `bundle update`
 - login is - at the moment - handled through [Census](https://github.com/turingschool-projects/census). as this is not yet in production you will probably need to stub out your users - we'll update as soon as this changes. You'll need Census access to run the app.

## API Endpoints

###To receive a user by ID:
```
GET 'https://staging-ripped.herokuapp.com/api/v1/users/:id'
```
Path parameters:
* id: The unique id for the user

Response format:
```
{
  "id": 2,
  "census_id": 55,
}
```
###To receive all exercises:
```
GET 'https://staging-ripped.herokuapp.com/api/v1/exercises'
```
###To receive an exercise by ID:
```
GET 'https://staging-ripped.herokuapp.com/api/v1/exercises/:id'
```
Path parameters:
* id: The unique id for the exercise

###To receive a solution for an exercise by ID:
```
GET 'https://staging-ripped.herokuapp.com/api/v1/exercises/:exercise_id/solutions/:id'
```
Path parameters:
* exercise_id: The unique id for the exercise
* id: The unique id for a solution belonging to the exercise

###To receive a feedback item for a solution by ID:
```
GET 'https://staging-ripped.herokuapp.com/api/v1/solutions/:solution_id/feedbacks/:id'
```
Path parameters:
* solution_id: The unique id for the solution
* id: The unique id for a feedback item belonging to the solution

###To update a feedback item's status:
```
PATCH 'https://staging-ripped.herokuapp.com/api/v1/solutions/:solution_id/feedbacks/:id'
```
Path parameters:
* solution_id: The unique id for the solution
* id: The unique id for a feedback item belonging to the solution

Request body parameters:
* feedback
* status: read or unread
