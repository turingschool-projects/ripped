require "rails_helper"

describe "/exercises/:id" do
  it "user sees a form to submit a solution" do
    exercise = create(:exercise)
    visit exercise_path(exercise)

    click_on "Submit your solution"

    expect(current_path).to eq(new_exercise_solution_path(exercise))
    expect(page).to have_content("Paste solution here:")
    expect(page).to have_content("Submit Solution")
  end

  it "user can submit a solution" do
        exercise = create(:exercise)
        stub = stub_omniauth
        user = User.create!(census_id: stub.uid)
    
        visit '/'
        expect(page).to have_content('Login with Census')
    
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
        click_link "Login with Census"
        
        visit exercise_path(exercise)
    
        user_solution = "my solution"
    
        click_on "Submit your solution"
        fill_in "solution[content]", with: user_solution
        click_on "Submit Solution"
    
        solution = Solution.last
    
        expect(current_path).to eq(exercise_solution_path(exercise, solution))
  end
  
  it "user sees errors message if their solution does not submit" do
    exercise = create(:exercise)
    visit exercise_path(exercise)

    click_on "Submit your solution"
    click_on "Submit Solution"

    expect(page).to have_content("Your solution did not save.")
  end
end