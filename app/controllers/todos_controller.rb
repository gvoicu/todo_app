class TodosController < ApplicationController
  # action
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create

    todo = Todo.new(todo_params)
    if todo.save
      flash[:notice] = "Todo was saved successfully"
    else
      flash[:notice] = "Unfortunately there were some errors while saving the todo: #{todo.errors.to_s}"
    end

    redirect_to "/todos"
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end
end
