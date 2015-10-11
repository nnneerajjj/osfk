class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :status, :amount, :url
  has_one :user
end
