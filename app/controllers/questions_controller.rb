class QuestionsController < ApplicationController
  def index 
    @questions = Question.all

    render json: @questions, status: :ok
  end
  def show
    @question = Question.find(params[:id])

    render json: @question, status: :ok
  end
  def create
    @question = Question.new(question_params)

    @question.save
    render json: @question, status: :created
  end

  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
