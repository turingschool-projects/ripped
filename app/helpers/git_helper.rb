module GitHelper

  def self.get_directory_object(uri)
    request_directory = Net::HTTP.get(uri)
    list_of_languages = JSON.parse(request_directory, symbolize_names: true)
    get_language_folder(list_of_languages)
  end

  def self.get_language_folder(list_of_languages)
    list_of_languages.each do |lang|
      folder = lang[:name]
      uri = URI("https://api.github.com/repos/#{ENV['GITHUB_USER']}/#{ENV['GITHUB_REPO']}/contents/#{folder}")
      language_folder = Net::HTTP.get(uri)
      exercise_object = JSON.parse(language_folder, symbolize_names: true)
      get_and_save_exercise(exercise_object, folder)
    end
  end

  def self.get_and_save_exercise(exercise_object, folder)
    exercise_object.each do |exercise_folder|
      exercise = exercise_folder[:name]
      uri = URI("https://api.github.com/repos/#{ENV['GITHUB_USER']}/#{ENV['GITHUB_REPO']}/contents/#{folder}/#{exercise}")
      exercise_folder = Net::HTTP.get(uri)
      lesson_folder = JSON.parse(exercise_folder, symbolize_names: true)
      retrieve_lesson_content(lesson_folder, folder, exercise)
    end
  end

  def self.retrieve_lesson_content(lesson_folder, folder, exercise)
    exercise_items = {}
    lesson_folder.each do |exercise_name|
      name = exercise_name[:name]
      uri = URI("https://raw.githubusercontent.com/#{ENV['GITHUB_USER']}/#{ENV['GITHUB_REPO']}/master/#{folder}/#{exercise}/#{name}")
      if name == "README.md"
        text = Net::HTTP.get(uri)
        exercise_items[:description] = text
      else
        exercise = Net::HTTP.get(uri)
        exercise_items[:content] = exercise
        exercise_items[:name] = name
      end
      exercise_items
    end
    find_tags_and_save(exercise_items, folder)
  end

  def self.find_tags_and_save(exercise_items, folder)
    corrected_name = exercise_items[:name].split('.')[0].titleize
    match = Exercise.joins(:tags).where({ tags: {name: folder} })
    exercise = Exercise.find_by(name: corrected_name)
    if match.include?(exercise)
      exercise.update(name: corrected_name, content: exercise_items[:content], description: exercise_items[:description]).save
    else
      new_exercise = Exercise.new(name: corrected_name, content: exercise_items[:content], description: exercise_items[:description])
      language_tag = Tag.find_by(name: folder)
      difficulty = Tag.first
      new_exercise.tags = [language_tag, difficulty]
      new_exercise.save
    end
  end
end
