class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :library_user
end
