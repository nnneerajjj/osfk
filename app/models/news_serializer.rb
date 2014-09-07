class NewsSerializer < ActiveModel::Serializer
  attributes :id, :subject, :content, :path, :errors

  def path
    news_path(object) if object.persisted?
  end

  def errors
    object.errors.full_messages.join(', ')
  end
end
