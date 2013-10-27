class NotificationMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  add_template_helper(NotificationHelper)

  default from: "\"BRF Caraten\" <kontakt@brfcaraten.se>"

  def email(user, date)
    @date = date
    @user = user
    @news = News.where(["created_at > ?", date])
    @topics = Topic.where(["created_at > ?", date])

    news_ids = @news.map(&:id)
    topic_ids = @topics.map(&:id)
    @comments = Comment.where(["((commentable_type = 'Topic' and commentable_id not in (?)) or (commentable_type = 'News' and commentable_id not in (?))) and created_at > ?", topic_ids, news_ids, date])
    commentables = @comments.group_by{|x| x.commentable}

    @old_news = commentables.select {|x| x.class == News}
    @old_topics = commentables.select {|x| x.class == Topic}

    @all_empty = @news.empty? && @topics.empty? && @comments.empty?

    mail to: user.email, subject: I18n.t(:notification_subject)
  end
end
