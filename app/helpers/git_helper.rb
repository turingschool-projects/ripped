module GitHelper

  def self.get_directory_object(uri)
    request_directory = Net::HTTP.get(uri)
    list_of_languages = JSON.parse(request_directory, symbolize_names: true)
    get_language_folder(list_of_languages)
  end

  def get_language_folder(list_of_languages)
    list_of_languages.each do |lang|
      @folder = lang[:name]
      uri = URI("https://api.github.com/repos/NZenitram/exercises/contents/#{folder}")
      language_folder = Net::HTTP.get(uri)
      exercise_object = JSON.parse(language_folder, symbolize_names: true)
      get_and_save_exercise(exercise_object)
    end
  end

  def get_and_save_exercise(exercise_object)
    exercise_object.each do |exercise_folder|
      exercise = exercise_folder[:name]
      uriURI("https://api.github.com/repos/NZenitram/exercises/contents/#{folder}/#{exercise}")
      exercise_folder = Net::HTTP.get(uri)
      lesson_folder = JSON.parse(exercise_folder, symbolize_names: true)
      retrieve_lesson_content(lesson_folder)
    end
  end

  def retrieve_lesson_content(lesson_folder)
    exercise_items = {}
    lesson_folder.each do |exercise_name|
      name = exercise_name[:name]
      uri = URI("https://raw.githubusercontent.com/NZenitram/exercises/master/#{folder}/#{exercise}/#{name}")
      if name == "README.md"
        text = Net::HTTP.get(uri)
        exercise_items[:description] = text
      else
        exercise = Net::HTTP.get(uri)
        exercise_items[:content] = exercise
        exercise_items[:name] = name
      end
      find_tags_and_save(exercise_items)
    end
  end

  def find_tags_and_save(exercise_items)
    language_tag = Tag.find_by(name: @folder)
    difficulty = Tag.first
    exercise = Exercise.new(name: exercise_items[:name], content: exercise_items[:content], description: exercise_items[:description])
    exercise.tags = [language_tag, difficulty]
    exercise.save
  end
end
