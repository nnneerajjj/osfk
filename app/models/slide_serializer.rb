class SlideSerializer < ActiveModel::Serializer
  attributes :id, :header, :header2, :content, :errors, :link, :path

  def path
    slides_path if object.persisted?
  end

  def errors
    object.errors.full_messages.join(', ')
  end
end
