class LetterSerializer < ActiveModel::Serializer
  attributes :id, :subject, :content, :path, :errors, :link

  def path
    letter_path(object) if object.persisted?
  end

  def errors
    object.errors.full_messages.join(', ')
  end
end
