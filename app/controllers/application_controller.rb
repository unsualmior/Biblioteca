class ApplicationController < ActionController::Base
  before_action :current_librarian

  allow_browser versions: :modern

  stale_when_importmap_changes

  private

  def current_librarian
    @current_librarian ||= Librarian.find_by(id: session[:librarian_id])
  end
  helper_method :current_librarian

  def require_login
    unless current_librarian
      redirect_to login_path, alert: "Você precisa fazer login para acessar essa página."
    end
  end
end