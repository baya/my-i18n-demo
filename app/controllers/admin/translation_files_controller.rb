class Admin::TranslationFilesController < ApplicationController

  def index
    @locales = I18n.backend.available_locales
    @key = 'hello_world'
  end

  def new
  end

  def create
    file = params[:file].tempfile
    errors = TranslationFile.load_to_backend(file)
    if errors.blank?
      redirect_to action: 'index'
    else
      flash[:error] = errors.map {|e| e.join(":")}.join(";")
      redirect_to action: 'new'
    end
  end
  
end
