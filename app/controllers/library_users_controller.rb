class LibraryUsersController < ApplicationController
  before_action :require_login
  before_action :set_library_user, only: %i[ show edit update destroy ]

  # GET /library_users or /library_users.json
  def index
    @library_users = LibraryUser.all
  end

  # GET /library_users/1 or /library_users/1.json
  def show
  end

  # GET /library_users/new
  def new
    @library_user = LibraryUser.new
  end

  # GET /library_users/1/edit
  def edit
  end

  # POST /library_users or /library_users.json
  def create
    @library_user = LibraryUser.new(library_user_params)

    respond_to do |format|
      if @library_user.save
        format.html { redirect_to @library_user, notice: "Library user was successfully created." }
        format.json { render :show, status: :created, location: @library_user }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @library_user.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /library_users/1 or /library_users/1.json
  def update
    respond_to do |format|
      if @library_user.update(library_user_params)
        format.html { redirect_to @library_user, notice: "Library user was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @library_user }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @library_user.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /library_users/1 or /library_users/1.json
  def destroy
    @library_user.destroy!

    respond_to do |format|
      format.html { redirect_to library_users_path, notice: "Library user was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library_user
      @library_user = LibraryUser.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def library_user_params
      params.expect(library_user: [ :full_name, :cpf, :phone, :email])
    end
end
