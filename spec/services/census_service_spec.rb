require 'rails_helper'

describe "CensusService" do
  context "#get_users" do
    xit "returns an array of users as JSON objects" do
      VCR.use_cassette("#get_users") do
        users = CensusService.new(ENV["census_token"]).get_users
        user = users.first

        expect(users).to be_an(Array)
        expect(user).to have_key(:id)
        expect(user).to have_key(:first_name)
        expect(user).to have_key(:last_name)
        expect(user).to have_key(:cohort)
      end
    end
  end
  context "#get_one_user" do
    xit "returns a single user" do
      VCR.use_cassette("#get_one_user") do
        user = CensusService.new(ENV["census_token"]).get_one_user(55)
        expect(user).to be_a(Hash)
        expect(user[:first_name]).to eq("Anna")
        expect(user[:cohort]).to eq("1608-BE")
      end
    end
  end
end
