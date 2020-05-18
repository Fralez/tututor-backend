class QuestionsController < ApplicationController
  before_action :authorize_request, except: [:index, :show]

  def index 
    @questions = Question.all

    render json: Question.all.as_json(except: %i[created_at updated_at]),
           status: :ok
  end

  def show
    @question = Question.find_by(id: params[:id])

    if @question
      render json: { question: @question.as_json(except: %i[created_at updated_at]) }, status: :ok
    else
      not_found
    end
  end

  def create
    @question = Question.new(question_params.merge(user_id: @current_user.id))

    if @question.save
      render json: { question: @question.as_json(except: %i[created_at updated_at]) },
             status: :created
    else
      render json: { errors: @question.errors.full_messages },
             status: :unprocessable_entity
    end 
  end

  def vote_question
    @question = Question.find_by(id: params[:id])
    new_vote = params[:vote]

    @question.update!(votes: @question.votes + new_vote)
    render json: { question: @question.as_json(except: %i[created_at updated_at]) },
           status: :created
  end

  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
