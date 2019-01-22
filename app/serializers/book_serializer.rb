class BookSerializer < ActiveModel::Serializer
  attributes :id, :name, :campsite_id
end
