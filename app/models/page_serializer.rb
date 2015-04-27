class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :path, :errors

  def path
    object.path if object.persisted?
  end

  def errors
    object.errors.full_messages.join(', ')
  end
end
