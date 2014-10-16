class NotificationMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  layout 'mailer'

  def email(user, date)
    @date = date
    @user = user
    @news = News.active.where(["created_at > ?", date])
    @topics = Topic.where(["created_at > ?", date])

    @comments = Comment.where(["created_at > ?", date])
    news_ids = @news.map(&:id)
    topic_ids = @topics.map(&:id)

    if news_ids.any? and topic_ids.any?
      @comments = Comment.where(["((commentable_type = 'Topic' and commentable_id not in (?)) or (commentable_type = 'News' and commentable_id not in (?))) and created_at > ?", topic_ids, news_ids, date])
    elsif topic_ids.any?
      @comments = Comment.where(["((commentable_type = 'Topic' and commentable_id not in (?)) or (commentable_type = 'News')) and created_at > ?", topic_ids, date])
    elsif news_ids.any?
      @comments = Comment.where(["((commentable_type = 'News' and commentable_id not in (?)) or (commentable_type = 'Topic')) and created_at > ?", news_ids, date])
    end

    commentables = @comments.group_by{|x| x.commentable}

    @old_news = commentables.select {|x| x.class == News}
    @old_topics = commentables.select {|x| x.class == Topic}

    @all_empty = @news.empty? && @topics.empty? && @comments.empty?

    mail to: user.email, subject: I18n.t(:notification_subject)
  end
end
