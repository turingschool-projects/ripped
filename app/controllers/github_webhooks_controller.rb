class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor


  def github_push

  end


  def github_create
    uri = URI('https://api.github.com/repos/NZenitram/exercises/contents/')
    binding.pry
    GitHelper.get_object(uri)
  end

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end
