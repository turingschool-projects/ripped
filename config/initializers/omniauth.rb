Rails.application.config.middleware.use OmniAuth::Builder do
  provider :census, "CENSUS_ID", "CENSUS_SECRET", {
    :name => "census"
  }
end
