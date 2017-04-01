class NewPostMailer < ApplicationMailer
  default from: ENV['gmail_sendname']


  # Sends email to all subscribers when new post is created.
  # Send the mail to the sending email address, and bcc all the subscribers.
  # Upside of this approach; it will just make one email action.
  # Downside; we won't be able to personalise the email.
  def send_to_subscribers(id)
    @post = Post.find(id)
    mail( to: ENV['gmail_username'],
          bcc: Subscriber.pluck(:email),
          subject: "Paul's Lovely Rails Blog: #{@post.title}")
  end


  # ToDo: Need to personalise these eventually, so we can add an 'unsubscribe' link.


  # Sends email to a specific subscriber.
  def send_to_one_subscriber(post_id, subscriber_id)
    @post = Post.find(post_id)
    @subscriber = Subscriber.find(subscriber_id)
    mail( to: @subscriber.email,
          subject: "Paul's Lovely Rails Blog: #{@post.title}")
  end


end
