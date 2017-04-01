# Preview all emails at http://localhost:3000/rails/mailers/new_post_mailer
class NewPostMailerPreview < ActionMailer::Preview
  def send_to_subscribers
    NewPostMailer.send_to_subscribers(Post.first.id)
  end
  def send_to_one_subscriber
    NewPostMailer.send_to_one_subscriber(Post.first.id, Subscriber.first.id)
  end
end
