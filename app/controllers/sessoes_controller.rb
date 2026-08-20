class SessoesController < ApplicationController
  def new
  end

  def create
    librarian = Librarian.find_by(email: params[:email])

    if librarian && librarian.authenticate(params[:senha])
      session[:librarian_id] = librarian.id

      if librarian.first_access
        redirect_to primeiro_acesso_path(librarian), notice: "Defina sua nova senha."
      else
        redirect_to root_path, notice: "Login realizado com sucesso."
      end
    else
      flash.now[:alert] = "E-mail ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end
  
  def esqueci_senha
end

def enviar_recuperacao
  librarian = Librarian.find_by(email: params[:email])

  if librarian
    nova_senha = SecureRandom.hex(4)
    librarian.update(password: nova_senha, first_access: true)
    LibrarianMailer.reset_password(librarian, nova_senha).deliver_now
    redirect_to login_path, notice: "Uma nova senha foi enviada para seu e-mail."
  else
    flash.now[:alert] = "E-mail não encontrado."
    render :esqueci_senha, status: :unprocessable_entity
  end
end

  def destroy
    session[:librarian_id] = nil
    redirect_to login_path, notice: "Você saiu do sistema."
  end
end