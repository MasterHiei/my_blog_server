# frozen_string_literal: true

# Article Model
class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :content, type: String
  field :type, type: String
  field :tags, type: Array, default: 0
  field :stars, type: Integer
  field :created_by, type: String
end
