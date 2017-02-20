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
            folder = JSON.parse(exercise_folder, symbolize_names: true)
              folder.each do |exercise_name|
                name = exercise_name[:name]
                binding.pry
                uri = URI("https://api.github.com/repos/NZenitram/exercises/contents/#{folder}/#{exercise}/#{name}")
                readme = URI("https://api.github.com/repos/NZenitram/exercises/contents/#{folder}/#{exercise}/README.md")
                lesson = Net::HTTP.get(uri)
                description = Net::HTTP.get(uri)
              end
              binding.pry
          end
      end
  end

  def get_files_ruby
    binding.pry
  end



end
