class Profile
  attr_reader :first_name, :last_name, :cohort

  def initialize(attributes={})
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @cohort = attributes[:cohort]
  end

  def self.find_user(token, id)
    user = CensusService.new(token).get_one_user(id)
    Profile.new(user)
  end

  def self.all_users(token)
    service = CensusService.new(token)
    users = service.get_users
    users.map do |user|
      Profile.new(user)
    end
  end

end
