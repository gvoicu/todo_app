class TodosController < ApplicationController
  # action
  def index
    if session[:todos].nil?
      session[:todos] = []
    end

    @todos = session[:todos]
  end

  def new

  end

  def create
    new_todo = {
                :title => params[:title],
                :assigned_to => params[:assigned_to]
               }

    session[:todos] << new_todo

    redirect_to "/todos"
  end
end
