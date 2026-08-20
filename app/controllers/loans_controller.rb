class LoansController < ApplicationController
  before_action :require_login

  def index
    @loans = Loan.all.order(created_at: :desc)
  end

  def new
    @book = Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:book_id])
    library_user = LibraryUser.find_by(cpf: params[:cpf])

    # se o usuário não existe, redireciona para cadastro
    unless library_user
      redirect_to new_library_user_path, alert: "Usuário não encontrado. Cadastre-o primeiro."
      return
    end

    # valida a senha de empréstimo
    unless library_user.loan_password == params[:loan_password]
      redirect_to new_book_loan_path(@book), alert: "Senha de empréstimo incorreta."
      return
    end

    if @book.status != "disponivel"
      redirect_to new_book_loan_path(@book), alert: "Este livro não está disponível."
      return
    end

    loan = Loan.new(
      book: @book,
      library_user: library_user,
      loan_date: Date.today,
      due_date: 15.days.from_now,
      returned: false
    )

    if loan.save
      @book.update(status: "emprestado")
      redirect_to loans_path, notice: "Empréstimo realizado com sucesso. Devolução até #{loan.due_date.strftime('%d/%m/%Y')}."
    else
      redirect_to new_book_loan_path(@book), alert: "Erro ao registrar empréstimo."
    end
  end

  def return_book
    loan = Loan.find(params[:id])
    loan.update(returned: true, returned_at: Date.today)
    loan.book.update(status: "disponivel")
    redirect_to loans_path, notice: "Devolução registrada com sucesso."
  end
end