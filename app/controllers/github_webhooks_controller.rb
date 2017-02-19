class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor


  def github_push

  end


  def github_create

  end

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end
