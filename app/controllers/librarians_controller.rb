class LibrariansController < ApplicationController
  before_action :set_librarian, only: %i[ show edit update destroy ]

  # GET /librarians or /librarians.json
  def index
    @librarians = Librarian.all
  end

  # GET /librarians/1 or /librarians/1.json
  def show
  end

  # GET /librarians/new
  def new
    @librarian = Librarian.new
  end

  # GET /librarians/1/edit
  def edit
  end

  # POST /librarians or /librarians.json
  def create
    @librarian = Librarian.new(librarian_params)

    respond_to do |format|
      if @librarian.save
        format.html { redirect_to @librarian, notice: "O bibliotecário foi criado com sucesso.", status: :see_other }
        format.json { render :show, status: :created, location: @librarian }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @librarian.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /librarians/1 or /librarians/1.json
  def update
    respond_to do |format|
      if @librarian.update(librarian_params)
        format.html { redirect_to @librarian, notice: "O bibliotecário foi atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @librarian }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @librarian.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /librarians/1 or /librarians/1.json
  def destroy
    @librarian.destroy!

    respond_to do |format|
      format.html { redirect_to librarians_path, notice: "O bibliotecário foi excluído com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def primeiro_acesso
  @librarian = Librarian.find(params[:id])
end

def atualizar_senha
  @librarian = Librarian.find(params[:id])

  if @librarian.update(password: params[:password], password_confirmation: params[:password_confirmation], first_access: false)
    session[:librarian_id] = @librarian.id
    redirect_to root_path, notice: "Senha atualizada com sucesso."
  else
    flash.now[:alert] = "As senhas não coincidem ou são inválidas."
    render :primeiro_acesso, status: :unprocessable_entity
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_librarian
      @librarian = Librarian.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
   def librarian_params
  params.require(:librarian).permit(:name, :email, :password, :password_confirmation, :first_access)
end
end
