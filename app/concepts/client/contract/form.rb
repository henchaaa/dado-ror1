# frozen_string_literal: true

module Client::Contract
  class Form < Reform::Form
    model(Client)

    property :first_name
    property :last_name
    property :phone_prefix
    property :phone_number
    property :email
  end
end
