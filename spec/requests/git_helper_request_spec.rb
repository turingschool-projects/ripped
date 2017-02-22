require 'rails_helper'

describe 'request returns GitHub Objec' do
  before(:each) do
    Tag.create([{name: 'easy'}, {name: 'medium'}, {name: 'hard'}, {name: 'javascript'}, {name: 'ruby'}])
    User.create(census_id: 66, role: 0, first_name: 'User', last_name: 'RippedTest', token: '1d7ff31ba472ed175978ac864cb9b74076208bb9b38798c42e14a0817f804a1b')
  end

  context 'it returns directory object' do
    it 'returns list of languages as an array' do
      VCR.turn_off!
      WebMock.disable!

      uri = URI('https://api.github.com/repos/NZenitram/exercises/contents/')
      request_directory = Net::HTTP.get(uri)
      list_of_languages = JSON.parse(request_directory, symbolize_names: true)

      expect(list_of_languages.class).to eq(Array)
      expect(list_of_languages.first.class).to eq(Hash)

    end
  end

  context 'it returns exercise object' do
    it 'returns list of exercises for a language as an array' do
      VCR.turn_off!
      WebMock.disable!

      uri = URI('https://api.github.com/repos/NZenitram/exercises/contents/ruby')
      language_folder = Net::HTTP.get(uri)
      exercise_object = JSON.parse(language_folder, symbolize_names: true)

      expect(exercise_object.class).to eq(Array)
      expect(exercise_object.first.class).to eq(Hash)
    end
  end

  context 'it returns a lesson' do
    it 'returns the lesson in the exercises folder' do
      VCR.turn_off!
      WebMock.disable!

      uri = URI('https://api.github.com/repos/NZenitram/exercises/contents/ruby/hello_world/README.md')
      language_folder = Net::HTTP.get(uri)
      lesson_object = JSON.parse(language_folder, symbolize_names: true)

      expect(lesson_object.class).to eq(Hash)
      expect(lesson_object.first[1]).to eq("README.md")
    end
  end
end
