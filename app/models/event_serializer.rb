class EventSerializer < ActiveModel::Serializer
  attributes :id, :subject, :content, :start_date, :path, :errors

  def path
    event_path(object) if object.persisted?
  end

  def errors
    object.errors.full_messages.join(', ')
  end
end
