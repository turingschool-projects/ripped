module GitHelper

  def self.get_directory_object(uri)
    json_string = Net::HTTP.get(uri)
    dir_object = JSON.parse(json_string, symbolize_names: true)
    dir_object.each do |lang|
      folder = lang[:name]
      uri = URI("https://api.github.com/repos/NZenitram/exercises/contents/#{folder}")
        language_folder = Net::HTTP.get(uri)
        exercise_object = JSON.parse(language_folder, symbolize_names: true)
          exercise_object.each do |exercise_folder|
            exercise = exercise_folder[:name]
            uri = URI("https://api.github.com/repos/NZenitram/exercises/contents/#{folder}/#{exercise}")
            exercise_folder = Net::HTTP.get(uri)
            lesson_folder = JSON.parse(exercise_folder, symbolize_names: true)
            new_test = {}
              lesson_folder.each do |exercise_name|
                name = exercise_name[:name]
                uri = URI("https://raw.githubusercontent.com/NZenitram/exercises/master/#{folder}/#{exercise}/#{name}")
                if name == "README.md"
                  text = Net::HTTP.get(uri)
                  new_test[:description] = text
                else
                  exercise = Net::HTTP.get(uri)
                  new_test[:content] = exercise
                  new_test[:name] = name
                end
              end
              tag = Tag.find_by(name: folder)
              difficulty = Tag.first
              j_cas = Exercise.new(name: new_test[:name], content: new_test[:content], description: new_test[:description])
              j_cas.tags = [tag, difficulty]
              j_cas.save
          end
      end
  end

end
