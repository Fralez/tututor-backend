class QuestionsController < ApplicationController
  before_action :authorize_request, except: %i[index show search_question]

  def index
    @questions = Question.all.map { |q| q.attributes.merge({ creator: q.creator }) }

    render json: @questions.as_json,
           status: :ok
  end

  def show
    @question = Question.find_by(id: params[:id])

    if @question
      render json: { question: @question.as_json
                                        .merge(creator: User.find(@question.user_id)
                                        .as_json) },
             status: :ok
    else
      not_found
    end
  end

  def create
    @question = Question.new(question_params.merge(user_id: @current_user.id))

    if @question.save
      render json: { question: @question.as_json },
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
    render json: { question: @question.as_json },
           status: :created
  end

  def search_question
    q = params[:q]
    @questions = Question.where('title ILIKE ?', "%#{q}%")
    render json: { questions: @questions.as_json },
           status: :ok
  end

  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
