class UserSessionsController < ApplicationController

before_filter :require_no_authentication, :only => [:new, :create]  
before_filter :require_authentication, :only => :destroy

  def new 
    @session = UserSession.new(session) 
  end

  def create
    @session = UserSession.new(session,user_session_params)
    if @session.authenticate
      #Não esqueça de adicionar a chave no i18n!
      redirect_to root_path, :notice => t('flash.notice.signed_in')
    else
      render :new
    end
  end

=begin
metodo do controle que chama o método que destroi a sessão do usuário.
E rediciona usuário para página principal
=end
  def destroy
    user_session.destroy   
    redirect_to root_path, notice: t('flash.notice.signed_out')
  end 
  
private
 
  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end

end
