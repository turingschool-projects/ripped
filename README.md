# Ripped

An Exercism-like application for the Turing School of Software and Design.

## Installation

 - clone down this repo `git clone https://github.com/turingschool-projects/ripped`
 - run `bundle install`
 - we're using a custom version of a gem for staging, so also run: `bundle update`
 - login is - at the moment - handled through [Census](https://github.com/turingschool-projects/census). as this is not yet in production you will probably need to stub out your users - we'll update as soon as this changes. You'll need Census access to run the app.
 * [Setting up the webhook](#setting-up-the-webhook)
  - [The file tree](#the-file-tree)
  - [The webhook](#the-webhook)
  - [GitHelper](#GitHelper)
  - [Additional Functionality](#additional-functionality)

## Using the app
Code of Arms is an Exercism-like application for the Turing School of Software and Design to help students practice coding and instructors give feedback in a streamlined manner.

To use Code of Arms, visit https://code-of-arms.herokuapp.com and log in with your [Census](https://turing-census.herokuapp.com) account. Upon login, you will see an index of all the available exercises. You can filter the exercise options using the buttons at the top of the page.

### Students

Click on an exercise name to see the full instructions and test suite that can be copied into your editor of choice. Once you pass all the tests, click on the "Submit your solution" button and copy/paste your answer into the form. After submitting your answer, your instructors and peers can leave feedback. Instructors will also be able to mark your answer as "Solved" or "Incorrect".

To see a summary of your feedback and exercises that have been marked "Solved" click on the "Dashboard" button in the navigation bar.

To leave feedback on your peers' solutions, click the "See all submissions" button from any Exercise detail page. If new feedback has been left on any of your submissions, the notifications button in the navigation will alert you.

### Instructors

Click on an exercise name to see the full instructions and test suite that can be copied into your editor of choice. Once a student passes the tests and has a solution, they can submit it via the "Submit" button on this page, and instructors will receive a notification in the navigation bar to alert that there is a new submission to review.

Instructors can access submissions directly from this notification, or by visiting the Dashboard. On the Dashboard, instructors will see a list of all submissions awaiting feedback and review. These can be filtered using the cohort buttons at the top of the page. Instructors can also see exercises that have already been marked as "Solved" or "Incorrect".

To review an exercise, choose a submission to review and leave feedback directly on the submission. There are also two buttons- one to mark the solutions as "Solved" and a second for "Incorrect."

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

# Setting Up the Webhook

## Setting Up the GitHub Webhook and API for Code of Arms

### The File Tree

Create the repo for the exercises you wish to upload. The file tree for the repo should be set up as shown below:

```
https://github.com/#{user_name}/#{repo_name}

-- #{user_name}
   |
    -- #{repo_name}
      |
      |
       -- ruby
      |
      |
       -- javascript
      |
      |
       -- bash
```

Each branch of the file tree shown above is a folder. Within each of these folders will exist folders or sub-directories that include the challenge and a description of that challenge.

```
-- #{user_name}
   |
    -- #{repo_name}
      |
      |
       -- ruby
      |    |
      |     -- hello_world
      |       |
      |        -- hello_world.rb
      |       |
      |        -- README.md
      |
       -- javascript
```

Each language folder should contain another collection of folders with the name of the exercise that folder will contain. In the example above, the name of the folder containing the 'hello_world.rb' test file and its README is named hello_world.

### The Webhook

When the repo is pushed after being updated on your local machine, a webhook that is set to the repo through the GitHub repos settings page will trigger a POST event to the github_webhooks_controller.rb file on your application. This route will hit the github_create action on that controller, which will set off a series of API calls to GitHub that require the setup of ENV variables for the application. Those environment variables are currently being set in the application.yml and will need to be manually updated in the environment on your server.

```ruby
class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

def github_create
    uri = URI("https://api.github.com/repos/#{ENV['GITHUB_USER']}/#{ENV['GITHUB_USER']}/contents/")
    GitHelper.get_directory_object(uri)
end
```

The URI in the controller is set to an API endpoint that returns the contents of the GitHub #{repo_name} as JSON.

```json

  {
    "name": "javascript",
    "path": "javascript",
    "sha": "5b6d28e46a0ece24bfbb2889359a53bf5e6d422b",
    "size": 0,
    "url": "https://api.github.com/repos/#{user_name}/#{repo_name}/contents/javascript?ref=master",
    "html_url": "https://github.com/#{user_name}/#{repo_name}/tree/master/javascript",
    "git_url": "https://api.github.com/repos/#{user_name}/#{repo_name}/git/trees/5b6d28e46a0ece24bfbb2889359a53bf5e6d422b",
    "download_url": null,
    "type": "dir",
    "_links": {
      "self": "https://api.github.com/repos/#{user_name}/#{repo_name}/contents/javascript?ref=master",
      "git": "https://api.github.com/repos/#{user_name}/#{repo_name}/git/trees/5b6d28e46a0ece24bfbb2889359a53bf5e6d422b",
      "html": "https://github.com/#{user_name}/#{repo_name}/tree/master/javascript"
    }
  }
```
This response is sent to the GitHelper where it is sent through a series of API calls that dig into the repo to retrieve the folders and files that will be parsed and saved to the database.

### GitHelper

The first method, get_directory_object uses the URI from the controller and pulls down an object that contains the language folders (the snippet above is an example of that return, however it only includes one language folder). The next method, get_language_folder iterates over that object of language folders. That folder name is sent to the get_and_save_exercise method with the exercise_object that is parsed from the folder request (we are going to carry the folder name with us through the methods to use in our update and create methods at the bottom of the script).

Each method sends its child to the next, digging one level deeper into the repo each time. The retrieve_lesson_content method iterates over the last folder in the file tree and selects the exercise file and the README file within it. The exercise_items hash is then created with keys that point to each attribute the exercise object in your database requires.

```ruby
create_table "exercises", force: :cascade do |t|
    t.text     "name"
    t.text     "content"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "description"
    t.integer  "status",      default: 0
end  
```

The name for the exercise is corrected from the file name that is pulled out of the repo. The content of the exercise is pulled from the text of the exercise file within the repo using the URI in the retrieve_lesson_content method. This URI differs from the URIs used to make the initial API calls to the GitHub repo. Finally, the description text comes from the README file that is pushed up with the exercise. This file should contain instructions for the student on how to complete the exercise.

```ruby
exercise_item = {name: "Hello World",
                 content: "This is where the code goes",
                 description: "This explains what the exercise is for"})
```

This is where the folder object we have passed through each method is now used. If you recall, the folder variable was set to the name of the folder in the block in the get_language_folder method. We pass this through the module because the name of that folder is the same as the language the exercise is written in. We use that string, in this case "javascript", to build the tag for the exercise that is going to be created and generate a collection of the exercises that already exist in your database for that language.

```ruby
def self.find_tags_and_save(exercise_items, folder)
  corrected_name = exercise_items[:name].split('.')[0].titleize
  match = Exercise.joins(:tags).where({ tags: {name: folder} })
  exercise = Exercise.find_by(name: corrected_name)
  if match.include?(exercise)
  ...
end
```

In the find_tags_and_save method we use an ActiveRecord join clause to create an object that searches our database for all records that use the "javascript" or folder tag. This object is called 'match'. We then search the database for the exercise by name and match that return against the collection of exercises of the same type. If the exercise exists, the method updates the exercise in the database, otherwise the object is created in the database.

### Additional Functionality

The goal for the Webhook functionality needs to be expanded to include updating the tags of the exercises and deleting or un-publishing exercises through the push. In its current state, if an instructor pushes the exercises repo, the module is unable to update the published and unpublished status of the exercise (in our exercise table, we don't delete exercises through the application, we have provided functionality to only publish or un-publish exercises, this determines if they appear on the show and index pages.) Adding dynamic tag update and creating for the difficulty levels could be done through formatting the READMEs of the exercises so they include metadata that is parsed out the description and carried into the update/create methods.
