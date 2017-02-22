require 'rails_helper'

context 'GitHelper' do
  describe 'after the API reponse' do
    it 'saves the exercise' do
      VCR.turn_off!
      WebMock.disable!

      Tag.create([{name: 'easy'}, {name: 'medium'}, {name: 'hard'}, {name: 'javascript'}, {name: 'ruby'}])

      exercise_items = {name: "Hello Test", content: "This is where the code goes", description: "This explains what the exercise is for"}
      folder = "ruby"

      GitHelper.find_tags_and_save(exercise_items, folder)

      lessons = Exercise.all

      expect(lessons.first.name).to eq(exercise_items[:name])
      expect(lessons.count).to eq(1)
    end
  end

  describe 'after the API reponse' do
    it 'it wont save the the same exercise twice' do
      VCR.turn_off!
      WebMock.disable!
      folder = "ruby"

      Tag.create([{name: 'easy'}, {name: 'medium'}, {name: 'hard'}, {name: 'javascript'}, {name: 'ruby'}])

      first_exercise = Exercise.create({name: "Hello Test", content: "This is where the code goes", description: "This explains what the exercise is for"})
      language_tag = Tag.find_by(name: folder)
      difficulty = Tag.first
      first_exercise.tags = [language_tag, difficulty]

      exercise_items = {name: "Hello Test", content: "This is where the code goes", description: "This explains what the exercise is for"}

      GitHelper.find_tags_and_save(exercise_items, folder)

      lessons = Exercise.all

      expect(lessons.first.name).to eq(exercise_items[:name])
      expect(lessons.count).to eq(1)
    end
  end
end
