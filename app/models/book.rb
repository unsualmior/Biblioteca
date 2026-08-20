class Book < ApplicationRecord
  belongs_to :category
  has_many :loans, dependent: :destroy

  validates :status, inclusion: { in: ["disponivel", "emprestado"] }
end