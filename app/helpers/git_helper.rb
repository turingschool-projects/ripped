module GitHelper

  def self.get_object(uri)
    json_string = Net::HTTP.get(uri)
    file_array = JSON.parse(json_string, symbolize_names: true)
    names_array = file_array.map do |file|
      file[:name]
    end
    get_files(names_array)
  end

  def self.get_files(names_array)
    names_array.each do |name|
      uri = URI("https://raw.githubusercontent.com/NZenitram/exercises/master/#{name}")
    end

  end

end
