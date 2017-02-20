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
GET '/api/v1/users/:id'
```
**Path parameters:**
* id: The unique id for the user

**Success Response:**

**Code:** 200 </br>
**Content:**
```
{
  "id": 2,
  "census_id": 55,
}
```
###To receive all exercises:
```
GET '/api/v1/exercises'
```

**Success Response:**

**Code:** 200 </br>
**Content:**
```
[
  {
    "id": 1,
    "name": "Hello World",
    "content": "class HelloWorldTest < Minitest::Test\n  def test_no_name\n    assert_equal 'Hello, World!', HelloWorld.hello\n  end\n\n  def test_sample_name\n    assert_equal 'Hello, Alice!', HelloWorld.hello('Alice')\n  end\n\n  def test_other_sample_name\n    assert_equal 'Hello, Bob!', HelloWorld.hello('Bob')\n  end\nend",
    "description": "First exercise!",
    "solutions": [
      {
        "id": 1,
        "content": "solution",
        "exercise_id": 1,
      },
      {
        "id": 2,
        "content": "puts \"Hello World\"",
        "exercise_id": 1,
      }
    ]
  }
]
```
###To receive an exercise by ID:
```
GET '/api/v1/exercises/:id'
```
Path parameters:
* id: The unique id for the exercise

**Success Response:**

**Code:** 200 </br>
**Content:**
```
{
  "id": 1,
  "name": "Hello World",
  "content": "class HelloWorldTest < Minitest::Test\n  def test_no_name\n    assert_equal 'Hello, World!', HelloWorld.hello\n  end\n\n  def test_sample_name\n    assert_equal 'Hello, Alice!', HelloWorld.hello('Alice')\n  end\n\n  def test_other_sample_name\n    assert_equal 'Hello, Bob!', HelloWorld.hello('Bob')\n  end\nend",
  "description": "First exercise!",
  "solutions": [
    {
      "id": 1,
      "content": "solution",
      "exercise_id": 1,
    },
    {
      "id": 2,
      "content": "puts \"Hello World\"",
      "exercise_id": 1,
    }
  ]
}
```

###To receive a solution for an exercise by ID:
```
GET '/api/v1/exercises/:exercise_id/solutions/:id'
```
Path parameters:
* exercise_id: The unique id for the exercise
* id: The unique id for a solution belonging to the exercise

**Success Response:**

**Code:** 200 </br>
**Content:**
```
{
  "id": 1,
  "content": "puts 'Hello World'",
  "exercise_id": 1,
  "feedbacks": [
    {
      "id": 1,
      "user_id": 1,
      "solution_id": 1,
      "comment": "Comment",
      "created_at": "2017-02-08T23:57:47.836Z",
      "updated_at": "2017-02-08T23:57:47.836Z",
      "status": "unread"
    },
    {
      "id": 3,
      "user_id": 2,
      "solution_id": 1,
      "comment": "Another comment",
      "created_at": "2017-02-08T23:58:40.247Z",
      "updated_at": "2017-02-08T23:58:40.247Z",
      "status": "unread"
    }
  ]
}
```

###To receive a feedback item for a solution by ID:
```
GET '/api/v1/solutions/:solution_id/feedbacks/:id'
```
Path parameters:
* solution_id: The unique id for the solution
* id: The unique id for a feedback item belonging to the solution

**Success Response:**

**Code:** 200 </br>
**Content:**
```
{
  "id": 1,
  "user_id": 1,
  "solution_id": 1,
  "comment": "Comment",
  "created_at": "2017-02-08T23:57:47.836Z",
  "updated_at": "2017-02-08T23:57:47.836Z",
  "status": "unread"
}
```

###To update a feedback item's status:
```
PATCH '/api/v1/solutions/:solution_id/feedbacks/:id'
```
Path parameters:
* solution_id: The unique id for the solution
* id: The unique id for a feedback item belonging to the solution

Request body parameters:
* feedback
* status: read or unread

**Success Response:**

**Code:** 200 </br>
**Content:**
```
{
  "id": 1,
  "user_id": 1,
  "solution_id": 1,
  "comment": "Comment",
  "created_at": "2017-02-08T23:57:47.836Z",
  "updated_at": "2017-02-08T23:57:47.836Z",
  "status": "read"
}
```
