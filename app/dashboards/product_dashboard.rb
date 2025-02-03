require "administrate/base_dashboard"

class ProductDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    price: Field::Number.with_options(prefix: "$", decimals: 2),
    quantity: Field::Number,
    # image: Field::ActiveStorage,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    price
    quantity
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    name
    description
    price
    quantity
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    description
    price
    quantity
  ].freeze
end
