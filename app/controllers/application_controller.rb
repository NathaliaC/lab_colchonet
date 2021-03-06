class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  delegate :current_user, :user_signed_in?, :to => :user_session
  helper_method :current_user, :user_signed_in?

  protect_from_forgery # with: :exception

  before_filter :set_locale
  

  def set_locale
    I18n.locale = params[:locale] ||  I18n.default_locale
  end

  def default_url_options
    { :locale => I18n.locale}
  end
  
  def user_session
    UserSession.new(session)
  end

=begin
Filtro Força a autenticação do usuário, caso o mesmo não esteja logado redireciona para a página de login, caso contrário não faz nada.
=end
  def require_authentication
    unless user_signed_in?
      redirect_to new_user_sessions_path, :alert => t('flash.alert.needs_login')
    end
  end 
=begin
Filtro para evitar que usuários já cadastrados, acessem páginas que só deveram ser acessados por usuários que não possuem login.
=end
  def require_no_authentication
    redirect_to root_path if user_signed_in?
  end
end
