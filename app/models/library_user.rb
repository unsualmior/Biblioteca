class LibraryUser < ApplicationRecord
    has_many :loans
  validates :cpf, presence: true, uniqueness: true
  validates :full_name, :phone, :email, presence: true

  before_create :generate_loan_password

  private

  def generate_loan_password
    self.loan_password = SecureRandom.hex(4) # gera algo tipo "a1b2c3d4"
  end
end