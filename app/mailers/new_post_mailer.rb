class NewPostMailer < ApplicationMailer
  default from: ENV['gmail_sendname']

  # Sends email to a specific subscriber.
  def send_to_one_subscriber(post_id, subscriber_id)
    @post = Post.find(post_id)
    @subscriber = Subscriber.find(subscriber_id)
    @unsubscribe_hash = Rails.application.message_verifier(:unsubscribe).generate(subscriber_id)
    mail( to: @subscriber.email,
          subject: "Paul's Lovely Rails Blog: #{@post.title}")
  end

end
