# Ripped

An Exercism-like application for the Turing School of Software and Design.

## Installation

 - clone down this repo `git clone https://github.com/turingschool-projects/ripped`
 - run `bundle install`
 - we're using a custom version of a gem for staging, so also run: `bundle update`
 - login is - at the moment - handled through [Census](https://github.com/turingschool-projects/census). as this is not yet in production you will probably need to stub out your users - we'll update as soon as this changes. You'll need Census access to run the app.

## API Endpoints:
* [GET user](#to-receive-a-user-by-id)
* [GET exercises](#to-receive-all-exercises)
* [GET exercise](#to-receive-an-exercise-by-id)
* [GET solution](#to-receive-a-solution-for-an-exercise-by-id)
* [GET feedback](#to-receive-a-feedback-item-for-a-solution-by-id)
* [PATCH feedback](#to-update-a-feedback-items-status)

---

###To receive a user by ID:
```
GET '/api/v1/users/:id'
```
**Path parameters:**
* id: The unique id for the user

**Success Response:**

Code: 200 </br>
Content:
```
{
  "id": 2,
  "census_id": 55,
}
```

**Error Response:**

Code: 400 </br>

---
###To receive all exercises:
```
GET '/api/v1/exercises'
```

**Success Response:**

Code: 200 </br>
Content:
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
**Error Response:**

Code: 400 </br>

---
###To receive an exercise by ID:
```
GET '/api/v1/exercises/:id'
```
**Path parameters:**
* id: The unique id for the exercise

**Success Response:**

Code: 200 </br>
Content:
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
**Error Response:**

Code: 400 </br>

---
###To retrieve all of a users solutions and only the unread feedback for those solutions

Note: this provides content for the student dropdown component. Though it returns solutions (and their feedback) the code for the action "lives" in the feedbacks controller as its purpose is to return feedback.

```
GET '/api/v1/users/:user_id/solutions'
```
**Path parameters:**
* user_id: The unique id for a user

**Success Response:**

Code: 200 </br>
Content:
```
{
  {
      "id": 1,
      "content": "Here's where the solution would go",
      "exercise_id": 2,
      "feedbacks": [
        {
          "id": 1,
          "user_id": 2,
          "solution_id": 1,
          "comment": "And it's a great solution",
          "created_at": "2017-02-22T00:04:17.058Z",
          "updated_at": "2017-02-23T16:28:33.947Z",
          "status": "unread"
        },
        {
          "id": 3,
          "user_id": 2,
          "solution_id": 1,
          "comment": "The code is so beautiful I could cry",
          "created_at": "2017-02-22T20:42:23.947Z",
          "updated_at": "2017-02-23T16:28:33.958Z",
          "status": "unread"
        }
      ]}
```
**Error Response:**

Code: 400 </br>

###To retrieve all solutions with no feedback

Note: this provides content for the instructor dropdown component.

```
GET '/api/v1/solutions'
```
**Success Response:**

Code: 200 </br>
Content:
```
[
  {
    "id": 3,
    "content": "Here is a test solution",
    "exercise_id": 2,
    "feedbacks": [],
    "exercise": exercise text and data will be here
  },
  {
    "id": 4,
    "content": "and here is another test solution",
    "exercise_id": 3,
    "feedbacks": [],
    "exercise": exercise text and data will be here
    }
  }
]
```
**Error Response:**

Code: 400 </br>


---
###To receive a solution for an exercise by ID:
```
GET '/api/v1/exercises/:exercise_id/solutions/:id'
```
**Path parameters:**
* exercise_id: The unique id for the exercise
* id: The unique id for a solution belonging to the exercise

**Success Response:**

Code: 200 </br>
Content:
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
**Error Response:**

Code: 400 </br>

---
###To receive a feedback item for a solution by ID:
```
GET '/api/v1/solutions/:solution_id/feedbacks/:id'
```
**Path parameters:**
* solution_id: The unique id for the solution
* id: The unique id for a feedback item belonging to the solution

**Success Response:**

Code: 200 </br>
Content:
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
**Error Response:**

Code: 400 </br>

---
###To update a feedback item's status:
```
PATCH '/api/v1/solutions/:solution_id/feedbacks/:id'
```
**Path parameters:**
* solution_id: The unique id for the solution
* id: The unique id for a feedback item belonging to the solution

**Request body parameters:**
* feedback
* status: read or unread

**Request body example:**
```
{ "feedback":
  { "status": "read" }
}
```

**Success Response:**

Code: 200 </br>
Content:
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
**Error Response:**

Code: 400 </br>
