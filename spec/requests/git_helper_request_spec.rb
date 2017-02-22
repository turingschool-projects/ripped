require 'rails_helper'

describe 'POST request hits first GitHub endpoint'do
  context 'it returns directory object' do
    it 'returns response success', :vcr do

      uri = URI('https://api.github.com/repos/NZenitram/exercises/contents/')
      GitHelper.get_directory_object(uri)


    end
  end
end
