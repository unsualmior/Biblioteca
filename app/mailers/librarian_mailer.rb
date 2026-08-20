class LibrarianMailer < ApplicationMailer
  def reset_password(librarian, new_password)
    @librarian = librarian
    @new_password = new_password
    mail(to: @librarian.email, subject: "Recuperação de senha - Biblioteca Ney Pontes")
  end
end