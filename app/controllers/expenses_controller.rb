class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id]) if params[:category_id].present?

    @expenses = if @category
                  @category.expenses.includes(:user)
                else
                  current_user.expenses.includes(:category)
                end
  end

  def new
    @category = Category.find(params[:category_id]) if params[:category_id].present?
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)
  
    if @expense.save
      if params[:category_id].present?
        @category = Category.find(params[:category_id])
        @category.expenses << @expense
        redirect_to category_expenses_path(@category), notice: 'Expense created successfully'
      else
        redirect_to expenses_path, notice: 'Expense created successfully'
      end
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
