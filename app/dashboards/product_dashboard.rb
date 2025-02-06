require 'administrate/base_dashboard'

class ProductDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    description: Field::Text,
    image: Field::ActiveStorage,
    name: Field::String,
    price: Field::Number.with_options(
      searchable: false,
      prefix: '$',
      decimals: 2
    ),
    quantity: Field::Number,
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
    id
    name
    description
    price
    quantity
    image
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    description
    price
    quantity
    image
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
