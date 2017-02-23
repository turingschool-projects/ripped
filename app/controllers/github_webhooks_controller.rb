class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor


  def github_push

  end


  def github_create
    uri = URI("https://api.github.com/repos/#{ENV['GITHUB_USER']}/#{ENV['GITHUB_REPO']}/contents/")
    GitHelper.get_directory_object(uri)
  end

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end
