class NewPostMailer < ApplicationMailer
  default from: ENV['gmail_sendname'],
          to:   ENV['gmail_username'],
          bcc:  Proc.new { Subscriber.pluck(:email) }


  # Sends email to all subscribers when new post is created.
  # Send the mail to the sending email address, and bcc all the subscribers.
  # Upside of this approach; it will just make one email action.
  # Downside; we won't be able to personalise the email.
  def send_to_subscribers(id)
    @post = Post.find(id)
    mail(subject: "Paul's Lovely Rails Blog: #{@post.title}")
  end


  # ToDo: Need to personalise these eventually, so we can add an 'unsubscribe' link.


end
